<template>
  <HeaderComponent />
  <div class="home h-screen flex flex-col relative">
    <div class="relative w-full h-full">
      <img src="../../assets/fondEcran.webp" alt="Arkham Tracker Logo" class="w-full h-full object-cover opacity-50">
      <div class="absolute inset-0 flex flex-col items-center justify-center z-20">
        <h1 class="text-3xl text-white">Bienvenue sur l'interface Admin !</h1>
      </div>
    </div>

    <footer class="text-sm text-gray-500 p-4 z-10">
    </footer>
  </div>
</template>

<script>
import HeaderComponent from "@/components/HeaderComponent.vue";

export default {
  name: 'HomePage',
  components: {HeaderComponent},
  methods: {
    handleClick() {
      alert('Button clicked!');
    }
  }
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
  background-color: #1e3a8a; /* Darker blue for hover effect */
}
</style>
