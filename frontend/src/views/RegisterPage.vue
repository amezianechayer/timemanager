<template>
  <div class="login-container">
    <img src="@/assets/fondEcran.webp" alt="Arkham Tracker Logo" class="background-image">
    <div class="overlay"></div>
    <h1 class="text-6xl font-bold leading-none mr-10">
      <span class="block text-white">Arkham</span>
      <span class="block ml-12 text-white">Tracker</span>
    </h1>

    <div class="login-card">
      <img src="@/assets/iconeApp.webp" alt="Arkham Tracker Logo" class="h-24 w-24 rounded-2xl mx-auto mb-2">

      <form @submit.prevent="handleRegister">
        <div class="form-group">
          <label for="username">Nom d'utilisateur</label>
          <input type="text" id="username" v-model="username" required />
        </div>
        <div class="form-group">
          <label for="mail">Adresse mail</label>
          <input type="email" id="mail" v-model="mail" required />
        </div>
        <div class="form-group">
          <label for="password">Mot de passe</label>
          <input type="password" id="password" v-model="password" required />
        </div>
        <div class="form-group">
          <label for="confirmPassword">Confirmer le mot de passe</label>
          <input type="password" id="confirmPassword" v-model="confirmPassword" required />
        </div>
        <button type="submit">S'inscrire</button>
        <p class="error-message" v-if="errorMessage">{{ errorMessage }}</p>
        <p class="login-link">
          <button type="button" @click="goToLogin">Déjà membre ? Se connecter</button>
        </p>
      </form>
    </div>
  </div>
</template>

<script>
import axios from "axios";
import { useRouter } from "vue-router";
import { ref } from 'vue';

export default {
  setup() {
    const router = useRouter();
    const username = ref('');
    const mail = ref('');
    const password = ref('');
    const confirmPassword = ref('');
    const errorMessage = ref('');

    const validateEmail = (email) => {
      const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
      return re.test(String(email).toLowerCase());
    };

    const handleRegister = async () => {
      if (password.value !== confirmPassword.value) {
        errorMessage.value = 'Les mots de passe ne correspondent pas.';
        return;
      }

      if (!validateEmail(mail.value)) {
        errorMessage.value = 'Veuillez entrer une adresse e-mail valide.';
        return;
      }

      try {
        const response = await axios.post('/register', {
          username: username.value,
          email: mail.value,
          password: password.value,
        });

        if (response.status === 200) {
          await router.push({name: 'Login'});
        }
      } catch (error) {
        errorMessage.value = 'Une erreur est survenue lors de l’inscription.';
      }
    };

    const goToLogin = () => {
      router.push({ name: 'Login' });
    };

    return {
      username,
      mail,
      password,
      confirmPassword,
      errorMessage,
      handleRegister,
      goToLogin,
    };
  }
};
</script>



<style scoped>
/* Les styles sont identiques à ceux de la page de connexion */

.login-container {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100vh;
  position: relative; /* Position relative pour que l'image de fond s'embrique correctement */
  color: #f5f5f5;
  overflow: hidden; /* Pour éviter le débordement */
}

.background-image {
  position: absolute; /* Positionne l'image en arrière-plan */
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  object-fit: cover; /* Pour que l'image couvre tout l'espace */
  z-index: 0; /* S'assure que l'image est derrière le contenu */
}

.overlay {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.5); /* Couleur noire avec opacité */
  z-index: 1; /* Assure que la superposition est au-dessus de l'image de fond */
}

h1 {
  text-align: center;
  margin-bottom: 20px;
  position: relative; /* Positionne le texte par rapport à l'image de fond */
  z-index: 2; /* S'assure que le texte est au-dessus de l'image de fond */
}

.login-card {
  background-color: #282828; /* Couleur du card */
  padding: 20px;
  border-radius: 8px;
  box-shadow: 0 4px 10px rgba(0, 0, 0, 0.5);
  width: 300px;
  position: relative; /* Pour s'assurer que le card est au-dessus de l'image */
  z-index: 2; /* Assure que le card est au-dessus de l'image de fond */
  margin-bottom: 60px;
}

.form-group {
  margin-bottom: 15px;
}

label {
  display: block;
  margin-bottom: 5px;
}

input {
  width: 100%;
  padding: 10px;
  border: 1px solid #444;
  border-radius: 4px;
  background-color: #3b3b3b;
  color: #f5f5f5;
}

input:focus {
  outline: none;
  border-color: #007bff; /* Couleur de survol */
}

button {
  width: 100%;
  padding: 10px;
  background-color: #007bff;
  color: #ffffff;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  font-weight: bold;
}

button:hover {
  background-color: #0056b3; /* Couleur de survol du bouton */
}

.error-message {
  color: #ff0000; /* Couleur rouge pour les messages d'erreur */
  text-align: center;
  margin-top: 10px;
}

.login-link {
  text-align: center;
  margin-top: 10px;
}

.login-link button {
  background: none;
  border: none;
  color: #007bff;
  cursor: pointer;
  text-decoration: underline;
}
</style>


