<template>
  <HeaderComponent />
  <div>
    <section class="organisation">
      <h1 class="text-4xl font-bold mb-8 text-center">Organisation de la ville</h1>

      <button @click="openModal" class="ajouter-compagnie-btn">Ajouter une compagnie</button>

      <!-- Modal pour ajouter une compagnie -->
      <div v-if="isModalOpen" class="modal">
        <div class="modal-content">
          <h2 class="text-black">Ajouter une nouvelle compagnie</h2>
          <form @submit.prevent="ajouterCompagnie">
            <label for="nom" class="text-black">Nom de la compagnie :</label>
            <input type="text" v-model="nouvelleCompagnie.name" id="nom" class="input-text-black" required>

            <label for="description" class="text-black">Description de la compagnie :</label>
            <textarea v-model="nouvelleCompagnie.description" id="description" class="input-text-black" required></textarea>

            <button type="submit" class="btn-valider">Valider</button>
            <button @click="closeModal" type="button" class="btn-annuler">Annuler</button>
          </form>
        </div>
      </div>

      <div class="organigramme text-black">
        <ul class="metiers-container">
          <li v-for="(metier, indexMetier) in corpsMetiers" :key="metier.id" class="metier-column">
            <div class="metier text-black">
              <span class="nom-compagnie">{{ metier.name }}</span>
              <button @click="openTeamModal(indexMetier)" type="button" class="toggle-btn">Créer une équipe</button>
            </div>

            <ul class="teams-list text-black">
              <li v-for="team in metier.teams" :key="team.id" class="team text-black">
                <div>
                  {{ team.name }}
                  <button @click="openUserModalForTeam(team.id)" type="button" class="toggle-btn">Ajouter user</button>
                </div>
                <ul class="users-list">
                  <li v-for="user in team.users" :key="user.id" class="user">
                    {{ user.username }}
                  </li>
                </ul>
              </li>
            </ul>
          </li>
        </ul>
      </div>

      <!-- Modal pour ajouter une équipe -->
      <div v-if="isTeamModalOpen" class="modal">
        <div class="modal-content">
          <h2 class="text-black">Créer une nouvelle équipe</h2>
          <form @submit.prevent="ajouterEquipe">
            <label for="team-name" class="text-black">Nom de l'équipe :</label>
            <input type="text" v-model="nouvelleEquipe.name" id="team-name" class="input-text-black" required>

            <button type="submit" class="btn-valider">Créer</button>
            <button @click="closeTeamModal" type="button" class="btn-annuler">Annuler</button>
          </form>
        </div>
      </div>

      <!-- Modal pour ajouter un user -->
      <div v-if="isUserModalOpen" class="modal">
        <div class="modal-content">
          <h2 class="text-black">Ajouter un nouvel utilisateur</h2>
          <form @submit.prevent="ajouterUser">
            <ul class="users-list">
              <li v-for="user in availableUsers" :key="user.id" class="user">
                {{ user.username }}
                <button @click="selectUser(user.id)" type="button" class="btn-select">Sélectionner</button>
              </li>
            </ul>

            <button type="submit" class="btn-valider" :disabled="!selectedUserId">Ajouter</button>
            <button @click="closeUserModal" type="button" class="btn-annuler">Annuler</button>
          </form>
        </div>
      </div>

    </section>
  </div>
</template>

<script>
import HeaderComponent from "@/components/HeaderComponent.vue";
import axios from 'axios';

