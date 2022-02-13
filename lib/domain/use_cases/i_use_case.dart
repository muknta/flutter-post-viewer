abstract class IUseCase<T, P> {
  Future<T> execute({required P params});
}

typedef NoParams = void;
