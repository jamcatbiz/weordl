<script>
    export const parent = 0;

    import { yesterdaysGame } from '../../store';

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
        <h3 class='text-2xl font-bold'>Answers</h3>
        <h5 class='text-2xl font-bold'>#{yesterdaysGame.gameNumber} {yesterdaysGame.word.toUpperCase()}</h5>
        <p>{Object.keys(yesterdaysGame.answers).length} answers</p>
        <hr>
        <div class='answerContainer'>
            <div class='answerList'>
                {#each Object.keys(yesterdaysGame.answers) as answer}
                    <a href=https://en.wiktionary.org/wiki/{answer} target='_blank' rel='noopener noreferrer' style='text-decoration:none;display:inline-block'>
                        <div class='answer'>
                            {answer}
                        </div>
                    </a>
                {/each}
            </div>
        </div>
        <hr>
        <p class='helpText'>Press a word to learn more</p>

	</div>
{/if}

<style>
    .answerContainer {
        min-height: 15rem;
        max-height: 20rem;
        overflow: auto;
    }

    .answerList {
        position: relative;
        left: 50%;
        transform: translate(-50%, 0%);
        column-count: 4;
        column-gap: .5rem;
        text-align: left;
    }

    .answer {
        margin-bottom: .25rem;
        font-size: 15px;
        padding-right: 1rem;
        transition: color .3s;
    }

    .answer:hover {
        color: rgba(var(--color-primary-400)/1);
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
    
    .helpText {
        margin-top: .5rem;
        font-size: 12px;
        color: rgba(var(--color-primary-600)/1);
    }
</style>




