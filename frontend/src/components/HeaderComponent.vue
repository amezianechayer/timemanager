/* eslint-disable vue/multi-word-component-names */
<template>
  <header v-if="!isLoginPage" class="bg-black p-4">
    <nav class="flex justify-between items-center rounded-3xl">
      <h1 class="text-6xl font-bold leading-none">
        <span class="block text-white">Arkham</span>
        <span class="block ml-12 text-white">Tracker</span>
      </h1>

      <div class="flex items-center space-x-8 text-white text-2xl font-semibold">
        <router-link to="/home" class="hover:underline p-2">Home</router-link>
        <router-link to="/about" class="hover:underline p-2">About</router-link>
        <router-link to="/moderation" class="hover:underline p-2">Moderation</router-link>
        <router-link to="/board" class="hover:underline p-2">Board</router-link>
        <router-link to="/chart" class="hover:underline p-2">Chart</router-link>
        <router-link to="/profil">
          <img src="@/assets/profil.png" alt="Arkham Tracker Logo" class="w-16 h-16">
        </router-link>

      </div>

      <button @click="logout" class="logout-button">
        Logout
      </button>
    </nav>
  </header>
</template>

<script>
import { computed } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import axios from 'axios';

export default {
  setup() {
    const route = useRoute(); // Obtenir la route actuelle
    const router = useRouter(); // Pour redirection après déconnexion
    const isLoginPage = computed(() => route.path === '/login'); // Vérifier si la route est celle de la page de connexion

    const logout = () => {
      localStorage.removeItem('token');
      delete axios.defaults.headers.common['Authorization'];

      // Redirection vers la page de connexion (chemin "/")
      router.push('/');
    };

    return {
      isLoginPage,
      logout,
    };
  },
};
</script>

<style scoped>
nav {
  background-color: #333;
  padding: 10px;
}

nav a {
  color: white;
  margin: 0 10px;
  text-decoration: none;
}

button.logout-button {
  background-color: blue;
  color: black;
  font-size: 2xl; /* Same as the categories in the navbar */
  font-weight: bold;
  padding: 4px;
  border-radius: xl;
  z-index: 10;
}

button.logout-button:hover {
  background-color: #; /* Darker blue for hover effect */
}

img {
  object-fit: contain; /* Garde la proportion de l'image */
}
</style>
