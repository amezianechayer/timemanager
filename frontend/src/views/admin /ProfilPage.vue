<template>
  <HeaderComponent />
  <div class="bg-dark">
    <!-- Menu déroulant pour sélectionner un utilisateur -->
    <div class="user-select mb-4">
      <label for="userDropdown" class="text-white font-semibold mr-2">Sélectionnez un utilisateur :</label>
      <select id="userDropdown" v-model="selectedUserId" @change="fetchUser">
        <option v-for="u in users" :key="u.id" :value="u.id">{{ u.username }}</option>
      </select>
    </div>

    <div class="profile-page container mx-auto p-8 text-white" v-if="user">
      <div class="profile-header flex justify-between items-center mb-8">
        <h1 class="text-4xl font-bold">Profil de {{ user.username }}</h1>
        <router-link :to="`/edit-profile/${user.id}`">
          <button class="edit-button bg-blue-500 text-white font-bold py-2 px-4 rounded">
            Modifier le profil
          </button>
        </router-link>
      </div>

      <div class="profile-info flex">
        <!-- Image de profil -->
        <div class="profile-image mr-8">
          <img src="../../assets/profil.png" alt="Arkham Tracker Logo" class="w-16 h-16">
        </div>

        <!-- Informations utilisateur -->
        <div class="profile-details space-y-4">
          <div>
            <span class="font-semibold text-xl">Nom d'utilisateur : </span>
            <span class="text-lg">{{ user.username }}</span>
          </div>
          <div>
            <span class="font-semibold text-xl">Email : </span>
            <span class="text-lg">{{ user.email }}</span>
          </div>
          <div>
            <span class="font-semibold text-xl">Nombre total d'heures travaillées : </span>
            <span class="text-lg">{{ user.totalHoursWorked || '00:00:00' }}</span>
          </div>
        </div>
      </div>
    </div>

    <div v-else>
      Loading...
    </div>
  </div>
</template>

<script>
import { ref, onMounted } from 'vue';
import { useRouter } from 'vue-router';
import HeaderComponent from "@/components/HeaderComponent.vue";
import axios from 'axios';

export default {
  components: { HeaderComponent },
  setup() {
    const router = useRouter();
    const user = ref(null);
    const users = ref([]); // Liste des utilisateurs
    const selectedUserId = ref(null); // Utilisateur sélectionné

    // Fonction pour récupérer la liste des utilisateurs
    const fetchUsers = async () => {
      try {
        const response = await axios.get('http://localhost:4000/api/admin/users');
        users.value = response.data.data; // Assigner la liste des utilisateurs
      } catch (error) {
        console.error('Erreur lors de la récupération des utilisateurs:', error);
      }
    };

    // Fonction pour récupérer les données de l'utilisateur sélectionné
    const fetchUser = async () => {
      try {
        if (!selectedUserId.value) return;

        const response = await axios.get(`http://localhost:4000/api/admin/users/${selectedUserId.value}`);
        user.value = response.data.data;
        user.value.totalHoursWorked = await getTotalHours(selectedUserId.value);
      } catch (error) {
        if (error.response && error.response.status === 404) {
          console.error("Utilisateur non trouvé");
          router.push('/not-found');
        } else {
          console.error("Erreur lors de la récupération des données utilisateur:", error);
        }
      }
    };

    // Récupérer le total d'heures travaillées
    const getTotalHours = async (userId) => {
      try {
        const response = await axios.get(`http://localhost:4000/api/admin/clocks/${userId}`);
        const clocks = response.data.data;

        const totalSeconds = clocks.reduce((total, clock) => {
          const seconds = convertTimeToSeconds(clock.time);
          return total + seconds;
        }, 0);

        return convertSecondsToTime(totalSeconds);
      } catch (error) {
        console.error('Erreur lors de la récupération des heures:', error);
        return '00:00:00';
      }
    };

    // Convertir le temps en secondes
    const convertTimeToSeconds = (time) => {
      const regex = /(\d+):(\d+):(\d+)|(\d+)H(\d+)/;
      const match = time.match(regex);

      if (match) {
        const hours = match[1] ? parseInt(match[1]) : parseInt(match[3]) || 0;
        const minutes = match[2] ? parseInt(match[2]) : parseInt(match[4]) || 0;
        const seconds = match[3] ? parseInt(match[3]) : 0;
        return (hours * 3600) + (minutes * 60) + seconds;
      }
      return 0;
    };

    // Convertir les secondes en format HH:MM:SS
    const convertSecondsToTime = (totalSeconds) => {
      const hours = Math.floor(totalSeconds / 3600);
      const minutes = Math.floor((totalSeconds % 3600) / 60);
      const seconds = totalSeconds % 60;
      return `${String(hours).padStart(2, '0')}:${String(minutes).padStart(2, '0')}:${String(seconds).padStart(2, '0')}`;
    };

    onMounted(() => {
      const token = localStorage.getItem('token');
      if (token) {
        axios.defaults.headers.common['Authorization'] = `Bearer ${token}`;
      }

      fetchUsers(); // Récupérer la liste des utilisateurs au montage
    });

    return {
      users,
      user,
      selectedUserId,
      fetchUser,
    };
  },

};
</script>

<style scoped>
.container {
  max-width: 800px;
}

.bg-dark {
  background-color: #1d1d1d;
}

.text-white {
  color: #ffffff;
}

/* Style pour le menu déroulant */
select {
  background-color: white; /* Fond blanc pour le menu */
  color: black; /* Texte en noir */
  border: 1px solid #ccc;
  padding: 8px;
  font-size: 16px;
}

/* Style pour chaque option dans le menu */
option {
  color: black; /* Couleur du texte des options en noir */
  background-color: white; /* Fond blanc pour les options */
}

.profile-header {
  border-bottom: 2px solid #ddd;
}

.profile-info {
  border-bottom: 2px solid #ddd;
  padding-bottom: 20px;
}

.edit-button:hover {
  background-color: #3b82f6;
}

h1, h2, h3, p, span {
  color: #ffffff;
}
</style>
