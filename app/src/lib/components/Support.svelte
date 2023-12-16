<script lang="ts">
	export const parent: number = 0;

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
		<header class="text-2xl font-bold">Support</header>

		<div class="thanks">
			We are so grateful for all the incredible support from our users. The easiest way to support
			us is to share our game and play with your favorite people, but check out these other ways
			too!
		</div>

		<hr />
		<div class="row">
			<p>☕️ Buy Me a Coffee</p>
			<a
				href="https://www.buymeacoffee.com/jamcatbiz"
				target="_blank"
				rel="noopener noreferrer"
				style="text-decoration:none;display:inline-block"
			>
				Donate
			</a>
		</div>

		<hr />
		<div class="row">
			<p>👩‍💻 Contribute</p>
			<a
				href="https://github.com/jamcatbiz/weordl"
				target="_blank"
				rel="noopener noreferrer"
				style="text-decoration:none;display:inline-block">GitHub</a
			>
		</div>
	</div>
{/if}

<style>
	.modal {
		text-align: center;
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

	.row {
		display: flex;
		justify-content: space-between;
	}
</style>
