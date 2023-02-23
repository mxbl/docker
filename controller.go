package docker

import "github.com/docker/docker/client"

type Controller struct {
	Client *client.Client
}

func NewController() (c *Controller, err error) {
	c = new(Controller)
	c.Client, err = client.NewClientWithOpts(client.FromEnv, client.WithAPIVersionNegotiation())
	if err != nil {
		return nil, err
	}
	return c, nil
}
