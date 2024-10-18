<template>
  <div>
    <HeaderComponent />

    <section class="about">
      <h1>About Gotham City</h1>

      <!-- Description de Gotham City -->
      <p>
        Gotham City est une métropole située sur la côte Est, connue pour ses gratte-ciel imposants et ses infrastructures complexes.
        La ville couvre environ 1 500 km², avec une population d'environ 10 millions d'habitants.
      </p>

      <!-- Section Carte et Graphiques Population -->
      <div class="map-and-stats">
        <div class="map-container">
          <img src="@/assets/gotham.webp" alt="Carte de Gotham City" />
        </div>

        <div class="population-stats">
          <h2>Démographie de la Population</h2>

          <!-- Graphique Répartition par Âge -->
          <div class="chart-container">
            <h3>Répartition par Âge</h3>
            <canvas id="ageDistributionChart"></canvas>
          </div>

          <!-- Graphique Répartition par Genre -->
          <div class="chart-container">
            <h3>Répartition par Genre</h3>
            <canvas id="genderDistributionChart"></canvas>
          </div>
        </div>
      </div>

      <!-- Autres statistiques -->
      <section class="statistics">
        <h2>Statistiques Clés</h2>

        <div class="stats-grid">
          <div class="stat-item">
            <h3>Population</h3>
            <p>10 millions</p>
            <!-- Graphique de population -->
            <canvas id="populationChart"></canvas>
          </div>

          <div class="stat-item">
            <h3>Nombre d'Employés Municipaux</h3>
            <p>50,000</p>
            <!-- Graphique des employés -->
            <canvas id="employeesChart"></canvas>
          </div>

          <div class="stat-item">
            <h3>Taux de Criminalité</h3>
            <p>15%</p>
            <!-- Graphique du taux de criminalité -->
            <canvas id="crimeRateChart"></canvas>
          </div>
        </div>
      </section>
    </section>
  </div>
</template>

<script>
import { Chart } from 'chart.js';
import HeaderComponent from "@/components/HeaderComponent.vue";

export default {
  name: 'AboutPage',
  components: {HeaderComponent},
  mounted() {
    this.createCharts();
  },
  methods: {
    createCharts() {
      // Graphique Population
      new Chart(document.getElementById('populationChart'), {
        type: 'doughnut',
        data: {
          labels: ['Habitants', 'Autres'],
          datasets: [{
            data: [10000000, 500000],
            backgroundColor: ['#36A2EB', '#FF6384']
          }]
        }
      });

      // Graphique Employés
      new Chart(document.getElementById('employeesChart'), {
        type: 'bar',
        data: {
          labels: ['Employés Municipaux'],
          datasets: [{
            label: 'Nombre d\'employés',
            data: [50000],
            backgroundColor: '#FFCE56'
          }]
        }
      });

      // Graphique Taux de Criminalité
      new Chart(document.getElementById('crimeRateChart'), {
        type: 'pie',
        data: {
          labels: ['Criminalité', 'Autres'],
          datasets: [{
            data: [15, 85],
            backgroundColor: ['#FF6384', '#36A2EB']
          }]
        }
      });

      // Graphique Répartition par Âge
      new Chart(document.getElementById('ageDistributionChart'), {
        type: 'bar',
        data: {
          labels: ['0-14 ans', '15-24 ans', '25-54 ans', '55-64 ans', '65+ ans'],
          datasets: [{
            label: 'Population (en millions)',
            data: [1.5, 2, 4, 1.5, 1],
            backgroundColor: '#4BC0C0'
          }]
        }
      });

      // Graphique Répartition par Genre
      new Chart(document.getElementById('genderDistributionChart'), {
        type: 'pie',
        data: {
          labels: ['Hommes', 'Femmes'],
          datasets: [{
            data: [48, 52],
            backgroundColor: ['#FF6384', '#36A2EB']
          }]
        }
      });
    }
  }
}
</script>

<style scoped>
.about {
  padding: 20px;
}

.map-and-stats {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.map-container img {
  width: 100%;
  max-width: 400px;
}

.population-stats {
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.chart-container {
  width: 300px;
}

.statistics {
  margin-top: 30px;
}

.stats-grid {
  display: grid;
  grid-template-columns: 1fr 1fr 1fr;
  gap: 20px;
}

.stat-item {
  text-align: center;
}
</style>
