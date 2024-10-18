<template>
  <div id="app">
    <router-view></router-view>
    <FooterComponent />
  </div>
</template>

<script>
import FooterComponent from './components/FooterComponent.vue';

export default {
  name: 'App',
  components: {

    FooterComponent,
  },
};
</script>

<style>
html, body {
  background-color: #1d1d1d !important; /* Background color of the page */
  color: #ffffff !important; /* Text color */
  height: 100%; /* Ensure the body takes the full height of the viewport */
  margin: 0;
  padding: 0;
  display: flex;
  flex-direction: column;
}
</style>
