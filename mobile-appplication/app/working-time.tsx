import * as React from "react";
import { View, FlatList, StyleSheet } from "react-native";
import { Button, Card } from "react-native-paper";

export default function WorkingTime() {
  const [workingTimes, setWorkingTimes] = React.useState([
    // Exemple
    { id: '1', date: '2024-10-21', start: '08:00', end: '16:30'},
    { id: '2', date: '2024-09-10', start: '07:00', end: '15:00'},
    { id: '3', date: '2024-12-01', start: '10:00', end: '18:30'},
    { id: '4', date: '2024-10-21', start: '08:00', end: '16:30'},
    { id: '5', date: '2024-09-10', start: '07:00', end: '15:00'}
  ])
  return (
    <View style={styles.container}>
      <FlatList 
        data={workingTimes}
        keyExtractor={(item) => item.id}
        renderItem={({ item }) => (
          <Card style={styles.item}>
            <Card.Title title={`Date : ${item.date}`} />
            <Card.Content>
              <Button style={styles.btn} mode="text" onPress={() => console.log('Modifier')} >
                Début : {item.start}
              </Button>
              <Button mode="text" style={styles.btn} onPress={() => console.log('Modifier')} >
                Fin : {item.end}
              </Button>
            </Card.Content>
          </Card>
        )}
      />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#25292e',
    padding: 20
  },
  text: {
    color: '#fff',
  },
  item: {
    backgroundColor: 'grey',
    marginBottom: 10
  },
  btn: {
    backgroundColor: '#fff',
    marginBottom: 5
  }

});