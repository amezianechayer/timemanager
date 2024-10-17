<template>
  <HeaderComponent />
  <div class="hours-tracking-container">
    <h1>Suivi des Heures - Arkham Tracker</h1>


    <div class="filter-container">
      <label for="user-select" class="text-black">Filtrer par employé : </label>
      <select id="user-select" v-model="selectedUser" @change="filterEmployees">
        <option value="all">Tous les utilisateurs</option>
        <option v-for="employee in employees" :key="employee.id" :value="employee.id">
          {{ employee.username }}
        </option>
      </select>
    </div>

    <table>
      <thead>
      <tr>
        <th>Nom de l'employé</th>
        <th>Heures travaillées</th>
        <th>Heures requises</th>
        <th>Statut</th>
      </tr>
      </thead>
      <tbody>
      <tr v-for="employee in filteredEmployees" :key="employee.id">
        <td>{{ employee.username }}</td>
        <td>{{ employee.totalHours || '00:00:00' }}</td>
        <td>
          {{ employee.hoursRequiredFormatted || '' }}
          <button v-if="!employee.hoursRequired" @click="openAddHoursPopup(employee)">Ajouter des heures</button>
        </td>
        <td :class="{'overdue': isOverdue(employee)}">
          {{ isOverdue(employee) ? 'Retard' : 'À jour' }}
        </td>
      </tr>
      </tbody>
    </table>


    <div v-if="showPopup" class="popup">
      <div class="popup-content">
        <h2>Ajouter des heures requises pour {{ selectedEmployee.username }}</h2>
        <label for="hours">Heures:</label>
        <input type="number" v-model="hoursToAdd.hours" min="0">

        <label for="minutes">Minutes:</label>
        <input type="number" v-model="hoursToAdd.minutes" min="0" max="59">

        <label for="seconds">Secondes:</label>
        <input type="number" v-model="hoursToAdd.seconds" min="0" max="59">

        <button @click="addRequiredHours">Ajouter</button>
        <button @click="showPopup = false">Annuler</button>
      </div>
    </div>
  </div>
</template>

<script>
import HeaderComponent from "@/components/HeaderComponent.vue";
import axios from 'axios';

