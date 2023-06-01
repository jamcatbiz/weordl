<script>
    import { timerDuration, elapsedTime, gameOverShown} from '../../store';
    import { onDestroy } from 'svelte';

    import Statistics from '$lib/components/Statistics.svelte';

	import { ProgressBar } from '@skeletonlabs/skeleton';
	import { modalStore } from '@skeletonlabs/skeleton';

	let last_time = window.performance.now();
    let frame;

    (function update() {
        frame = requestAnimationFrame(update);
		const time = window.performance.now()
		elapsedTime.update(prevElapsedTime => {
            return prevElapsedTime += Math.min(
                time - last_time,
                $timerDuration - prevElapsedTime
		    );
        });
		last_time = time;

        if (!$gameOverShown && $elapsedTime >= $timerDuration){
            modalStore.trigger(finishModal);
            gameOverShown.set(true);
        }
	}());

	onDestroy(() => {
		cancelAnimationFrame(finishModal);
	});

    const c = { ref: Statistics };
    const finishModal = {
        type: 'component',
        component: c,
        response: (r) => console.log('response:', r)
    };

</script>

<div class='timerText'>
    {(($timerDuration - $elapsedTime) / 60000 | 0).toFixed(0)}:{((($timerDuration - $elapsedTime) % 60000 / 1000 | 0)).toFixed(0).padStart(2, '0')}
</div>
<div class='timerBar'>
    <ProgressBar label='Timer' value={$elapsedTime} max={$timerDuration} meter='variant-filled-primary'/>
</div>

<style>
    .timerText {
        padding: .5rem;
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