<script>
    import { progress, points } from '../../store.js'

    import Keyboard from '$lib/components/Keyboard.svelte';
    import Guess from '$lib/components/Guess.svelte';
    import Timer from '$lib/components/Timer.svelte';
    import Scoreboard from '$lib/components/Scoreboard.svelte';
    import Word from '$lib/components/Word.svelte';
	import AnswerList from './AnswerList.svelte';
</script>

<hr>
<div class='gamescreen'>
    <Word />
    <Timer />
    <Scoreboard thisProgress={$progress} thisPoints={$points}/>
    <Guess />
    <Keyboard />
    <AnswerList />
</div>

<style>
    .gamescreen {
        width: 100vw;
        text-align: center;
        position: relative;
        padding: 0rem 4rem;
        left: 50%;
        transform: translate(-50%, 0%);
    }
</style>