<template>
  <HeaderComponent />
  <div class="hours-tracking-container">
    <h1>Suivi des Heures - Arkham Tracker</h1>
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
      <tr v-for="employee in employees" :key="employee.id">
        <td>{{ employee.name }}</td>
        <td>{{ employee.hoursWorked }}</td>
        <td>{{ employee.hoursRequired }}</td>
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

export default {
  components: {HeaderComponent},
  data() {
    return {
      employees: [
        { id: 1, name: 'Alice Dupont', hoursWorked: 35, hoursRequired: 40 },
        { id: 2, name: 'Bob Martin', hoursWorked: 42, hoursRequired: 40 },
        { id: 3, name: 'Claire Rousseau', hoursWorked: 30, hoursRequired: 35 },
        { id: 4, name: 'David Lefevre', hoursWorked: 40, hoursRequired: 40 },
      ],
    };
  },
  methods: {
    isOverdue(employee) {
      return employee.hoursWorked < employee.hoursRequired; // Détermine si l'employé est en retard
    }
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
