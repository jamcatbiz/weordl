<script>
    export const parent = 0;

	import { game } from '../../store';

	import Support from '$lib/components/Support.svelte';
	import YesterdaysAnswers from '$lib/components/YesterdaysAnswers.svelte'

	import { modalStore } from '@skeletonlabs/skeleton';
    import { LightSwitch } from '@skeletonlabs/skeleton';
	import IconExit from '~icons/fa6-solid/xmark';

	function showSupport() {
		const c = { ref: Support };
		const modal = {
			type: 'component',
			component: c,
			response: (r) => console.log('response', r)
		};
		modalStore.close();
		modalStore.trigger(modal);
	}

	function showYesterdaysAnswers() {
		const c = { ref: YesterdaysAnswers };
		const modal = {
			type: 'component',
			component: c,
			response: (r) => console.log('response', r)
		};
		modalStore.close();
		modalStore.trigger(modal);
	}
</script>

{#if $modalStore[0]}
	<div class='modal card p-4 w-modal shadow-xl space-y-4'>
		<div class='exitContainer'>
            <button class='exit ' on:click={modalStore.close}>
                <IconExit />
            </button>
        </div>

		<header class='text-2xl font-bold'>Settings</header>
		
		<div class='row'>
			<p>Dark mode</p>
			<LightSwitch ring='ring-2px' bgLight='bg-surface-200' bgDark='bg-surface-700'/>
		</div>

		<hr>
		<div class='row'>
			<p>FeedBack</p> <a href='mailto:james.cate.biz@gmail.com?subject=Weordl%20Feedback'>Email</a>
		</div>

		<hr>
		<div class='row'>
			<p>Yesterday's Answers</p><button on:click={showYesterdaysAnswers}>Show</button>
		</div>

		<hr>
		<div class='row'>
			<p>Support</p><button on:click={showSupport}>See How</button>
		</div>

		<hr>
		<div class='row finePrint'>
			<p>© 2023 James Cate</p> <p>#{game.gameNumber}</p>
		</div>
	</div>
{/if}

<style>
	header {
		display: flex;
		justify-content: center;
	}

	button {
		color: rgba(var(--color-primary-600)/1);
		text-decoration: underline;
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
		color: rgba(var(--color-font)/1);
    }

	.row {
		display: flex;
		justify-content: space-between;
	}

	.finePrint {
		color: rgba(var(--color-primary-600)/1);
		font-size: 13px;
	}
</style>