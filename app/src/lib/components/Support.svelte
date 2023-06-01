<script>
    export const parent = 0;

	import { modalStore } from '@skeletonlabs/skeleton';
    import IconExit from '~icons/fa6-solid/xmark';    
</script>

{#if $modalStore[0]}
	<div class='modal card p-4 w-modal shadow-xl space-y-4'>
        <div class='exitContainer'>
            <button class='exit ' on:click={modalStore.close}>
                <IconExit />
            </button>
        </div>
        <header class='text-2xl font-bold'>Support</header>
        
        <div class='thanks'>
            We are so grateful for all the incredible support from our users.
            The easiest way to support us is to share our game and play with your favorite people, but check out these other ways too!
        </div>

        <hr>
        <div class='row'>
            <p>Watch an add</p><p>Coming Soon</p>
        </div>

        <hr>
        <div class='row'>
            <p>Donate</p><p>Coming Soon</p>
        </div>

        <hr>
        <div class='row'>
            <p>Contribute</p><p>Coming Soon</p>
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