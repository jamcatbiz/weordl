<script lang="ts">
	import '../theme.postcss';
	import '@skeletonlabs/skeleton/styles/all.css';
	import '../app.postcss';

	//import IconHamburger from '~icons/fa6-solid/bars'
  // @ts-ignore
	import IconHowTo from '~icons/fa6-regular/circle-question';
  // @ts-ignore
	import IconStatistics from '~icons/fa6-solid/chart-column';
  // @ts-ignore
	import IconSettings from '~icons/fa6-solid/gear';
  // @ts-ignore
	import IconBars from '~icons/fa6-solid/bars';

	import { AppShell } from '@skeletonlabs/skeleton';
	import { AppBar } from '@skeletonlabs/skeleton';
	import { Toast } from '@skeletonlabs/skeleton';
	import { Modal, modalStore } from '@skeletonlabs/skeleton';
  import type { ModalSettings } from '@skeletonlabs/skeleton';

	import HowTo from '$components/HowTo.svelte';
	import Statistics from '$components/Statistics.svelte';
	import Settings from '$components/Settings.svelte';

	function showHowTo(): void {
		const c = { ref: HowTo };
		const modal: ModalSettings = {
			type: 'component',
			component: c,
			response: (r: any) => console.log('response:', r)
		};
		modalStore.trigger(modal);
	}

	function showStatistics(): void {
		const c = { ref: Statistics };
		const modal: ModalSettings = {
			type: 'component',
			component: c,
			response: (r: any) => console.log('response:', r)
		};
		modalStore.trigger(modal);
	}

	function showSettings(): void {
		const c = { ref: Settings };
		const modal: ModalSettings = {
			type: 'component',
			component: c,
			response: (r: any) => console.log('response:', r)
		};
		modalStore.trigger(modal);
	}
</script>

<Modal position="items-top" />
<Toast position="t" buttonDismissLabel="" buttonDismiss="" />

<AppShell>
	<svelte:fragment slot="header">
		<AppBar
			background="bg"
			gridColumns="grid-cols-3"
			slotDefault="place-self-center"
			slotTrail="place-content-end"
		>
			<svelte:fragment slot="lead">
				<IconBars />
			</svelte:fragment>
			<p class="pageTitle">Weordl</p>
			<svelte:fragment slot="trail">
				<button aria-label="How To" on:click={showHowTo}>
					<IconHowTo />
				</button>
				<button aria-label="Statistics" on:click={showStatistics}>
					<IconStatistics />
				</button>
				<button aria-label="Settings" on:click={showSettings}>
					<IconSettings />
				</button>
			</svelte:fragment>
		</AppBar>
	</svelte:fragment>
	<!-- Router Slot -->
	<slot />
	<!-- ---- / ---- -->
	<svelte:fragment slot="pageFooter" />
</AppShell>

<style>
	.pageTitle {
		font-size: 27px;
		font-family: serif;
		font-weight: bold;
	}
</style>
