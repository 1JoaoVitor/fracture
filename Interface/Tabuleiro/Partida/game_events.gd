extends Node

signal on_card_placing(card: CardUI, slot_system: CardSlotSystem, callback: Callable)
signal on_buy_button_pressed(callback: Callable)
signal on_end_turn_button_pressed(callback: Callable)
signal on_card_highlighting(card: CardUI, callback: Callable)
signal on_card_dragging(card: CardUI, callback: Callable)
signal on_game_over()
