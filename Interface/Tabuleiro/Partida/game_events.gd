extends Node

signal on_card_placing(card: CardUI, slot_system: CardSlotSystem, callback: Callable)
signal on_buy_button_pressed(callback: Callable)
signal on_end_turn_button_pressed(callback: Callable)
signal on_card_highlighting(card: CardUI, callback: Callable)
signal on_card_dragging(card: CardUI, callback: Callable)
signal on_game_over()
signal on_mana_spend(player: MatchPlayer, big_mana: int, small_mana: int)
signal on_mana_reset()
signal on_points_updated(somador: Node, new_points: int)
signal new_turn()
signal match_started()
signal timer_reset()

# a principio esses eventos estão relacionados ao servidor
signal on_player_ready()
signal on_players_receive(players: Array[Player])
signal on_card_added(card_index: int, origin: Node, target: Node)
