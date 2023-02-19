package connect

import (
	"context"
	"fmt"
	"net/http"

	"github.com/bufbuild/connect-go"
	"google.golang.org/protobuf/types/known/timestamppb"

	greetv1 "github.com/BoKleynen/connect-experiments/gen/proto/greet/v1"
	"github.com/BoKleynen/connect-experiments/gen/proto/greet/v1/greetv1connect"
)

type GreetService struct{}

func RegisterGreetService(s *GreetService, mux *http.ServeMux) {
	path, handler := greetv1connect.NewGreeterServiceHandler(s)
	mux.Handle(path, handler)
}

func (s *GreetService) Greet(
	ctx context.Context,
	req *connect.Request[greetv1.GreetMessage],
) (*connect.Response[greetv1.GreetResponse], error) {
	resp := connect.NewResponse(&greetv1.GreetResponse{
		Greeting:  fmt.Sprintf("Hello %s", req.Msg.GetName()),
		Timestamp: timestamppb.Now(),
	})

	return resp, nil
}
