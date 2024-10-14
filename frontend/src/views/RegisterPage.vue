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
          <label for="email">Adresse email</label>
          <input type="email" id="email" v-model="email" required />
        </div>
        <div class="form-group">
          <label for="password">Mot de passe</label>
          <input type="password" id="password" v-model="password" required />
          <p v-if="passwordError" class="error-message">{{ passwordError }}</p>
        </div>
        <div class="form-group">
          <label for="confirmPassword">Confirmer le mot de passe</label>
          <input type="password" id="confirmPassword" v-model="confirmPassword" required />
        </div>
        <button type="submit">S'inscrire</button>
        <p class="error-message" v-if="errorMessage">{{ errorMessage }}</p>
        <p class="login-link">
          <a href="/">Déjà membre ? Se connecter</a>
        </p>
      </form>
    </div>
  </div>
</template>

<script>
import axios from "axios";
import { ref } from 'vue';
import Swal from 'sweetalert2'; // Importer SweetAlert2

export default {
  setup() {
    const username = ref('');
    const email = ref('');
    const password = ref('');
    const confirmPassword = ref('');
    const errorMessage = ref('');
    const passwordError = ref('');

    const validateEmail = (email) => {
      const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
      return re.test(String(email).toLowerCase());
    };

    const validatePassword = (password) => {
      const re = /^(?=.*[A-Z])(?=.*\d)[A-Za-z\d]{8,}$/;
      return re.test(password);
    };

    const handleRegister = async () => {
      errorMessage.value = '';
      passwordError.value = '';

      if (password.value !== confirmPassword.value) {
        errorMessage.value = 'Les mots de passe ne correspondent pas.';
        return;
      }

      if (!validateEmail(email.value)) {
        errorMessage.value = 'Veuillez entrer une adresse e-mail valide.';
        return;
      }

      if (!validatePassword(password.value)) {
        passwordError.value = 'Le mot de passe doit comporter au moins 8 caractères, une majuscule et un chiffre.';
        return;
      }

      try {
        const response = await axios.post('http://localhost:4000/api/users', {
          username: username.value,
          email: email.value,
          hash_password: password.value,
        });

        if (response.status === 201) {
          // Afficher la popup de succès sans redirection
          Swal.fire({
            title: 'Succès!',
            text: 'Votre compte a été créé avec succès !',
            icon: 'success',
            confirmButtonText: 'OK',
            background: '#282828', // Fond de la popup
            color: '#f5f5f5', // Couleur du texte
            confirmButtonColor: '#007bff', // Couleur du bouton de confirmation
            footer: '<span style="color: #f5f5f5;">Votre compte a été créé, vous pouvez désormais vous connecter !</span>' // Message supplémentaire
          });
        }
      } catch (error) {
        if (error.response && error.response.data) {
          errorMessage.value = error.response.data.message || 'Une erreur est survenue lors de l’inscription.';
        } else {
          errorMessage.value = 'Une erreur est survenue lors de l’inscription.';
        }
      }
    };

    return {
      username,
      email,
      password,
      confirmPassword,
      errorMessage,
      passwordError,
      handleRegister,
    };
  }
};
</script>

<style scoped>
.login-container {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100vh;
  position: relative;
  color: #f5f5f5;
  overflow: hidden;
}

.background-image {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  object-fit: cover;
  z-index: 0;
}

.overlay {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.5);
  z-index: 1;
}

h1 {
  text-align: center;
  margin-bottom: 20px;
  position: relative;
  z-index: 2;
}

.login-card {
  background-color: #282828;
  padding: 20px;
  border-radius: 8px;
  box-shadow: 0 4px 10px rgba(0, 0, 0, 0.5);
  width: 400px; /* Augmenter la largeur ici */
  position: relative;
  z-index: 2;
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
  border-color: #007bff;
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
  background-color: #0056b3;
}

.error-message {
  color: #ff0000;
  text-align: center;
  margin-top: 10px;
}

.login-link {
  text-align: center;
  margin-top: 10px;
}

.login-link a {
  color: #007bff;
  text-decoration: underline;
}
</style>
