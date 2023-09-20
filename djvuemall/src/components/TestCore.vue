<template>
  <div class="hello">sdafg</div>
</template>

<script>
import { testCoreApi } from '@/restful/api';
export default {
  name: 'HelloWorld',
  props: {
    msg: String,
  },
  mounted() {
    console.log(6666);
    testCoreApi().then((res) => {
      console.log(77, res);
    });
  },
};
</script>
