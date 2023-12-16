<script>
	import { dateLocale, resumed, statGamesPlayed, guessesSort, guesses } from '../../store';

	import HowTo from '$lib/components/HowTo.svelte';
	import Support from '$lib/components/Support.svelte';

	import { modalStore } from '@skeletonlabs/skeleton';

	function showHowTo() {
		const c = { ref: HowTo };
		const modal = {
			type: 'component',
			component: c,
			response: (r) => console.log('response:', r)
		};
		modalStore.trigger(modal);
	}

	function showSupport() {
		const c = { ref: Support };
		const modal = {
			type: 'component',
			component: c,
			response: (r) => console.log('response:', r)
		};
		modalStore.trigger(modal);
	}

	function resume() {
		resumed.set(true);
    guessesSort.update((prevGuessesSort) => {
      const newGuessesSort = prevGuessesSort;
      for (let guess in $guesses) {
        newGuessesSort[guess[0].toUpperCase()][guess] = true;
      }
      return newGuessesSort;
    });
	}
</script>

<hr />
<div class="startscreen">
	<p class="opener">Keep playing today's game?</p>

	<div>
		<button class="btn variant-filled-primary" on:click={resume}>Continue</button>
	</div>
	<div>
		<button class="btn variant-ringed-primary" on:click={showHowTo}>How To</button>
	</div>
	<div>
		<button class="btn variant-ringed-primary" on:click={showSupport}>Support</button>
	</div>

	<div class="closer">
		<p>{dateLocale}</p>
	</div>
</div>

<style>
	.startscreen {
		width: 100vw;
		text-align: center;
		position: relative;
		left: 50%;
		transform: translate(-50%, 0%);
		overflow: hidden;
	}

	.opener {
		font-size: 25px;
		margin: 5rem;
	}

	.closer {
		margin-top: 1.5rem;
		font-size: 13px;
	}

	.btn {
		width: 9rem;
		height: 3rem;
		margin-bottom: 0.5rem;
	}
</style>
