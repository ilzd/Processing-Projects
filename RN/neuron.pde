class Neuron {
  float value = 0;
  Connection[] connections;

  Neuron() {
  }

  void accumulate(float value) {
    this.value += value;
  }

  void connect(Layer layer) {
    connections = new Connection[layer.neurons.length];
    for (int i = 0; i < connections.length; i++) {
      connections[i] = new Connection();
    }
    for (int i = 0; i < connections.length; i++) {
      connections[i].destiny = layer.neurons[i];
    }
  }

  void carryValue() {
    for (int i = 0; i < connections.length; i++) {
      connections[i].destiny.accumulate(connections[i].weight * value);
    }
  }
}
