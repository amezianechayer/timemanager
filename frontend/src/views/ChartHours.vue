<template>
    <div>
      <h1>Suivi des Heures - Arkham Tracker</h1>
      <HeuresChart :chartData="chartData" :options="chartOptions" />
    </div>
  </template>
  
  <script>
  import HeuresChart from '../components/HeuresChart.vue';
  
  export default {
    components: {
      HeuresChart
    },
    data() {
      return {
        chartData: {
          labels: ['Alice Dupont', 'Bob Martin', 'Claire Rousseau', 'David Lefevre'],
          datasets: [
            {
              label: 'Heures Travaillées',
              backgroundColor: '#42b983',
              data: [35, 42, 30, 40]
            },
            {
              label: 'Heures Requises',
              backgroundColor: '#ff6384',
              data: [40, 40, 35, 40]
            }
          ]
        },
        chartOptions: {
          responsive: true,
          maintainAspectRatio: false
        }
      };
    }
  };
  </script>
  