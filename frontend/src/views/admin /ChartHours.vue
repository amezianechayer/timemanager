<template>
  <HeaderComponent />
  <div>
    <h1>Suivi des Heures - Arkham Tracker</h1>

    <select v-model="selectedUser" @change="fetchAndDisplayUserData">
      <option value="" disabled>Sélectionnez un utilisateur</option>
      <option v-for="user in users" :key="user.id" :value="user.id">{{ user.username }}</option>
    </select>

    <button @click="fetchAndDisplayUserData" :disabled="!selectedUser" class="btn-validate">Valider</button>

    <HeuresChart :key="selectedUser" :chartData="chartData" :options="chartOptions" />
    <p v-if="lastInsertedAt">Dernière date d'insertion : {{ formatDate(lastInsertedAt) }}</p>

    <div v-if="clocks.length > 0">
      <h3>Clocks :</h3>
      <ul>
        <li v-for="clock in clocks" :key="clock.id">
          {{ clock.time }} - {{ clock.user_id }} - {{ clock.status }} - {{ formatDate(clock.inserted_at) }}
        </li>
      </ul>
    </div>
    <div v-else-if="selectedUser">
      <p>Aucune clock trouvée pour cet utilisateur.</p>
    </div>
  </div>
</template>

<script>
import HeuresChart from '../../components/HeuresChartComponent.vue';
import HeaderComponent from "@/components/HeaderComponent.vue";
import axios from 'axios';

export default {
  components: {
    HeaderComponent,
    HeuresChart
  },
  data() {
    return {
      users: [],
      selectedUser: null,
      clocks: [],
      lastInsertedAt: null,
      chartData: {
        labels: [],
        datasets: [
          {
            label: 'Status des Clocks',
            backgroundColor: '#42b983',
            data: []
          }
        ]
      },
      chartOptions: {
        responsive: true,
        maintainAspectRatio: false
      }
    };
  },
  mounted() {
    const token = localStorage.getItem('token');
    if (token) {
      axios.defaults.headers.common['Authorization'] = `Bearer ${token}`;
    }
    this.fetchUsers();
  },
  methods: {
    async fetchUsers() {
      try {
        const response = await axios.get('http://localhost:4000/api/admin/users');
        this.users = response.data.data;
      } catch (error) {
        console.error('Erreur lors de la récupération des utilisateurs:', error);
      }
    },
    async fetchAndDisplayUserData() {
      console.log('Utilisateur sélectionné :', this.selectedUser); // Log pour débogage
      if (this.selectedUser) {
        this.resetData(); // Réinitialiser les données avant de récupérer les nouvelles
        try {
          // Récupérer les clocks de l'utilisateur sélectionné
          const response = await axios.get(`http://localhost:4000/api/admin/clocks/${this.selectedUser}`);
          this.clocks = response.data.data;

          console.log('Clocks récupérées:', this.clocks); // Log pour débogage

          if (this.clocks.length > 0) {
            this.lastInsertedAt = this.clocks[this.clocks.length - 1].inserted_at;
          }

          // Mettre à jour les données du graphique
          if (this.clocks.length > 0) {
            this.chartData.labels = this.clocks.map(clock => clock.inserted_at);
            this.chartData.datasets[0].data = this.clocks.map(clock => clock.status ? 1 : 0);
          } else {
            this.chartData.labels = [];
            this.chartData.datasets[0].data = [];
          }
        } catch (error) {
          console.error('Erreur lors de la récupération des données de l\'utilisateur:', error);
        }
      }
    },
    resetData() {
      this.clocks = [];
      this.lastInsertedAt = null;
      this.chartData.labels = [];
      this.chartData.datasets[0].data = [];
    },
    formatDate(dateString) {
      const options = {
        year: 'numeric',
        month: '2-digit',
        day: '2-digit',
        hour: '2-digit',
        minute: '2-digit',
        second: '2-digit',
        hour12: false
      };
      const date = new Date(dateString);
      return date.toLocaleString('fr-FR', options);
    }

  }
  };
</script>

<style scoped>
.btn-validate {
  background-color: #42b983;
  color: white;
  border: none;
  padding: 10px 15px;
  cursor: pointer;
  border-radius: 5px;
}

.btn-validate:disabled {
  background-color: #ccc;
  cursor: not-allowed;
}
</style>
