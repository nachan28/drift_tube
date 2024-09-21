<script setup lang="ts">
import { RouterView } from 'vue-router'
</script>

<template>
  <div class="app-container">
    <header class="global-header">
      <img src="/logo.png" alt="logo" class="logo">
    </header>
    <div class="contents">
      <RouterView />
    </div>
  </div>
</template>

<style scoped lang="scss">
.app-container {
  height: 100vh;
  display: flex;
  flex-direction: column;
  align-items: center;
  background-image: linear-gradient(120deg, #a1c4fd 0%, #c2e9fb 100%);

  .global-header {
    width: 100%;
    // background-color: #E0F4FF;
    background-image: url("paper.gif");
    padding:20px;
  }

  .contents {
    width: 100%;
    display: flex;
    justify-content: center;
    align-items: center;
    flex-grow: 1;
  }

  .logo {
    width: 200px;
  }
}



</style>
