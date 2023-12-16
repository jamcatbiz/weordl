<script lang="ts">
	import { guessesSort, guesses } from 'src/store';
</script>

<div class="answerList">
	{#if Object.keys($guesses).length == 0}
		<p>Your answers will display here</p>
	{:else}
		{#each Object.keys($guessesSort) as char}
			{#if Object.keys($guessesSort[char]).length > 0}
				<div class="answerColumn">
					{#each Object.keys($guessesSort[char]).sort() as word}
						<a
							href="https://en.wiktionary.org/wiki/{word}"
							target="_blank"
							rel="noopener noreferrer"
							style="text-decoration:none;display:inline-block"
						>
							<div class="answer text-token">{word}</div>
						</a>
					{/each}
				</div>
			{/if}
		{/each}
	{/if}
</div>
<p class="helpText">Press a word to learn more</p>

<style>
	.answerList {
		position: relative;
		left: 50%;
		transform: translate(-50%, 0%);
		display: flex;
		justify-content: center;
		padding: 1rem;
		margin-top: 3rem;
		border-color: rgba(var(--color-primary-600) / 1);
		border-top-width: 0.1rem;
		border-bottom-width: 0.1rem;
		min-height: 4rem;
	}

	.answerColumn {
		align-items: left;
		width: 4.5em;
		text-align: left;
	}

	.answer {
		margin-bottom: 0.2rem;
		font-size: 15px;
		padding-right: 1rem;
		border-radius: 2px;
		transition: color 0.3s;
	}

	.answer:hover {
		color: rgba(var(--color-primary-400) / 1);
	}

	.helpText {
		margin-top: 0.5rem;
		font-size: 12px;
		color: rgba(var(--color-primary-600) / 1);
	}
</style>
