import { type User, type InsertUser, type Brand, type InsertBrand } from "@shared/schema";
import { randomUUID } from "crypto";
import { readFile, writeFile } from "fs/promises";
import { existsSync } from "fs";

// modify the interface with any CRUD methods
// you might need

export interface IStorage {
  getUser(id: string): Promise<User | undefined>;
  getUserByUsername(username: string): Promise<User | undefined>;
  createUser(user: InsertUser): Promise<User>;
  getBrands(): Promise<Brand[]>;
  insertBrand(brand: InsertBrand): Promise<Brand>;
  deleteBrand(id: string): Promise<void>;
}

const DATA_FILE = "data/storage.json";

export class MemStorage implements IStorage {
  private users: Map<string, User>;
  private brands: Map<string, Brand>;

  constructor() {
    this.users = new Map();
    this.brands = new Map();
    this.loadData();
  }

  private async loadData() {
    try {
      if (existsSync(DATA_FILE)) {
        const data = await readFile(DATA_FILE, "utf-8");
        const parsed = JSON.parse(data);
        
        if (parsed.users) {
          for (const user of parsed.users) {
            this.users.set(user.id, user);
          }
        }
        
        if (parsed.brands) {
          for (const brand of parsed.brands) {
            this.brands.set(brand.id, brand);
          }
        }
        
        console.log("Data loaded from file");
      }
    } catch (error) {
      console.error("Error loading data:", error);
    }
  }

  private async saveData() {
    try {
      const data = {
        users: Array.from(this.users.values()),
        brands: Array.from(this.brands.values()),
      };
      
      await writeFile(DATA_FILE, JSON.stringify(data, null, 2));
    } catch (error) {
      console.error("Error saving data:", error);
    }
  }

  async getUser(id: string): Promise<User | undefined> {
    return this.users.get(id);
  }

  async getUserByUsername(username: string): Promise<User | undefined> {
    return Array.from(this.users.values()).find(
      (user) => user.username === username,
    );
  }

  async createUser(insertUser: InsertUser): Promise<User> {
    const id = randomUUID();
    const user: User = { ...insertUser, id };
    this.users.set(id, user);
    await this.saveData();
    return user;
  }

  async getBrands(): Promise<Brand[]> {
    return Array.from(this.brands.values());
  }

  async insertBrand(insertBrand: InsertBrand): Promise<Brand> {
    const id = randomUUID();
    const brand: Brand = { 
      id,
      name: insertBrand.name,
      logo: insertBrand.logo ?? null,
      color: insertBrand.color ?? "bg-purple-500",
      createdAt: new Date().toISOString()
    };
    this.brands.set(id, brand);
    await this.saveData();
    return brand;
  }

  async deleteBrand(id: string): Promise<void> {
    this.brands.delete(id);
    await this.saveData();
  }
}

export const storage = new MemStorage();
