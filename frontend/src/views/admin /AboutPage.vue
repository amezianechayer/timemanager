<template>
  <HeaderComponent />
  <div>
    <h1>About Page</h1>
    <p>This is the about page content.</p>
  </div>
</template>

<script>
import HeaderComponent from "@/components/HeaderComponent.vue";

export default {
  name: 'AboutPage',
  components: {HeaderComponent},
};
</script>

<style scoped>
/* Add your styles here */
</style>