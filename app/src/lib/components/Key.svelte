<script lang="ts">
	export let char: string;
	export let isSelected: boolean;
	export let keyPress: (key?: string) => void;

	const keyClass: string = char == 'ENTER' || char == 'DEL' ? 'key special' : 'key';
</script>

<button class={keyClass} class:selected={isSelected} on:click={() => keyPress(char.toUpperCase())}>
	{char.toUpperCase()}
</button>

<style>
	.key {
		border-width: 0.1rem;
		border-color: rgba(var(--color-primary-600) / 1);
		padding: 3% 3%;
		margin: 0.3% 0.3%;
		cursor: pointer;
		border-radius: 4px;
		transition: background-color 0.3s;
		font-weight: bold;
		touch-action: manipulation;
	}

	.key:hover {
		background-color: rgba(var(--color-primary-300) / 1);
	}

	.selected {
		background-color: rgba(var(--color-primary-500) / 0.2);
		cursor: default;
	}

	.selected:hover {
		background-color: rgba(var(--color-primary-500) / 0.2);
	}

	.special {
		padding: 3% 9%;
	}

	@media (hover: none) {
		.key:hover {
			background-color: rgba(var(--color-surface) / 1);
		}
		.selected:hover {
			background-color: rgba(var(--color-primary-500) / 0.2);
		}
	}
</style>
