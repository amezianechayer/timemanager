<template>
  <HeaderComponent />
  <div class="moderation-container">
    <h1>Modération - Arkham Tracker</h1>
    <table>
      <thead>
      <tr>
        <th>ID</th>
        <th>Nom d'utilisateur</th>
        <th>Début de la journée</th>
        <th>Fin de journée</th>
        <th>Temps travaillé aujourd'hui</th>
      </tr>
      </thead>
      <tbody>
      <tr v-for="item in reports" :key="item.id">
        <td>{{ item.id }}</td>
        <td>{{ item.username }}</td>
        <td>
          <button @click="startDay(item)" :disabled="item.start">Commencer la journée</button>
        </td>
        <td>
          <button @click="endDay(item)" :disabled="!item.start || item.end">Terminer la journée</button>
        </td>
        <td>{{ item.workingTime }}</td>
      </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
import HeaderComponent from "@/components/HeaderComponent.vue";
import axios from "axios";

export default {
  components: { HeaderComponent },
  data() {
    return {
      reports: [], // Liste des utilisateurs avec les détails des heures de travail
      userId: null // L'ID de l'utilisateur courant (à récupérer une seule fois)
    };
  },
  methods: {
    async fetchUsers() {
      try {
        const response = await axios.get("http://localhost:4000/api/users");
        this.reports = response.data.data.map(user => ({
          id: user.id,
          username: user.username,
          start: null,  // Statut initial du début de journée
          end: null,    // Statut initial de la fin de journée
          workingtimeId: null, // ID du workingtime à mettre à jour lors de la fin de journée
          workingTime: null // Temps travaillé aujourd'hui
        }));
        // Récupère l'ID du premier utilisateur (à adapter selon votre logique)
        this.userId = this.reports[0].id;
      } catch (error) {
        console.error("Erreur lors de la récupération des utilisateurs", error);
      }
    },

    // Méthode pour commencer la journée
    async startDay(user) {
      try {
        const response = await axios.post(`http://localhost:4000/api/workingtimes`, {
          workingtime: {
            start: new Date().toISOString(),
            user_id: user.id
          }
        });
        const workingtime = response.data.data;
        user.start = workingtime.start; // Use the start time from the response
        user.workingtimeId = workingtime.id; // Store the working time ID
      } catch (error) {
        console.error("Error starting the day:", error);
      }
    },

    async endDay(user) {
      if (user.end) return; // Prevent multiple clicks
      try {
        const response = await axios.put(`http://localhost:4000/api/workingtimes/${user.workingtimeId}`, {
          workingtime: {
            end: new Date().toISOString()
          }
        });
        const updatedWorkingTime = response.data.data;
        user.end = updatedWorkingTime.end; // Use the end time from the response
        user.workingTime = this.calculateWorkingTime(user.start, user.end); // Calculate the working time
      } catch (error) {
        console.error("Error updating the working time:", error);
      }
    },

    calculateWorkingTime(start, end) {
      const startTime = new Date(start).getTime();
      const endTime = new Date(end).getTime();
      const diffMs = endTime - startTime;

      const diffHrs = Math.floor(diffMs / 3600000); // Convertit les millisecondes en heures
      const diffMins = Math.floor((diffMs % 3600000) / 60000); // Convertit les millisecondes restantes en minutes
      const diffSecs = Math.floor((diffMs % 60000) / 1000); // Convertit les millisecondes restantes en secondes

      return `${diffHrs}h ${diffMins}m ${diffSecs}s`;
    }
  },
  mounted() {
    this.fetchUsers(); // Appeler la méthode pour récupérer les utilisateurs lors du montage du composant
  }
};
</script>

<style scoped>
.moderation-container {
  padding: 20px;
  background-color: #1d1d1d;
  color: #f5f5f5;
}

h1 {
  text-align: center;
  margin-bottom: 20px;
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

button {
  margin-right: 10px;
  padding: 5px 10px;
  background-color: #28a745; /* Couleur verte */
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
  background-color: #218838; /* Vert plus foncé au survol */
}
</style>
