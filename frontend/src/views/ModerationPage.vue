<template>
  <div class="moderation-container">
    <h1>Modération - Arkham Tracker</h1>
    <table>
      <thead>
      <tr>
        <th>ID</th>
        <th>Nom d'utilisateur</th>
        <th>Raison</th>
        <th>Action</th>
      </tr>
      </thead>
      <tbody>
      <tr v-for="item in reports" :key="item.id">
        <td>{{ item.id }}</td>
        <td>{{ item.username }}</td>
        <td>{{ item.reason }}</td>
        <td>
          <button @click="approveReport(item.id)">Approuver</button>
          <button @click="deleteReport(item.id)">Supprimer</button>
        </td>
      </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
export default {
  data() {
    return {
      reports: [
        { id: 1, username: 'User1', reason: 'Comportement inapproprié' },
        { id: 2, username: 'User2', reason: 'Spam' },
        { id: 3, username: 'User3', reason: 'Langage offensant' },
      ],
    };
  },
  methods: {
    approveReport(id) {
      // Logique pour approuver le rapport
      alert(`Rapport ${id} approuvé !`);
      this.removeReport(id); // Optionnel : retirer le rapport de la liste
    },
    deleteReport(id) {
      // Logique pour supprimer le rapport
      alert(`Rapport ${id} supprimé !`);
      this.removeReport(id);
    },
    removeReport(id) {
      this.reports = this.reports.filter(report => report.id !== id);
    }
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
  background-color: #007bff;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}

button:hover {
  background-color: #0056b3;
}
</style>
