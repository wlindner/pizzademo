defmodule Pizzaservice do
	use GenServer
	import Logger

	def start_link do
		info "YIPPI UP AND RUNNING"
		GenServer.start_link(__MODULE__, [], name: Pizzaservice)
	end

	def send(pizzaname) do
		GenServer.call(Pizzaservice, {:pizza, pizzaname})
	end

	def handle_call({:pizza, pizzaname}, sender, current_state) do
		resp =
			pizzaname
			|> order_pizza

		{:reply, resp, current_state}
	end

	def menu do
		%{
			"Cheese" => 8.5,
			"Pepperoni" => 10
		}
	end

	def order_pizza(name) do
		case Map.get(menu, name) do
			nil -> {:error, "No such pizza #{name}"}
			price -> {:ok, %{price: price, msg: "Enjoy!"}}
		end
	end
end