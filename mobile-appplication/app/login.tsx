import * as React from "react";
import { Text, View, StyleSheet } from "react-native";
import { TextInput, Button, Card } from "react-native-paper";
import { Link } from "expo-router";

export default function LoginScreen() {
  const [email, setEmail] = React.useState("");
  const [password, setPassword] = React.useState("");

  return (
    <View style={styles.container}>
      <Card>
        <Card.Title  title="Connexion" />
        <Card.Content>
          <TextInput
            label="Email"
            value={email}
            onChangeText={setEmail}
            style={styles.input}
          />
          <TextInput
            label="Mot de passe"
            value={password}
            onChangeText={setPassword}
            style={styles.input}
          />
          <Button mode="contained" onPress={() => console.log('Se connecter')} >
            Se connecter
          </Button>
        </Card.Content>
      </Card>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: "#25292e",
    justifyContent: "center",
    padding: 20
  },
  text: {
    color: "#fff",
  },
  input: {
    marginBottom: 10
  },
  button: {
    fontSize: 20,
    textDecorationLine: "underline",
    color: "#fff",
  },
});
