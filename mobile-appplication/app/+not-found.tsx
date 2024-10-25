import { View, StyleSheet } from 'react-native';
import { Link, Stack } from 'expo-router';
import { Image } from 'expo-image';

const PlaceholderImage = require('@/assets/images/not-found.png');

export default function NotFound() {
  return (
    <>
      <Stack.Screen options={{ title: 'Oups ! Introuvable' }} />
      <View style={styles.container}>
      <View style={styles.imageContainer}>
        <Image source={PlaceholderImage} style={styles.image} />
      </View>
        <Link href="/(home)/" style={styles.button}>
        Retournez à l'écran d'accueil !
        </Link>
      </View>
    </>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#25292e',
    justifyContent: 'center',
    alignItems: 'center',
  },

  imageContainer: {
  
  },
   image: {
    width: 420,
    height: 540,
    borderRadius: 18,
  },

  button: {
    fontSize: 20,
    color: 'black',
    backgroundColor: '#fff',
    padding: 5,
    borderRadius: 10,
    marginTop: 30
  },
});