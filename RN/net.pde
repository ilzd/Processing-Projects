class NeuralNetwork {
  Layer[] layers;
  float learningRate = 0.01;
  int[] sizes;
  float error;

  NeuralNetwork(int[] sizes) {
    this.sizes = sizes;

    layers = new Layer[sizes.length];
    for (int i = 0; i < layers.length; i++) {
      layers[i] = new Layer(sizes[i]);
    }

    for (int i = 0; i < layers.length - 1; i++) {
      for (int j = 0; j < layers[i].neurons.length; j++) {
        layers[i].neurons[j].connect(layers[i + 1]);
      }
    }
  }

  void reset() {
    for (Layer l : layers) {
      l.reset();
    }
  }

  void test(float[] input, float[] expected) {
    reset();

    float[] output = solve(input);
    for (int i = 0; i < output.length; i++) {
      error += abs(output[i] - expected[i]);
    }
  }

  float[] solve(float[] input) {
    reset();

    for (int i = 0; i < input.length; i++) {
      layers[0].neurons[i].value = input[i];
    }

    for (int i = 0; i < layers.length - 1; i++) {
      layers[i].propagate();
    }

    float[] output = new float[layers[layers.length - 1].neurons.length];
    for (int i = 0; i < output.length; i++) {
      output[i] = layers[layers.length - 1].neurons[i].value;
    }

    return output;
  }

  NeuralNetwork reproduce() {
    NeuralNetwork baby = new NeuralNetwork(sizes);
    for (int i = 0; i < layers.length - 1; i++) {
      for (int j = 0; j < layers[i].neurons.length; j++) {
        for (int k = 0; k < baby.layers[i].neurons[j].connections.length; k++) {
          baby.layers[i].neurons[j].connections[k].weight = this.layers[i].neurons[j].connections[k].weight + random(-learningRate, learningRate);
        }
      }
    }

    return baby;
  }
}
