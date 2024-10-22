<template>
  <HeaderComponent />
  <div>

    <section class="organisation">
      <h1 class="text-4xl font-bold mb-8 text-center">Organisation de la ville</h1>

      <div class="organigramme text-black">
        <ul class="metiers-container">
          <li v-for="(metier, indexMetier) in corpsMetiers" :key="metier.nom" class="metier-column">
            <div @click="toggleMetier(indexMetier)" class="metier text-black">
              <span>{{ metier.nom }}</span>
              <button class="toggle-btn text-black" @click.stop="toggleMetier(indexMetier)">
                {{ metier.expanded ? 'Réduire' : 'Déplier' }}
              </button>
            </div>

            <ul v-show="metier.expanded" class="groupes text-black">
              <li v-for="(groupe, indexGroupe) in metier.groupes" :key="groupe.nom" class="groupe text-black">
                <div @click="toggleGroupe(indexMetier, indexGroupe)">
                  <span>{{ groupe.nom }}</span>
                  <button class="toggle-btn text-black" @click.stop="toggleGroupe(indexMetier, indexGroupe)">
                    {{ groupe.expanded ? 'Réduire' : 'Déplier' }}
                  </button>
                </div>

                <ul v-show="groupe.expanded" class="utilisateurs-list text-black">
                  <li v-for="utilisateur in groupe.utilisateurs" :key="utilisateur" class="utilisateur text-black">
                    {{ utilisateur }}
                  </li>
                </ul>
              </li>
            </ul>
          </li>
        </ul>
      </div>
    </section>
  </div>
</template>

<script>
import HeaderComponent from "@/components/HeaderComponent.vue";

export default {
  name: 'OrganisationPage',
  components: {HeaderComponent},
  data() {
    return {
      corpsMetiers: [
        {
          nom: 'Police',
          expanded: false,
          groupes: [
            { nom: 'Groupe 1', expanded: false, utilisateurs: ['John Doe', 'Jane Smith', 'Jim Brown'] },
            { nom: 'Groupe 2', expanded: false, utilisateurs: ['Mike Johnson', 'Alice Blue'] },
            { nom: 'Groupe 3', expanded: false, utilisateurs: ['Bob Green', 'Samantha White'] },
          ],
        },
        {
          nom: 'Pompiers',
          expanded: false,
          groupes: [
            { nom: 'Groupe A', expanded: false, utilisateurs: ['Tom Cruise', 'Elena Black'] },
            { nom: 'Groupe B', expanded: false, utilisateurs: ['Sarah Connor', 'Rick Sanchez'] },
          ],
        },
        {
          nom: 'Médecins',
          expanded: false,
          groupes: [
            { nom: 'Groupe X', expanded: false, utilisateurs: ['Greg House', 'Meredith Grey'] },
            { nom: 'Groupe Y', expanded: false, utilisateurs: ['John Carter', 'Lucy Knight'] },
          ],
        },
        {
          nom: 'développeurs',
          expanded: false,
          groupes: [
            { nom: 'Groupe A', expanded: false, utilisateurs: ['Tom Cruise', 'Elena Black'] },
            { nom: 'Groupe B', expanded: false, utilisateurs: ['Sarah Connor', 'Rick Sanchez'] },
          ],
        },
      ],
    };
  },
  methods: {
    toggleMetier(indexMetier) {
      this.corpsMetiers[indexMetier].expanded = !this.corpsMetiers[indexMetier].expanded;
    },
    toggleGroupe(indexMetier, indexGroupe) {
      this.corpsMetiers[indexMetier].groupes[indexGroupe].expanded = !this.corpsMetiers[indexMetier].groupes[indexGroupe].expanded;
    },
  },
};
</script>

<style scoped>
/* Styles pour l'organigramme avec mise en page en colonnes */
.organigramme {
  display: flex;
  justify-content: center;
}

.metiers-container {
  display: flex;
  justify-content: space-around;
  width: 100%;
}

.metier-column {
  flex: 1;
  margin: 0 10px;
  text-align: center;
}

.metier, .groupe {
  display: flex;
  justify-content: space-between;
  align-items: center;
  border: 1px solid #ccc;
  padding: 10px;
  border-radius: 5px;
  background-color: #f9f9f9;
  cursor: pointer;
  margin-bottom: 10px;
}

.metier {
  background-color: #e3f2fd;
}

.groupe {
  background-color: #f1f8e9;
}

.utilisateurs-list {
  list-style-type: none;
  padding-left: 20px;
}

.utilisateur {
  background-color: #c8e6c9;
  padding: 10px;
  margin: 5px 0;
  border-radius: 5px;
}

.toggle-btn {
  background-color: #007BFF;
  color: white;
  border: none;
  padding: 5px 10px;
  border-radius: 5px;
  cursor: pointer;
}

.toggle-btn:hover {
  background-color: #0056b3;
}

/* Organisation des colonnes pour que chaque métier prenne seulement 1/3 */
.metier-column {
  max-width: 30%;
}
</style>
