import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";
import createReScriptPlugin from "@jihchi/vite-plugin-rescript";

export default defineConfig({
  plugins: [react(), createReScriptPlugin()],
});