export default {
  components: { HeaderComponent },
  data() {
    return {
      employees: [], // Liste des utilisateurs récupérée depuis l'API
      selectedUser: 'all', // Par défaut, on affiche tous les utilisateurs
      filteredEmployees: [], // Liste filtrée d'utilisateurs
      showPopup: false, // Contrôle l'affichage de la popup
      selectedEmployee: null, // Stocke l'employé sélectionné
      hoursToAdd: { hours: 0, minutes: 0, seconds: 0 }, // Stocke les heures à ajouter
      isButtonDisabled: false // Propriété pour contrôler l'état du bouton
    };
  },
  methods: {
    async fetchEmployees() {
      try {
        const response = await axios.get('http://localhost:4000/api/users');
        this.employees = response.data.data;
        await this.calculateTotalHours(); // Calcule les heures après la récupération des employés
        this.filteredEmployees = this.employees; // Initialement, on affiche tous les utilisateurs
      } catch (error) {
        console.error('Erreur lors de la récupération des utilisateurs:', error);
      }
    },
    async calculateTotalHours() {
      await Promise.all(this.employees.map(async employee => {
        employee.totalHours = await this.getTotalHours(employee.id);
      }));
    },
    async getTotalHours(userId) {
      try {
        const response = await axios.get(`http://localhost:4000/api/clocks/${userId}`);
        const clocks = response.data.data;

        const totalSeconds = clocks.reduce((total, clock) => {
          const seconds = this.convertTimeToSeconds(clock.time); // Modification ici
          return total + seconds;
        }, 0);

        return this.convertSecondsToTime(totalSeconds); // Modification ici
      } catch (error) {
        console.error('Erreur lors de la récupération des heures:', error);
        return '00:00:00'; // Mise à jour pour inclure les secondes
      }
    },
    convertTimeToSeconds(time) {
      const regex = /(\d+):(\d+):(\d+)|(\d+)H(\d+)/; // Regex pour matcher HH:MM:SS ou HHH:MM
      const match = time.match(regex);

      if (match) {
        const hours = match[1] ? parseInt(match[1]) : parseInt(match[3]) || 0;
        const minutes = match[2] ? parseInt(match[2]) : parseInt(match[4]) || 0;
        const seconds = match[3] ? parseInt(match[3]) : 0; // Ajout de la gestion des secondes
        return (hours * 3600) + (minutes * 60) + seconds; // Convertit en secondes
      }
      return 0; // Si le format ne correspond pas, retourne 0
    },
    convertSecondsToTime(totalSeconds) {
      const hours = Math.floor(totalSeconds / 3600);
      const minutes = Math.floor((totalSeconds % 3600) / 60);
      const seconds = totalSeconds % 60;
      return `${String(hours).padStart(2, '0')}:${String(minutes).padStart(2, '0')}:${String(seconds).padStart(2, '0')}`; // Format HH:MM:SS
    },
    filterEmployees() {
      if (this.selectedUser === 'all') {
        this.filteredEmployees = this.employees; // Affiche tous les utilisateurs si "Tous les utilisateurs" est sélectionné
      } else {
        this.filteredEmployees = this.employees.filter(employee => employee.id === parseInt(this.selectedUser)); // Filtre par l'utilisateur sélectionné
      }
    },
    isOverdue(employee) {
      return employee.totalHours < employee.hoursRequired; // Détermine si l'employé est en retard
    },
    openAddHoursPopup(employee) {
      this.selectedEmployee = employee; // Conserve l'employé sélectionné
      this.hoursToAdd = { hours: 0, minutes: 0, seconds: 0 }; // Réinitialise les heures à ajouter
      this.showPopup = true; // Affiche la popup
      this.isButtonDisabled = false; // Réactive le bouton
    },
    addRequiredHours() {
      const additionalSeconds = this.convertTimeToSeconds(`${this.hoursToAdd.hours}:${this.hoursToAdd.minutes}:${this.hoursToAdd.seconds}`);
      this.selectedEmployee.hoursRequired = (this.selectedEmployee.hoursRequired || 0) + additionalSeconds; // Ajoute les heures requises
      this.selectedEmployee.hoursRequiredFormatted = this.convertSecondsToTime(this.selectedEmployee.hoursRequired); // Formate le temps de travail
      this.isButtonDisabled = true; // Désactive le bouton
      this.showPopup = false; // Ferme la popup
    }
  },
  mounted() {
    this.fetchEmployees(); // Récupère les utilisateurs quand le composant est monté
  }
};
</script>

<style scoped>
.hours-tracking-container {
  padding: 20px;
  background-color: #1d1d1d;
  color: #f5f5f5;
}

h1 {
  text-align: center;
  margin-bottom: 20px;
}

.filter-container {
  margin-bottom: 20px;
  text-align: center;
}

select {
  padding: 5px;
  font-size: 1rem;
  background-color: #282828;
  color: #f5f5f5;
  border: 1px solid #444;
  border-radius: 5px;
}

select option {
  background-color: #282828;
  color: #f5f5f5;
}

select:hover {
  background-color: #333;
}

select:focus {
  outline: none;
  border-color: #555;
}

table {
  width: 100%;
  border-collapse: collapse;
}

th, td {
  border: 1px solid #444;
  padding: 10px;
  text-align: left;
}

th {
  background-color: #282828;
}

td.overdue {
  color: #ff0000;
}

td {
  color: #f5f5f5;
}

.popup {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(0, 0, 0, 0.7);
  display: flex;
  align-items: center;
  justify-content: center;
}

.popup-content {
  background: #282828;
  padding: 20px;
  border-radius: 10px;
  text-align: center;
}

.popup-content input {
  margin: 5px;
  color: #000;
}

.popup-content button {
  margin-top: 10px;
}

button {
  margin-right: 10px;
  padding: 5px 10px;
  background-color: #28a745;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}

button:disabled {
  background-color: grey;
  cursor: not-allowed;
}

button:hover:not(:disabled) {
  background-color: #218838;
}
</style>