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
        <th>Droit utilisateur</th>
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
        <td>{{ item.roles }}</td>
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
      reports: [],
      userId: null
    };
  },
  methods: {
    async fetchUsers() {
      try {
        const response = await axios.get("http://localhost:4000/api/admin/users");
        this.reports = response.data.data.map(user => ({
          id: user.id,
          username: user.username,
          roles: user.roles[0],
          start: null,
          end: null,
          workingtimeId: null,
          workingTime: null
        }));
        this.userId = this.reports[0]?.id;
      } catch (error) {
        console.error("Erreur lors de la récupération des utilisateurs", error);
      }
    },

    async startDay(user) {
      try {
        console.log(user);
        const response = await axios.post(`http://localhost:4000/api/admin/workingtimes/${user.id}`, {
          workingtime: {
            start: new Date().toISOString(),
            user_id: user.id
          }
        });
        const workingtime = response.data.data;
        user.start = workingtime.start;
        user.workingtimeId = workingtime.id;
      } catch (error) {
        console.error("Error starting the day:", error);
      }
    },

    async endDay(user) {
      if (user.end) return;
      try {
        const endTime = new Date().toISOString();

        const response = await axios.put(`http://localhost:4000/api/admin/workingtimes/${user.id}/${user.workingtimeId}`, {
          workingtime: {
            end: endTime
          }
        });
        const updatedWorkingTime = response.data.data;
        user.end = updatedWorkingTime.end;

        const totalTimeWorked = this.calculateWorkingTime(user.start, user.end);
        user.workingTime = totalTimeWorked;

        await axios.post(`http://localhost:4000/api/admin/clocks/${user.id}`, {
          clock: {
            time: totalTimeWorked,
            status: true
          }
        });
      } catch (error) {
        console.error("Erreur lors de la mise à jour du temps de travail:", error);
      }
    },

    calculateWorkingTime(start, end) {
      const startTime = new Date(start).getTime();
      const endTime = new Date(end).getTime();
      const diffMs = endTime - startTime;

      const diffHrs = String(Math.floor(diffMs / 3600000)).padStart(2, '0');
      const diffMins = String(Math.floor((diffMs % 3600000) / 60000)).padStart(2, '0');
      const diffSecs = String(Math.floor((diffMs % 60000) / 1000)).padStart(2, '0');

      return `${diffHrs}:${diffMins}:${diffSecs}`;
    }
  },
  mounted() {
    // Ajoutez le token aux en-têtes Axios ici
    const token = localStorage.getItem('token');
    if (token) {
      axios.defaults.headers.common['Authorization'] = `Bearer ${token}`;
    }

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