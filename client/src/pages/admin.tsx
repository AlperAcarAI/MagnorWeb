import { useState, useEffect } from "react";
import { Button } from "@/components/ui/button";
import { Card } from "@/components/ui/card";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { useToast } from "@/hooks/use-toast";
import { Trash2, Upload } from "lucide-react";
import type { Brand } from "@shared/schema";

const colorOptions = [
  { value: "bg-purple-500", label: "Purple" },
  { value: "bg-blue-500", label: "Blue" },
  { value: "bg-green-500", label: "Green" },
  { value: "bg-yellow-500", label: "Yellow" },
  { value: "bg-red-500", label: "Red" },
  { value: "bg-pink-500", label: "Pink" },
  { value: "bg-indigo-500", label: "Indigo" },
  { value: "bg-orange-500", label: "Orange" },
  { value: "bg-cyan-500", label: "Cyan" },
  { value: "bg-teal-500", label: "Teal" },
  { value: "bg-violet-500", label: "Violet" },
  { value: "bg-emerald-500", label: "Emerald" },
];

export default function Admin() {
  const [brands, setBrands] = useState<Brand[]>([]);
  const [name, setName] = useState("");
  const [logo, setLogo] = useState("");
  const [color, setColor] = useState("bg-purple-500");
  const [loading, setLoading] = useState(false);
  const { toast } = useToast();

  useEffect(() => {
    fetchBrands();
  }, []);

  const fetchBrands = async () => {
    try {
      const response = await fetch("/api/brands");
      const data = await response.json();
      setBrands(data);
    } catch (error) {
      toast({
        title: "Error",
        description: "Failed to fetch brands",
        variant: "destructive",
      });
    }
  };

  const handleImageUpload = (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (file) {
      const reader = new FileReader();
      reader.onloadend = () => {
        setLogo(reader.result as string);
      };
      reader.readAsDataURL(file);
    }
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setLoading(true);

    try {
      const response = await fetch("/api/brands", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({ name, logo, color }),
      });

      if (response.ok) {
        toast({
          title: "Success",
          description: "Brand added successfully",
        });
        setName("");
        setLogo("");
        setColor("bg-purple-500");
        fetchBrands();
      } else {
        throw new Error("Failed to add brand");
      }
    } catch (error) {
      toast({
        title: "Error",
        description: "Failed to add brand",
        variant: "destructive",
      });
    } finally {
      setLoading(false);
    }
  };

  const handleDelete = async (id: string) => {
    try {
      const response = await fetch(`/api/brands/${id}`, {
        method: "DELETE",
      });

      if (response.ok) {
        toast({
          title: "Success",
          description: "Brand deleted successfully",
        });
        fetchBrands();
      } else {
        throw new Error("Failed to delete brand");
      }
    } catch (error) {
      toast({
        title: "Error",
        description: "Failed to delete brand",
        variant: "destructive",
      });
    }
  };

  return (
    <div className="min-h-screen bg-black text-white p-8">
      <div className="max-w-6xl mx-auto">
        <h1 className="text-4xl font-bold mb-8">Admin Panel - Brand Management</h1>

        <div className="grid md:grid-cols-2 gap-8">
          {/* Add Brand Form */}
          <Card className="p-6 bg-zinc-900/50 border-white/10">
            <h2 className="text-2xl font-bold mb-6">Add New Brand</h2>
            <form onSubmit={handleSubmit} className="space-y-4">
              <div>
                <Label htmlFor="name">Brand Name</Label>
                <Input
                  id="name"
                  value={name}
                  onChange={(e) => setName(e.target.value)}
                  placeholder="Enter brand name"
                  required
                  className="bg-zinc-800 border-white/10"
                />
              </div>

              <div>
                <Label htmlFor="logo">Logo (Optional)</Label>
                <div className="flex gap-2">
                  <Input
                    id="logo"
                    type="file"
                    accept="image/*"
                    onChange={handleImageUpload}
                    className="bg-zinc-800 border-white/10"
                  />
                  {logo && (
                    <Button
                      type="button"
                      variant="outline"
                      size="sm"
                      onClick={() => setLogo("")}
                    >
                      Clear
                    </Button>
                  )}
                </div>
                {logo && (
                  <div className="mt-2">
                    <img src={logo} alt="Preview" className="w-16 h-16 object-contain bg-white rounded" />
                  </div>
                )}
              </div>

              <div>
                <Label htmlFor="color">Color</Label>
                <select
                  id="color"
                  value={color}
                  onChange={(e) => setColor(e.target.value)}
                  className="w-full bg-zinc-800 border border-white/10 rounded-md px-3 py-2 text-white"
                >
                  {colorOptions.map((option) => (
                    <option key={option.value} value={option.value}>
                      {option.label}
                    </option>
                  ))}
                </select>
                <div className={`mt-2 w-16 h-16 ${color} rounded-lg`}></div>
              </div>

              <Button type="submit" disabled={loading} className="w-full">
                {loading ? "Adding..." : "Add Brand"}
              </Button>
            </form>
          </Card>

          {/* Brands List */}
          <Card className="p-6 bg-zinc-900/50 border-white/10">
            <h2 className="text-2xl font-bold mb-6">Existing Brands ({brands.length})</h2>
            <div className="space-y-3 max-h-[600px] overflow-y-auto">
              {brands.map((brand) => (
                <div
                  key={brand.id}
                  className="flex items-center justify-between p-3 bg-zinc-800/50 rounded-lg"
                >
                  <div className="flex items-center gap-3">
                    <div className={`w-12 h-12 ${brand.color} rounded-lg flex items-center justify-center`}>
                      {brand.logo ? (
                        <img src={brand.logo} alt={brand.name} className="w-10 h-10 object-contain" />
                      ) : (
                        <span className="text-xs font-bold text-white">
                          {brand.name.substring(0, 2).toUpperCase()}
                        </span>
                      )}
                    </div>
                    <div>
                      <p className="font-semibold">{brand.name}</p>
                      <p className="text-xs text-gray-400">{brand.color}</p>
                    </div>
                  </div>
                  <Button
                    variant="destructive"
                    size="sm"
                    onClick={() => handleDelete(brand.id)}
                  >
                    <Trash2 className="w-4 h-4" />
                  </Button>
                </div>
              ))}
              {brands.length === 0 && (
                <p className="text-center text-gray-500 py-8">No brands yet</p>
              )}
            </div>
          </Card>
        </div>

        <div className="mt-8">
          <Button
            variant="outline"
            onClick={() => window.location.href = "/"}
            className="border-white/20 hover:bg-white/10"
          >
            Back to Home
          </Button>
        </div>
      </div>
    </div>
  );
}
