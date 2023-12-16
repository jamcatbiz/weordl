<script>
    export const parent = 0;

    import { points, progress, timedProgress, timedPoints, game, statGamesPlayed, statWordsFound } from '../../store';

    import Scoreboard from './Scoreboard.svelte';
    import StatisticsItem from './StatisticsItem.svelte';

	import { modalStore, toastStore } from '@skeletonlabs/skeleton';
	import IconExit from '~icons/fa6-solid/xmark'
	import IconShare from '~icons/fa6-solid/share-nodes'

    const message = 
`Weordl ${game.gameNumber}
=== 🏁 =|= 🏆 =
🟪 ${$timedPoints} | ${$points}
🟣 ${$timedProgress} | ${$progress}
💜 weordl.com`;

    
    const clipboardToast = {
        message: 'Copied score to clipboard',
        timeout: 2000,
        background: 'variant-filled-warning'
    };

    const shareToast = {
        message: 'Thank you for sharing!',
        timeout: 2000,
        background: 'variant-filled-warning'
    };

    const handleShare = async () => {
        if (navigator.share) {
            try {
                await navigator.share({
                    title: 'weordl.com',
                    text: message,
                    url: 'https://weordl.com'
                })
                toastStore.trigger(shareToast)
            } catch (err) {
                handleClipboard()
            }
        } else {
            handleClipboard()
        }
    };

    async function handleClipboard() {
        try {
            navigator.clipboard.writeText(message);
            toastStore.trigger(clipboardToast);
        } catch (err) {
            alert(err);
        }
    };

</script>

{#if $modalStore[0]}
	<div class='modal card p-4 w-modal shadow-xl space-y-4'>
		<div class='exitContainer'>
            <button class='exit ' on:click={modalStore.close}>
                <IconExit />
            </button>
        </div>
		<header class='text-2xl font-bold'>Stats</header>
        
        <div class='statContainer'>
            <StatisticsItem number={$statGamesPlayed} text='games played'/>
            <StatisticsItem number={$statWordsFound} text='words found'/>
        </div>

        <hr>
        <p>Today's 5-minute score</p>
        <Scoreboard thisPoints={$timedPoints} thisProgress={$timedProgress}/>

        <p>Today's total score</p>
        <Scoreboard thisPoints={$points} thisProgress={$progress}/>
        <hr>
        <div>
            <button class='btn variant-filled-primary' on:click={handleShare}>
                <p>Share</p> <IconShare />
            </button>
        </div>
        <div>
            <button class='btn variant-ringed-primary' on:click={modalStore.close}>
                <p>Play More</p>
            </button>
        </div>
	</div>
{/if}

<style>
    .statContainer {
        display: flex;
        text-align: center;
        position: relative;
        align-items: center;
        justify-content: center;
    }

    .btn {
        width: 9rem;
        height: 3rem;
        position: relative;
    }

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
</style>