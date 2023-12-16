<script lang="ts">
	export let thisProgress: number;
	export let thisPoints: number;

	import { game, timedPoints, timedProgress, points, progress } from 'src/store';

	import { ProgressRadial, toastStore } from '@skeletonlabs/skeleton';
  import type { ToastSettings } from '@skeletonlabs/skeleton';


  // @ts-ignore
	import IconHeart from '~icons/fa6-regular/heart';

	const message: string = `Weordl ${game.gameNumber}
=== 🏁 =|= 🏆 =
🟪 ${$timedPoints} | ${$points}
🟣 ${$timedProgress} | ${$progress}
💜 weordl.com`;

	const clipboardToast: ToastSettings = {
		message: 'Copied score to clipboard',
		timeout: 2000,
		background: 'variant-filled-warning'
	};

	const shareToast: ToastSettings = {
		message: 'Thank you for sharing!',
		timeout: 2000,
		background: 'variant-filled-warning'
	};

	const handleShare: () => Promise<void> = async () => {
		if (navigator.share) {
			try {
				await navigator.share({
					text: message
				});
				toastStore.trigger(shareToast);
			} catch (err) {
				handleClipboard();
			}
		} else {
			handleClipboard();
		}
	};

	async function handleClipboard(): Promise<void> {
		try {
			navigator.clipboard.writeText(message);
			toastStore.trigger(clipboardToast);
		} catch (err) {
			alert(err);
		}
	}
</script>

<div class="score">
	<div class="points">
		{thisPoints}
	</div>
	<div class="progress">
		<ProgressRadial
			value={thisProgress}
			stroke={60}
			meter="stroke-primary-500"
			width="w-14"
			font={150}
		>
			{thisProgress}
		</ProgressRadial>
	</div>
	<button class="share" on:click={handleShare}>
		<IconHeart />
	</button>
</div>

<style>
	.score {
		position: relative;
		width: 100%;
		left: 50%;
		transform: translate(-50%, 0%);
		align-items: center;
		justify-content: center;
		display: flex;
		padding: 1rem;
	}

	.share {
		font-size: 42px;
		color: rgba(var(--color-primary-600) / 1);
	}

	.points {
		padding: 0.72rem;
		font-weight: bold;
		font-size: 17px;
		justify-content: center;
		display: flex;
		border-radius: 0.3rem;
		border-width: 0.2rem;
		border-color: rgba(var(--color-primary-600) / 1);
	}

	.progress {
		padding: 1rem;
	}
</style>
