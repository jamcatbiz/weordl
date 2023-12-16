<script lang="ts">
	import { game } from 'src/store';
</script>

<div class="word">
	{game.word.toUpperCase()}
</div>

<style>
	.word {
		padding: 1.7rem;
		font-size: 30px;
		font-weight: bold;
		letter-spacing: 0.33rem;
		display: flex;
		align-items: center;
		justify-content: center;
	}
</style>