export default {
  name: 'OrganisationPage',
  components: { HeaderComponent },
  data() {
    return {
      corpsMetiers: [],
      isModalOpen: false,
      isTeamModalOpen: false,
      isUserModalOpen: false,
      nouvelleCompagnie: {
        name: '',
        description: ''
      },
      nouvelleEquipe: {
        name: ''
      },
      selectedUserId: null,
      availableUsers: [],
      selectedMetierIndex: null,
      selectedTeamId: null
    };
  },
  methods: {
    async fetchCompagnies() {
      try {
        const response = await axios.get('http://localhost:4000/api/admin/compagnies');
        console.log('Compagnies récupérées:', response.data.data);
        this.corpsMetiers = response.data.data.map(metier => ({
          ...metier,
          teams: [] // Initialisation de teams
        }));

        // Récupérer les équipes pour chaque compagnie
        for (const metier of this.corpsMetiers) {
          await this.fetchTeams(metier.id);
        }
      } catch (error) {
        console.error('Erreur lors de la récupération des compagnies:', error);
      }
    },

    async fetchTeams(companyId) {
      try {
        const response = await axios.get(`http://localhost:4000/api/admin/teams?companyId=${companyId}`);
        console.log('Équipes récupérées pour la compagnie', companyId, ':', response.data);

        const metier = this.corpsMetiers.find(metier => metier.id === companyId);
        if (metier) {
          // Récupération des utilisateurs pour chaque équipe
          for (const team of response.data.data) {
            const usersResponse = await axios.get(`http://localhost:4000/api/admin/users?teamId=${team.id}`);
            team.users = usersResponse.data.data.filter(user => user.team_id === team.id); // Filtrer les utilisateurs par team_id
          }
          metier.teams = response.data.data; // Ajoute les équipes au bon métier
        }
        console.log('Mise à jour des corpsMetiers:', this.corpsMetiers);
      } catch (error) {
        console.error('Erreur lors de la récupération des équipes:', error);
      }
    },

    openTeamModal(indexMetier) {
      this.selectedMetierIndex = indexMetier;
      this.nouvelleEquipe.name = '';
      this.isTeamModalOpen = true;
      console.log("Ouverture du modal pour l'équipe, index:", indexMetier);
    },

    closeTeamModal() {
      this.isTeamModalOpen = false;
      console.log("Fermeture du modal pour l'équipe");
    },

    openUserModalForTeam(teamId) {
      this.selectedTeamId = teamId;
      this.selectedUserId = null; // Réinitialiser l'utilisateur sélectionné
      this.fetchAvailableUsers(); // Récupérer les utilisateurs disponibles pour cette équipe
      this.isUserModalOpen = true;
      console.log("Ouverture du modal pour l'utilisateur, teamId:", teamId);
    },

    closeUserModal() {
      this.isUserModalOpen = false;
      console.log("Fermeture du modal pour l'utilisateur");
    },

    openModal() {
      this.isModalOpen = true;
      console.log("Ouverture du modal pour la compagnie");
    },
    closeModal() {
      this.isModalOpen = false;
      console.log("Fermeture du modal pour la compagnie");
    },

    async ajouterCompagnie() {
      try {
        console.log("Données de la nouvelle compagnie:", this.nouvelleCompagnie);
        const response = await axios.post('http://localhost:4000/api/admin/compagnies', {
          compagny: this.nouvelleCompagnie
        });
        console.log('Réponse après ajout de la compagnie:', response.data);
        this.corpsMetiers.push({
          ...response.data.data,
          teams: [] // Initialisation de teams
        });
        console.log('Compagnies après ajout:', this.corpsMetiers);
        this.closeModal();
      } catch (error) {
        console.error('Erreur lors de l\'ajout de la compagnie:', error);
      }
    },

    async ajouterEquipe() {
      const nomEquipe = this.nouvelleEquipe.name;
      if (nomEquipe) {
        const metier = this.corpsMetiers[this.selectedMetierIndex];
        console.log("Données de la nouvelle équipe:", {
          name: nomEquipe,
          company_id: metier.id
        });
        try {
          const response = await axios.post('http://localhost:4000/api/admin/teams', {
            team: {
              name: nomEquipe,
              company_id: metier.id
            }
          });
          console.log('Réponse après création de l\'équipe:', response.data);
          metier.teams.push(response.data.data);
          console.log('Équipes après ajout:', metier.teams);
          this.closeTeamModal();
        } catch (error) {
          console.error('Erreur lors de la création de l\'équipe:', error);
        }
      }
    },

    async fetchAvailableUsers() {
      try {
        const response = await axios.get('http://localhost:4000/api/admin/users');
        this.availableUsers = response.data.data.filter(user => !user.team_id); // Filtrer les utilisateurs sans team_id
        console.log('Utilisateurs disponibles:', this.availableUsers);
      } catch (error) {
        console.error('Erreur lors de la récupération des utilisateurs:', error);
      }
    },

    selectUser(userId) {
      this.selectedUserId = userId;
      console.log("Utilisateur sélectionné:", userId);
    },

    async ajouterUser() {
      if (this.selectedUserId && this.selectedTeamId) {
        console.log("Ajout de l'utilisateur:", this.selectedUserId, "à l'équipe:", this.selectedTeamId);
        try {
          await axios.patch(`http://localhost:4000/api/admin/users/${this.selectedUserId}`, {
            user: {
              team_id: this.selectedTeamId // Mettre à jour team_id pour l'utilisateur
            }
          });
          console.log('Utilisateur ajouté à l\'équipe avec succès');
          const team = this.corpsMetiers[this.selectedMetierIndex].teams.find(t => t.id === this.selectedTeamId);
          if (team) {
            const userResponse = await axios.get(`http://localhost:4000/api/admin/users/${this.selectedUserId}`);
            team.users.push(userResponse.data.data); // Ajouter l'utilisateur à l'équipe
            console.log('Mise à jour des utilisateurs de l\'équipe:', team.users);
          }
          this.closeUserModal();
        } catch (error) {
          console.error('Erreur lors de l\'ajout de l\'utilisateur à l\'équipe:', error);
        }
      }
    }
  },
  mounted() {
      const token = localStorage.getItem('token');
      if (token) {
        axios.defaults.headers.common['Authorization'] = `Bearer ${token}`;
      }
    this.fetchCompagnies();
  }

};

