import { Text, View, StyleSheet } from "react-native";
import { Link } from "expo-router";

import Button from "@/components/Btn";

export default function Index() {
  return (
    <View style={styles.container}>
      <Text style={styles.text}>Bienvenue à la page d'accueil !</Text>
      <Link href="/login" style={styles.button}>
        Aller à la page à propos
      </Link>
      <Link href="/working-time" style={styles.button}>
        Aller à la liste des activités
      </Link>
      <Link
        href={{
          pathname: "/details/[id]",
          params: { id: "bacon" },
        }}
      >
        View user details
      </Link>
      <View style={styles.footerContainer}>
        <Button theme="primary" label="Pointage" />
        <Button theme="primary" label="Historique" />
      </View>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flexDirection: "column",
    flex: 3,
    backgroundColor: "#25292e",
    alignItems: "center",
    justifyContent: "center",
  },
  text: {
    color: "#fff",
  },
  button: {
    fontSize: 20,
    textDecorationLine: "underline",
    color: "#fff",
  },
  footerContainer: {
    flex: 1,
    alignItems: "center",
    justifyContent: "flex-end",
    marginBottom: 40,
  },
});
