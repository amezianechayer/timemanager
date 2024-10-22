<template>
  <HeaderComponent />
  <div>
    <h1>Suivi des Heures - Arkham Tracker</h1>

    <select v-model="selectedUser" @change="fetchUserClocks">
      <option value="" disabled>Sélectionnez un utilisateur</option>
      <option v-for="user in users" :key="user.id" :value="user.id">{{ user.username }}</option>
    </select>

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
import HeuresChart from '../../components/HeuresChart.vue';
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
      lastInsertedAt: null, // Nouveau champ pour stocker la dernière date d'insertion
      chartData: {
        labels: [],  // À remplir dynamiquement
        datasets: [
          {
            label: 'Status des Clocks',
            backgroundColor: '#42b983',
            data: []  // À remplir dynamiquement
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
    this.fetchUsers();
  },
  methods: {
    async fetchUsers() {
      try {
        const response = await axios.get('http://localhost:4000/api/users');
        this.users = response.data.data;
      } catch (error) {
        console.error('Erreur lors de la récupération des utilisateurs:', error);
      }
    },
    async fetchUserClocks() {
      if (this.selectedUser) {
        try {
          const response = await axios.get(`http://localhost:4000/api/clocks/${this.selectedUser}`);
          console.log('Réponse de l\'API:', response.data);
          this.clocks = response.data.data; // Mettre à jour les clocks

          // Mettre à jour lastInsertedAt
          if (this.clocks.length > 0) {
            this.lastInsertedAt = this.clocks[this.clocks.length - 1].inserted_at; // Dernière date d'insertion
          }

          // Mise à jour des données du graphique
          this.updateChartData();
        } catch (error) {
          console.error('Erreur lors de la récupération des clocks:', error);
          this.clocks = []; // Réinitialiser en cas d'erreur
        }
      }
    },
    updateChartData() {
      if (Array.isArray(this.clocks) && this.clocks.length > 0) {
        this.chartData.labels = this.clocks.map(clock => clock.time); // Mettre à jour les étiquettes avec le temps des clocks
        this.chartData.datasets[0].data = this.clocks.map(clock => clock.status ? 1 : 0); // Utiliser le status des clocks pour les données
      } else {
        // Si pas de clocks, on peut réinitialiser les données
        this.chartData.labels = [];
        this.chartData.datasets[0].data = [];
      }
    },
    formatDate(dateString) {
      const options = { year: 'numeric', month: '2-digit', day: '2-digit', hour: '2-digit', minute: '2-digit', second: '2-digit', hour12: false };
      const date = new Date(dateString);
      return date.toLocaleString('fr-FR', options); // Formate la date au format français
    }
  }
};
</script>

<style scoped>
/* Ajoutez ici votre style si nécessaire */
</style>
