package main

import (
	"fmt"
	"os"

	"github.com/spf13/cobra"
)

func main() {
	var rootCmd = &cobra.Command{Use: "cpthook"}

	var cmdServer = &cobra.Command{
		Use:   "server",
		Short: "Run the server to receive incoming webhooks",
		Run: func(cmd *cobra.Command, args []string) {
			// Your code to start the server
			fmt.Println("Starting server...")
		},
	}

	var cmdWorker = &cobra.Command{
		Use:   "worker",
		Short: "Process outgoing events",
		Run: func(cmd *cobra.Command, args []string) {
			// Your code to start the worker
			fmt.Println("Starting worker...")
		},
	}

	var cmdWeb = &cobra.Command{
		Use:   "web",
		Short: "Serve the HTMX user interface",
		Run: func(cmd *cobra.Command, args []string) {
			// Your code to serve the web UI
			fmt.Println("Serving web UI...")
		},
	}

	rootCmd.AddCommand(cmdServer, cmdWorker, cmdWeb)
	if err := rootCmd.Execute(); err != nil {
		fmt.Fprintln(os.Stderr, err)
		os.Exit(1)
	}
}
