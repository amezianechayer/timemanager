import { Text, View, StyleSheet } from 'react-native';
import { Link } from 'expo-router';

export default function Index() {
  return (
    <View style={styles.container}>
      <Text style={styles.text}>Bienvenue à la page d'accueil !</Text>
      <Link href="/login" style={styles.button}>
        Aller à la page à propos
      </Link>
      <Link
        href={{
          pathname: '/details/[id]',
          params: { id: 'bacon' },
        }}>
        View user details
      </Link>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#25292e',
    alignItems: 'center',
    justifyContent: 'center',
  },
  text: {
    color: '#fff',
  },
  button: {
    fontSize: 20,
    textDecorationLine: 'underline',
    color: '#fff',
  },
});