/* eslint-disable vue/multi-word-component-names */
<template>
  <header>
    <nav>
      <router-link to="/home">Home</router-link>
      <router-link to="/about">About</router-link>
    </nav>
  </header>
</template>

<script>
export default {};
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