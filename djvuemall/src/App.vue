<template>
  <img alt="Vue logo" src="./assets/logo.png" />
  <TestCore></TestCore>
</template>

<script>
import TestCore from '@/components/TestCore.vue';
export default {
  name: 'App',
  components: { TestCore },
};
</script>

<style>
* {
  margin: 0;
  padding: 0;
}
</style>
