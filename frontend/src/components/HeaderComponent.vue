/* eslint-disable vue/multi-word-component-names */
<template>
  <header v-if="!isLoginPage" class="bg-black p-4">
    <nav class="flex justify-between items-center rounded-3xl">
      <h1 class="text-6xl font-bold leading-none">
        <span class="block text-white">Arkham</span>
        <span class="block ml-12 text-white">Tracker</span>
      </h1>

      <div class="flex space-x-8 text-white text-2xl font-semibold mr-80">
        <router-link to="/home" class="hover:underline p-2">Home</router-link>
        <router-link to="/about" class="hover:underline p-2">About</router-link>
        <router-link to="/moderation" class="hover:underline p-2">Moderation</router-link>
        <router-link to="/board" class="hover:underline p-2">Board</router-link>
        <router-link to="/chart" class="hover:underline p-2">Chart</router-link>
      </div>
    </nav>
  </header>
</template>



<script>
import { computed } from 'vue';
import { useRoute } from 'vue-router';

export default {
  setup() {
    const route = useRoute(); // Obtenir la route actuelle
    const isLoginPage = computed(() => route.path === '/login'); // Vérifier si la route est celle de la page de connexion

    return {
      isLoginPage,
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
</style>
