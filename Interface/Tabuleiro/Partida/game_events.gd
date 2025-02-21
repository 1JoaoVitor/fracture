extends Node

signal on_card_placing(card: CardUI, slot_system: CardSlotSystem, callback: Callable)
signal on_buy_button_pressed(callback: Callable)
signal on_end_turn_button_pressed(callback: Callable)
signal on_card_highlighting(card: CardUI, callback: Callable)
signal on_card_dragging(card: CardUI, callback: Callable)
signal on_game_over()
signal on_mana_spend(player: MatchPlayer, big_mana: int, small_mana: int)
signal on_mana_reset()
