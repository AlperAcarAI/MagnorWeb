import { Switch, Route } from "wouter";
import { useEffect } from "react";
import { queryClient } from "./lib/queryClient";
import { QueryClientProvider } from "@tanstack/react-query";
import { Toaster } from "@/components/ui/toaster";
import { TooltipProvider } from "@/components/ui/tooltip";
import Home from "@/pages/home";
import Admin from "@/pages/admin";
import PitchDeck from "@/pages/pitchdeck";
import Login from "@/pages/login";
import Dashboard from "@/pages/dashboard";
import KOLs from "@/pages/kols";
import KOLForm from "@/pages/kol-form";
import KOLDetail from "@/pages/kol-detail";
import Pricing from "@/pages/pricing";
import Agencies from "@/pages/agencies";
import AgencyForm from "@/pages/agency-form";
import Reports from "@/pages/reports";
import NotFound from "@/pages/not-found";

function Router() {
  return (
    <Switch>
      <Route path="/" component={Home} />
      <Route path="/admin" component={Admin} />
      <Route path="/pitchdeck" component={PitchDeck} />
      <Route path="/app" component={Login} />
      <Route path="/app/dashboard" component={Dashboard} />
      <Route path="/app/kols" component={KOLs} />
      <Route path="/app/kols/view/:id" component={KOLDetail} />
      <Route path="/app/kols/:id" component={KOLForm} />
      <Route path="/app/pricing" component={Pricing} />
      <Route path="/app/agencies" component={Agencies} />
      <Route path="/app/agencies/:id" component={AgencyForm} />
      <Route path="/app/reports" component={Reports} />
      <Route component={NotFound} />
    </Switch>
  );
}

function App() {
  useEffect(() => {
    document.documentElement.classList.remove('dark');
  }, []);

  return (
    <QueryClientProvider client={queryClient}>
      <TooltipProvider>
        <Toaster />
        <Router />
      </TooltipProvider>
    </QueryClientProvider>
  );
}

export default App;
