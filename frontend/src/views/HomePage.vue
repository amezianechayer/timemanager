<template>
  <HeaderComponent />
  <div class="home h-screen flex flex-col relative">
    <div class="relative w-full h-full">
      <img src="@/assets/fondEcran.webp" alt="Arkham Tracker Logo" class="w-full h-full object-cover opacity-50">
      <div class="absolute inset-0 flex flex-col items-center justify-center z-20">
        <p class="text-lg text-white">This is the main content of the home page.</p>
        <button @click="handleClick" class="mt-4 bg-blue-500 text-white font-bold py-2 px-4 rounded hover:bg-blue-700">
          Click Me
        </button>
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
/* Pas de styles additionnels nécessaires si tu utilises Tailwind */
</style>
