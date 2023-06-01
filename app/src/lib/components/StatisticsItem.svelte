<script>
    export let number;
    export let text;
</script>

<div class='item'>
    <div class='number'>
        <p>{number}</p>
    </div>
    <div class='text'>
        <p>{text}</p>
    </div>
</div>


<style>
    .item {
        padding: .72rem;
    }

    .number {
        font-size: 28px;
    }

    .text {
        padding-top: 1rem;
    }
</style>