abstract class PayState {
  const PayState();
}

class Initial extends PayState {
  const Initial();
}

class PayLoading extends PayState {
  const PayLoading();
}

class PaySucceeded extends PayState {

  const PaySucceeded();
}

class PayFailed extends PayState {
  final String errorMsg;

  const PayFailed({
    required this.errorMsg,
  });
}

