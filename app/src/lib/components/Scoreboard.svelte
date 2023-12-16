<script>
    export let thisProgress;
    export let thisPoints;

    import { game, timedPoints, timedProgress, points, progress } from '../../store';

    import { ProgressRadial, toastStore } from '@skeletonlabs/skeleton';
    import IconHeart from '~icons/fa6-regular/heart';

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
                    text: message
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


<div class='score'>
    <div class='points'>
        {thisPoints}
    </div>
    <div class='progress'>
        <ProgressRadial value={thisProgress} stroke={60} meter='stroke-primary-500' width='w-14' font=150>
            {thisProgress}
        </ProgressRadial>
    </div>
    <button class='share' on:click={handleShare}>
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
        color: rgba(var(--color-primary-600)/1);
    }

    .points {
        padding: .72rem;
        font-weight: bold;
        font-size: 17px;
        justify-content: center;
        display: flex;
        border-radius: .3rem;
        border-width: .2rem;
        border-color:  rgba(var(--color-primary-600)/1);
    }

    .progress {
        padding: 1rem;
    }
</style>