</script>

<style scoped>
/* Styles pour l'organigramme avec mise en page en colonnes */
.organigramme {
  display: flex;
  justify-content: center;
}

.metiers-container {
  display: flex;
  justify-content: space-around;
  width: 100%;
}

.metier-column {
  flex: 1;
  margin: 0 10px;
  text-align: center;
}

.metier {
  display: flex;
  justify-content: space-between;
  align-items: center;
  border: 1px solid #ccc;
  padding: 10px;
  border-radius: 5px;
  background-color: #f9f9f9;
  cursor: pointer;
  margin-bottom: 10px;
}

.metier {
  background-color: #e3f2fd;
}

.nom-compagnie {
  color: black;
}

.teams-list {
  list-style-type: none;
  padding-left: 20px;
}

.team {
  background-color: #bbdefb;
  padding: 10px;
  margin: 5px 0;
  border-radius: 5px;
}

.toggle-btn {
  background-color: #007BFF;
  color: black;
  border: none;
  padding: 3px 10px;
  border-radius: 5px;
  cursor: pointer;
}

.toggle-btn:hover {
  background-color: #0056b3;
}

.ajouter-compagnie-btn {
  background-color: #4CAF50;
  color: white;
  padding: 10px;
  border: none;
  border-radius: 5px;
  cursor: pointer;
}

.ajouter-compagnie-btn:hover {
  background-color: #45a049;
}

.modal {
  position: fixed;
  z-index: 1;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  overflow: auto;
  background-color: rgb(0,0,0);
  background-color: rgba(0,0,0,0.4);
  padding-top: 60px;
}

.modal-content {
  background-color: #fefefe;
  margin: 5% auto;
  padding: 20px;
  border: 1px solid #888;
  width: 80%;
}

.btn-valider {
  background-color: #4CAF50;
  color: white;
  border: none;
  padding: 10px;
  border-radius: 5px;
  cursor: pointer;
}

.btn-valider:hover {
  background-color: #45a049;
}

.btn-annuler {
  background-color: #f44336;
  color: white;
  border: none;
  padding: 10px;
  border-radius: 5px;
  cursor: pointer;
}

.btn-annuler:hover {
  background-color: #da190b;
}

.input-text-black {
  background-color: black;
  color: white;
}

.users-list {
  list-style-type: none;
  padding-left: 20px;
}

.user {
  background-color: #bbdefb; /* Couleur similaire à la team */
  padding: 5px;
  margin: 3px 0;
  border-radius: 3px;
}

.btn-select {
  background-color: #4CAF50;
  color: white;
  border: none;
  padding: 5px;
  border-radius: 3px;
  cursor: pointer;
}

.btn-select:hover {
  background-color: #45a049;
}

</style>