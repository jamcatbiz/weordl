<script lang="ts">
	import { resumed, lastPlayedDate, date } from 'src/store';

	import StartScreen from '$components/StartScreen.svelte';
	import GameScreen from '$components/GameScreen.svelte';
	import ResumeScreen from '$components/ResumeScreen.svelte';
</script>

{#if $lastPlayedDate != date}
	<StartScreen />
{:else if !$resumed}
	<ResumeScreen />
{:else}
	<GameScreen />
{/if}
