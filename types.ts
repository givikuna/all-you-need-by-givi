type CurriedFunction<T> = T extends (...args: unknown[]) => unknown
    ? (args: Parameters<T>) => CurriedFunction<(...args: unknown[]) => any>
    : T;
