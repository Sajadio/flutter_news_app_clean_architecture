enum ResourceStatus { success, failure }

class Resource<T> {
  final T? data;
  final Exception? exception;
  final ResourceStatus status;

  Resource.success(this.data)
      : status = ResourceStatus.success,
        exception = null;
  Resource.failure(this.exception)
      : status = ResourceStatus.failure,
        data = null;
}
