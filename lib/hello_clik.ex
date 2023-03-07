defmodule HelloClik do
  use Clik.Command
  alias Clik.{Command, CommandEnvironment, Configuration, Option, Platform}
  alias Clik.Renderable
  alias Clik.Output.Table

  def help_text(), do: "Say hello to the world"

  def options() do
    %{
      verbose: Option.new!(:verbose, short: :v, type: :boolean, help: "Be verbose"),
      table: Option.new!(:table, short: :t, type: :boolean, help: "Use a table")
    }
  end

  def run(env) do
    use_tables = Keyword.get(env.options, :table, false)

    greeting =
      if Keyword.get(env.options, :verbose, false) == true do
        "Greetings and salutations!"
      else
        "Hello!"
      end

    write_output(use_tables, greeting, env.output)
  end

  defp write_output(false, greeting, out) do
    IO.puts(out, greeting)
  end

  defp write_output(true, greeting, out) do
    t =
      Table.empty(2, ["Type", "Phrase"])
      |> Table.add_row(["Greeting", greeting])

    Renderable.render(t, out)
  end

  def main(args) do
    config =
      Configuration.add_command!(
        Configuration.new(),
        Command.new!(:hello, __MODULE__)
      )

    env = CommandEnvironment.new(Platform.script_name())
    Clik.run(config, args, env)
  end
end
