enum Actions { Increment, Decrement }

int counterReducer(int state, dynamic action) {
  switch (action) {
    case Actions.Increment:
      return state + 1;
    case Actions.Decrement:
      return state - 1;
    default:
      return state;
  }
}
