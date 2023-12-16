<script>
    import { dateLocale, started, elapsedTime, timerDuration } from '../../store';
    
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
    
    async function start() {
        started.set(true);
        elapsedTime.set(0);
	    timerDuration.set(1000 * 60 * 5)
    }
</script>

<hr>
<div class='startscreen'>
    <p class='opener'>Find words by reordering letters.</p>

    <div>
        <button class='btn variant-filled-primary' on:click={start}>Play</button>
    </div>
    <div>
        <button class='btn variant-ringed-primary' on:click={showHowTo}>How To</button>
    </div>
    <div>
        <button class='btn variant-ringed-primary' on:click={showSupport}>Support</button>
    </div>

    <div class='closer'>
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
        margin-bottom: .5rem;
    }
</style>