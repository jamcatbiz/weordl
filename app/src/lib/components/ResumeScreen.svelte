<script lang="ts">
	import { dateLocale, resumed, guessesSort, guesses } from 'src/store';

	import HowTo from '$components/HowTo.svelte';
	import Support from '$components/Support.svelte';

	import { modalStore } from '@skeletonlabs/skeleton';
  import type { ModalSettings } from '@skeletonlabs/skeleton';

	function showHowTo(): void {
		const c = { ref: HowTo };
		const modal: ModalSettings = {
			type: 'component',
			component: c,
			response: (r: any) => console.log('response:', r)
		};
		modalStore.trigger(modal);
	}

	function showSupport(): void {
		const c = { ref: Support };
		const modal: ModalSettings = {
			type: 'component',
			component: c,
			response: (r: any) => console.log('response:', r)
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
