import "./App.css";

import { useDjangolang } from "./api";

function App() {
  const { data, error, isLoading } = useDjangolang("/logical-things", { method: "post" }, { refreshInterval: 1_000 });

  if (isLoading) return "Loading...";

  if (error) return `An error occured: ${error}`;

  return <div>{JSON.stringify(data)}</div>;
}

export default App;
