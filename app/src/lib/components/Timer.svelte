<script lang="ts">
	import { timerDuration, elapsedTime, gameOverShown } from 'src/store';

	import Statistics from '$components/Statistics.svelte';

	import { ProgressBar } from '@skeletonlabs/skeleton';
	import { modalStore } from '@skeletonlabs/skeleton';
  import type { ModalSettings } from '@skeletonlabs/skeleton';

	let last_time: number = window.performance.now();
	let frame: number;

	const c = { ref: Statistics };
	const finishModal: ModalSettings = {
		type: 'component',
		component: c,
		response: (r: any) => console.log('response:', r)
	};

	(function update(): void {
		frame = requestAnimationFrame(update);
		const time: number = window.performance.now();
		elapsedTime.update((prevElapsedTime) => {
			return (prevElapsedTime += Math.min(time - last_time, $timerDuration - prevElapsedTime));
		});
		last_time = time;

		if (!$gameOverShown && $elapsedTime >= $timerDuration) {
			modalStore.trigger(finishModal);
			gameOverShown.set(true);
		}
	})();
</script>

<div class="timerText">
	{((($timerDuration - $elapsedTime) / 60000) | 0).toFixed(0)}:{(
		((($timerDuration - $elapsedTime) % 60000) / 1000) |
		0
	)
		.toFixed(0)
		.padStart(2, '0')}
</div>
<div class="timerBar">
	<ProgressBar
		label="Timer"
		value={$elapsedTime}
		max={$timerDuration}
		meter="variant-filled-primary"
	/>
</div>

<style>
	.timerText {
		padding: 0.5rem;
		cursor: default;
		font-size: 22px;
		display: flex;
		align-items: center;
		justify-content: center;
		position: relative;
	}

	.timerBar {
		display: flex;
		align-items: center;
		justify-content: center;
		position: relative;
	}
</style>
