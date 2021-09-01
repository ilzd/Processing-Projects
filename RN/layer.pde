class Layer {
  Neuron[] neurons;

  Layer(int size) {
    neurons = new Neuron[size];
    for (int i = 0; i < neurons.length; i++) {
      neurons[i] = new Neuron();
    }
  }

  void reset() {
    for (Neuron n : neurons) {
      n.value = 0;
    }
  }

  void propagate() {
    for (Neuron n : neurons) {
      n.carryValue();
    }
  }
}
