<script>
	import { resumed, lastPlayedDate, date } from '../store';
	
	import StartScreen from '$lib/components/StartScreen.svelte';
	import GameScreen from '$lib/components/GameScreen.svelte';
	import ResumeScreen from '$lib/components/ResumeScreen.svelte';
</script>

{#if ($lastPlayedDate != date)}
	<StartScreen />
{:else if !$resumed}
	<ResumeScreen />
{:else}
	<GameScreen />
{/if}