package main

import (
	"log"

	"github.com/spf13/cobra"

	"github.com/BoKleynen/connect-experiments/cmd/serve"
)

func main() {
	cmd := mkRootCommand()
	if err := cmd.Execute(); err != nil {
		log.Fatal(err)
	}
}

func mkRootCommand() *cobra.Command {
	cmd := &cobra.Command{
		Use: "connect-experiments",
	}

	cmd.AddCommand(serve.MkCommand())

	return cmd
}
