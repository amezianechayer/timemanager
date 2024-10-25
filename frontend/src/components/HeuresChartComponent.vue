<template>
    <div>
      <Bar :data="chartData" :options="options" />
    </div>
  </template>

  <script>
  import { Bar } from 'vue-chartjs';
  import { Chart as ChartJS, Title, Tooltip, Legend, BarElement, CategoryScale, LinearScale } from 'chart.js';

  ChartJS.register(Title, Tooltip, Legend, BarElement, CategoryScale, LinearScale);

  export default {
    name: 'HeuresChart',
    components: {
      Bar
    },
    props: {
      chartData: {
        type: Object,
        required: true
      },
      options: {
        type: Object,
        required: true,
        default: () => ({})
      }
    }
  };
  </script>
