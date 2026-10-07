{ pwntools-src }:
_final: prev: {
  pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
    (_pyFinal: pyPrev: {
      pwntools = pyPrev.pwntools.overridePythonAttrs (old: {
        version = "5.0.0.dev0";
        src = pwntools-src;
        meta = old.meta // {
          changelog = "https://github.com/Gallopsled/pwntools/commits/dev";
        };
      });
    })
  ];
}
