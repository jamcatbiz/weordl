<script lang="ts">
	import { progress, points } from 'src/store';

	import Keyboard from '$components/Keyboard.svelte';
	import Guess from '$components/Guess.svelte';
	import Timer from '$components/Timer.svelte';
	import Scoreboard from '$components/Scoreboard.svelte';
	import Word from '$components/Word.svelte';
	import AnswerList from './AnswerList.svelte';
</script>

<hr />
<div class="gamescreen">
	<Word />
	<Timer />
	<Scoreboard thisProgress={$progress} thisPoints={$points} />
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
