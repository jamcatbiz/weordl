<script>
	import { started } from '../store';
	
	import StartScreen from '$lib/components/StartScreen.svelte';
	import GameScreen from '$lib/components/GameScreen.svelte';
</script>

{#if !$started}
	<StartScreen />
{:else}
	<GameScreen />
{/if}