<script lang="ts">
	export const parent = 0;

	import Scoreboard from './Scoreboard.svelte';

	import { modalStore } from '@skeletonlabs/skeleton';

  // @ts-ignore
	import IconExit from '~icons/fa6-solid/xmark';
</script>

{#if $modalStore[0]}
	<div class="modal card p-4 w-modal shadow-xl space-y-4">
		<div class="exitContainer">
			<button class="exit" on:click={modalStore.close}>
				<IconExit />
			</button>
		</div>
		<h3 class="text-2xl font-bold">How To Play</h3>
		<p>Find words by reordering letters.</p>
		<p />
		<hr />
		<div class="instructions">
			<p>
				Weordl (pronounced we-or-dull, like reorder) is a game of anagrams.<br />
				An anagram is a word created by reordering the letters of another word.
			</p>
			<ul>
				<li>🏁 &ensp; Find words for 5 minutes</li>
				<li>🏆 &ensp; Keep playing to find them all</li>
				<li>🍀 &ensp; Words must be 4+ letters</li>
				<li>💪 &ensp; More letters = more points</li>
			</ul>

			<hr />
			<br />

			<h3 class="text-2xl font-bold">Scoring</h3>
			<Scoreboard thisProgress={82} thisPoints={280} />
			<ul>
				<li>🟪 &ensp; Rectangle is points</li>
				<li>🟣 &ensp; Circle is % of words found</li>
				<li>💜 &ensp; Tap heart to share</li>
			</ul>
		</div>

		<hr />
		<p>A new puzzle is released daily at midnight est.</p>
	</div>
{/if}

<style>
	ul {
		margin: 0.5rem 0rem;
	}

	.modal {
		padding: 1.5rem;
		font-size: 15px;
		height: fit-content;
	}

	.exitContainer {
		justify-content: right;
		display: flex;
	}

	.exit {
		font-size: 15px;
	}
</style>
