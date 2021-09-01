class Net {
  int layerCount;
  float mutatingRate;
  float[][][] activations;
  float[][][] weights;
  float[][][] biases;

  Net(int[] layerData, float weightRange, float biasRange, float mutatingRate) {
    layerCount = layerData.length;
    this.mutatingRate = mutatingRate;

    activations = new float[layerData.length][][];
    activations[0] = new float[layerData[0]][1];

    weights = new float[layerData.length - 1][][];
    for (int i = 0; i < weights.length; i++) {
      weights[i] = new float[layerData[i + 1]][layerData[i]];
      for (int j = 0; j < weights[i].length; j++) {
        for (int k = 0; k < weights[i][j].length; k++) {
          weights[i][j][k] = random(-weightRange, weightRange);
        }
      }
    }

    biases = new float[layerData.length - 1][][];
    for (int i = 0; i < biases.length; i++) {
      biases[i] = new float[layerData[i + 1]][1];
      for (int j = 0; j < biases[i].length; j++) {
        biases[i][j][0] = random(-biasRange, biasRange);
      }
    }
  }

  Net(Net parent) {
    this.layerCount = parent.layerCount;
    this.mutatingRate = parent.mutatingRate;

    this.activations = new float[parent.activations.length][][];
    this.activations[0] = new float[parent.activations[0].length][1];

    this.weights = new float[parent.weights.length][][];
    for (int i = 0; i < this.weights.length; i++) {
      this.weights[i] = new float[parent.weights[i].length][];
      for (int j = 0; j < weights[i].length; j++) {
        this.weights[i][j] = new float[parent.weights[i][j].length];
        for (int k = 0; k < weights[i][j].length; k++) {
          this.weights[i][j][k] = parent.weights[i][j][k];
        }
      }
    }

    this.biases = new float[parent.biases.length][][];
    for (int i = 0; i < this.biases.length; i++) {
      this.biases[i] = new float[parent.biases[i].length][1];
      for (int j = 0; j < biases[i].length; j++) {
        this.biases[i][j][0] = parent.biases[i][j][0];
      }
    }
  }

  void fillInput(float[] input) {
    for (int i = 0; i < activations[0].length; i++) {
      activations[0][i][0] = input[i];
    }
  }

  void activateLayer(int layer) {
    for (int i = 0; i < activations[layer].length; i++) {
      activations[layer][i][0] = sigmoid(activations[layer][i][0]);
    }
  }

  void resetActivations() {
    for (int i = 0; i < activations.length; i++) {
      for (int j = 0; j < activations[i].length; j++) {
        activations[i][j][0] = 0;
      }
    }
  }

  float[] solve(float[] input) {
    //resetActivations();
    fillInput(input);

    for (int i = 0; i < layerCount - 1; i++) {
      float[][] result = multiplyMatrices(weights[i], activations[i]);
      result = addMatrices(result, biases[i]);
      activations[i + 1] = result;
      activateLayer(i + 1);
    }

    float[] output = new float[activations[activations.length - 1].length];

    for (int i = 0; i < output.length; i++) {
      output[i] = activations[activations.length - 1][i][0];
    }

    return output;
  }

  void printNet() {
    println("Weights:\n");
    for (int i = 0; i < weights.length; i++) {
      for (int j = 0; j < weights[i].length; j++) {
        for (int k = 0; k < weights[i][j].length; k++) {
          print(weights[i][j][k] + " * ");
        }
        println();
      }
      println();
    }

    println("\nBiases:\n");
    for (int i = 0; i <  biases.length; i++) {
      for (int j = 0; j < biases[i].length; j++) {
        print(biases[i][j][0] + " * ");
      }
      println();
    }
    println();
    println();
  }

  float sigmoid(float x) {
    return 1 / (1 + exp(-x));
  }

  float[][] multiplyMatrices(float[][] firstMatrix, float[][] secondMatrix) {
    float[][] product = new float[firstMatrix.length][secondMatrix[0].length];
    for (int i = 0; i < firstMatrix.length; i++) {
      for (int j = 0; j < secondMatrix[0].length; j++) {
        for (int k = 0; k < firstMatrix[0].length; k++) {
          product[i][j] += firstMatrix[i][k] * secondMatrix[k][j];
        }
      }
    }
    return product;
  }

  float[][] addMatrices(float[][] firstMatrix, float[][] secondMatrix) {
    float[][] sum = new float[firstMatrix.length][firstMatrix[0].length];

    for (int i = 0; i < sum.length; i++) {
      for (int j = 0; j < sum[0].length; j++) {
        sum[i][j] = firstMatrix[i][j] + secondMatrix[i][j];
      }
    }

    return sum;
  }

  void mutate() {
    for (int i = 0; i < weights.length; i++) {
      for (int j = 0; j < weights[i].length; j++) {
        for (int k = 0; k < weights[i][j].length; k++) {
          weights[i][j][k] += (random(1) < 0.5)? -mutatingRate : mutatingRate;
          //weights[i][j][k] += random(-mutatingRate, mutatingRate);
        }
      }
    }

    for (int i = 0; i < biases.length; i++) {
      for (int j = 0; j < biases[i].length; j++) {
        biases[i][j][0] += (random(1) < 0.5)? -mutatingRate : mutatingRate;
        //biases[i][j][0] += random(-mutatingRate, mutatingRate);
      }
    }
  }
}
