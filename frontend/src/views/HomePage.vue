<template>
  <div class="home">
    <header>
      <h1>Arkham Tracker</h1>
    </header>
    <main>
      <p>This is the main content of the home page.</p>
      <button @click="handleClick">Click Me</button>
    </main>
    <footer>
      <p>&copy; 2023 Your Company</p>
    </footer>
  </div>
</template>

<script>
export default {
  name: 'HomePage',
  methods: {
    handleClick() {
      alert('Button clicked!');
    }
  }
};
</script>

<style scoped>
.home {
  text-align: center;
  padding: 20px;
}

header {
  background-color: #f8f9fa;
  padding: 10px;
  border-bottom: 1px solid #dee2e6;
}

main {
  margin: 20px 0;
}

button {
  background-color: #007bff;
  color: white;
  border: none;
  padding: 10px 20px;
  cursor: pointer;
}

button:hover {
  background-color: #0056b3;
}

footer {
  margin-top: 20px;
  font-size: 0.8em;
  color: #6c757d;
}
</style>