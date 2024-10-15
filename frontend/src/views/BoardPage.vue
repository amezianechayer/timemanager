<template>
  <HeaderComponent />
  <div class="hours-tracking-container">
    <h1>Suivi des Heures - Arkham Tracker</h1>

    <!-- Menu déroulant pour sélectionner un utilisateur -->
    <div class="filter-container">
      <label for="user-select" class="text-black">Filtrer par employé : </label>
      <select id="user-select" v-model="selectedUser" @change="filterEmployees">
        <option value="all">Tous les utilisateurs</option>
        <option v-for="employee in employees" :key="employee.id" :value="employee.id">
          {{ employee.username }}
        </option>
      </select>
    </div>

    <!-- Tableau des heures -->
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
        <td>{{ employee.hoursWorked || '' }}</td>
        <td>{{ employee.hoursRequired || '' }}</td>
        <td :class="{'overdue': isOverdue(employee)}">
          {{ isOverdue(employee) ? 'Retard' : 'À jour' }}
        </td>
      </tr>
      </tbody>
    </table>
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
      filteredEmployees: [] // Liste filtrée d'utilisateurs
    };
  },
  methods: {
    async fetchEmployees() {
      try {
        const response = await axios.get('http://localhost:4000/api/users');
        this.employees = response.data.data;
        this.filteredEmployees = this.employees; // Initialement, on affiche tous les utilisateurs
      } catch (error) {
        console.error('Erreur lors de la récupération des utilisateurs:', error);
      }
    },
    filterEmployees() {
      if (this.selectedUser === 'all') {
        this.filteredEmployees = this.employees; // Affiche tous les utilisateurs si "Tous les utilisateurs" est sélectionné
      } else {
        this.filteredEmployees = this.employees.filter(employee => employee.id === parseInt(this.selectedUser)); // Filtre par l'utilisateur sélectionné
      }
    },
    isOverdue(employee) {
      return employee.hoursWorked < employee.hoursRequired; // Détermine si l'employé est en retard
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
  background-color: #282828; /* Couleur de fond du menu déroulant */
  color: #f5f5f5; /* Couleur du texte dans le menu déroulant */
  border: 1px solid #444; /* Bordure pour le menu déroulant */
  border-radius: 5px; /* Arrondi des coins du menu déroulant */
}

select option {
  background-color: #282828; /* Couleur de fond des options */
  color: #f5f5f5; /* Couleur du texte des options */
}

select:hover {
  background-color: #333; /* Couleur de fond au survol du menu déroulant */
}

select:focus {
  outline: none; /* Enlève le contour par défaut */
  border-color: #555; /* Change la couleur de la bordure au focus */
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
  color: #ff0000; /* Rouge pour les employés en retard */
}

td {
  color: #f5f5f5;
}
</style>
