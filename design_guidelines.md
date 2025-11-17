# Design Guidelines: Magnor Web3 Marketing Agency Website

## Design Approach
**Hybrid Approach**: Combine Material Design's visual feedback principles with Web3 industry aesthetics (gradient-heavy, tech-forward). Draw inspiration from Stripe's clarity and Coinbase's modern crypto aesthetic while maintaining unique brand personality.

## Typography System
- **Primary Font**: Inter (Google Fonts) - clean, modern, excellent readability
- **Accent Font**: Space Grotesk (Google Fonts) - tech-forward headlines
- **Hierarchy**:
  - Hero: text-6xl to text-7xl, font-bold (Space Grotesk)
  - Section Headers: text-4xl to text-5xl, font-bold (Space Grotesk)
  - Subsections: text-2xl to text-3xl, font-semibold (Inter)
  - Body: text-lg, font-normal (Inter)
  - Stats/Numbers: text-5xl to text-6xl, font-bold (Space Grotesk)

## Layout System
**Spacing Units**: Primarily use Tailwind units 4, 6, 8, 12, 16, 20, 24 for consistent rhythm
- Section padding: py-20 (desktop), py-12 (mobile)
- Component spacing: gap-8 to gap-12
- Container: max-w-7xl with px-6
- Grid gaps: gap-8 for cards, gap-12 for major sections

## Page Structure

### Hero Section (100vh)
Full-viewport immersive introduction with gradient background overlay on a tech/Web3-themed image showing digital networks or blockchain visualization. Center-aligned content with primary headline "Empowering Web3 Projects" and subheadline "Trust & Strategy". Large CTA button "Get Started" with secondary "View Services" link. Include subtle animated gradient effects.

### Key Strengths Section
Three-column grid (single column mobile) featuring:
1. Trust & Transparency Focus
2. Deep KOL/Investor Network  
3. Growth Partner Approach

Each with icon, headline, description. Below: centered stats bar displaying "600+ KOLs", "100+ Projects", "5-20X ROI Average" with large numbers and labels.

### Trusted Partners Section
Background with subtle gradient. Grid layout displaying partner logos: 4 columns desktop, 2 columns tablet, 1 column mobile. Logos in grayscale with hover color effect. Include 12 partner logos (Markchain, Disence, Artrade, Cmedia, Concordium, Fatty, LimeWire, Lingo, My Lovely Planet, Opulous, SpaceCatch, plus 1 generic placeholder).

### Services Section
Two-row, three-column grid (stacks on mobile):
- KOL Marketing
- Token Value Creation
- PR & Media Marketing
- Tier-1 Exchange Listing
- VC Network
- Market Making

Each service card includes icon (from Heroicons), headline, and concise value proposition.

### Token Value Creation Deep Dive
Dedicated section with two-column layout (stacks mobile):
- Left: Visual comparison showing $50K Campaign Budget → 3X → $150K Total Market Activity
- Right: Four benefit cards (Guaranteed Buy Volume, Risk Management, Managed Exit Strategy, Investment Allocation)

Include "Sustainable Growth" closing statement.

### How We Work Timeline
Horizontal process visualization showing 5 numbered steps with connecting line:
1. Process Project
2. Strategic Plan
3. KOL Network
4. Execute
5. Results

Each step includes icon, title, and brief description. Below: repeat key stats in smaller format.

### Contact Section
Centered layout with gradient background. Three contact methods side-by-side (stacks on mobile):
- Email: info@magnor.agency
- Website: www.magnor.agency
- Telegram: @emirweb3

Each with icon and clickable link. Include CTA headline "Let's Elevate Your Web3 Project".

## Component Library

### Cards
Rounded corners (rounded-xl), subtle shadow (shadow-lg), padding p-8, white background with slight transparency for glass-morphism effect where appropriate.

### Buttons
Primary: Large, rounded-full, px-8 py-4, gradient background
Secondary: Outlined, rounded-full, px-6 py-3
Ghost: Text-only with icon

### Icons
Use Heroicons (solid and outline variants) for all interface elements. Size: w-6 h-6 for inline, w-12 h-12 for features.

### Stats Display
Large numbers with smaller labels beneath, contained in subtle bordered boxes or cards.

## Visual Treatment

### Gradients
Liberal use of purple-to-blue gradients (Web3 aesthetic) for backgrounds, buttons, and accents. Subtle radial gradients for section backgrounds.

### Spacing & Rhythm
Generous whitespace between sections. Consistent vertical rhythm with py-20 desktop, py-12 mobile. Component internal spacing: p-6 to p-8.

## Images

### Hero Image
Full-width background: Abstract Web3/blockchain visualization—interconnected nodes, digital networks, or crypto-themed abstract geometry. Dark with purple/blue tones. Overlay with gradient for text readability.

### Partner Logos
12 partner company logos (grayscale by default, full color on hover). Size: h-12 to h-16, maintain aspect ratio.

### Service Icons
Use Heroicons for: 
- Megaphone (KOL)
- Chart bar (Token Value)
- Newspaper (PR)
- Building library (Exchange)
- Users (VC Network)
- Arrows trending up (Market Making)

## Accessibility
Maintain WCAG AA contrast ratios. All interactive elements have focus states with ring-2 ring-offset-2. Semantic HTML throughout.