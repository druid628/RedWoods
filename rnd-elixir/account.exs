defmodule Account do
  def balance(initial, spending) do
    initial - spending
    #discount(initial, 10) 
    #|> interest(0.1)
  end

  def discount(balance, amount) do
    doMath(balance, amount, :SUB);
  end

  def deposit(balance, rate) do
    doMath(balance, rate, :ADD);
  end

  def doMath(balance, changeAmount, :ADD) do
    balance + changeAmount
  end 

  def doMath(balance, changeAmount, :SUB) do
    balance - changeAmount
  end 

  def print_range do
    1..10
    |> IO.puts
  end

  def print_sum do
    1..10
    |> Enum.sum
    |> IO.puts
  end
end

currentBalance = Account.balance(3000, 30)
IO.puts "Current balance: US $#{currentBalance}"
newBalance = Account.balance(currentBalance, 75) |> Account.discount(30) |> Account.discount(30) |> Account.deposit(75)
IO.puts "new  Balance: US $#{newBalance}"
