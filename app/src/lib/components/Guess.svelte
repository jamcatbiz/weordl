<script>
    import { guess } from '../../store';
</script>

<div class='guessContainer'>
    <div class='guess'>
        {#each $guess as char, i (i)}
            <div class='guessChar'>{char}</div>
        {/each}
        <div class='cursor'>|</div>
    </div>
</div>

<style>
    .guessContainer {
        position: relative;
        left: 50%;
        transform: translate(-50%, 0%);
    }

    .guess {
        display: flex;
        position: relative;
        width: fit-content;
        min-height: 2rem;
        left: 50%;
        margin-top: .5rem;
        margin-bottom: 1.5rem;
        transform: translate(-50%, 0%);
    }
    
    .guessChar {
        padding: .2rem;
        display: flex;
        align-items: center;
        font-weight: bold;
        font-size: 25px;
    }

    .cursor {
        padding-bottom: .5rem;
        display: flex;
        font-weight: 100;
        align-items: center;
        font-size: 40px;
        animation: blinker 1.5s linear infinite;
    }

    @keyframes blinker {
        50% {
            opacity: 0;
        }
    }
</style>