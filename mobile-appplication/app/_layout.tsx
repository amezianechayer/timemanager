import { Stack } from "expo-router";

export default function RootLayout() {
  return (
    <Stack>
      <Stack.Screen name="(tabs)" options={{ headerShown: false }} />
      <Stack.Screen name="login-screen" />
      <Stack.Screen name ="+not-found" />
    </Stack>
    
  );
}
