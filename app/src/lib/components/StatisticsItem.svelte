<script lang="ts">
	export let number: number;
	export let text: string;
</script>

<div class="item">
	<div class="number">
		<p>{number}</p>
	</div>
	<div class="text">
		<p>{text}</p>
	</div>
</div>

<style>
	.item {
		padding: 0.72rem;
	}

	.number {
		font-size: 28px;
	}

	.text {
		padding-top: 1rem;
	}
</style>
