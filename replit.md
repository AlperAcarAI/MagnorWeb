# Magnor Web3 Marketing Agency Website

## Overview
A professional Web3 marketing agency website for Magnor that uses Markchain.io's clean, minimalist design structure while showcasing Magnor's own services, partners, and brand identity. The site emphasizes trust, proven results, and comprehensive Web3 marketing solutions.

## Project Architecture

### Frontend
- **Framework**: React with TypeScript
- **Routing**: Wouter (single-page application)
- **Styling**: Tailwind CSS with shadcn/ui components
- **Typography**: 
  - Inter for body text and subsection headings
  - Space Grotesk for hero headlines, section headers, and statistics
- **Color Scheme**: Purple/blue gradients (primary: hsl(262 83% 58%))

### Design Philosophy
**Layout Structure**: Inspired by Markchain.io's clean, minimal design patterns
**Content**: 100% Magnor-specific (partners, services, metrics, company info)

### Key Features Implemented

1. **Minimal Hero Section**
   - Clean, centered layout without background image
   - Company founding info: "Founded in 2020" badge
   - Location: "Based in Dubai"
   - Headline: "Empowering Web3 Projects with Trust & Strategy"
   - Tagline: "— Your Growth Partner in Web3"
   - CTAs: "Get Started" and "Contact Us"

2. **Tabbed Case Studies Section**
   - Three category tabs: Exchanges, DeFi Projects, Gaming & Metaverse
   - Magnor's real partners: Markchain, Disence, Artrade, LimeWire, SpaceCatch, etc.
   - Each client card shows custom metrics and project description
   - "More of our partners" section with additional logos
   - Interactive tab navigation with shadcn Tabs component

3. **Expandable Services Section**
   - Accordion-style expandable cards for 6 core services:
     * KOL Marketing (600+ verified influencers)
     * Token Value Creation (3X volume guarantee)
     * PR & Media Marketing (Tier-1 coverage)
     * Tier-1 Exchange Listing (Binance, OKX access)
     * VC Network (Direct investor access)
     * Market Making (Liquidity solutions)
   - Service description always visible, detail bullets expand on click
   - Chevron icon indicates expand/collapse state

4. **Simple Contact Section**
   - Three contact methods: Email, Website, Telegram
   - Button-based interface with direct links
   - Clean, minimal presentation

5. **Responsive Design**
   - Mobile-first approach with breakpoints for tablet and desktop
   - Responsive grids that adapt across screen sizes
   - Tab navigation wraps on mobile devices

## Recent Changes (Latest Session - November 21, 2025)

### Magnor Brand Color Implementation
- Applied Magnor logo color scheme: #d0cdcd background (light gray/beige)
- Changed all text and logo colors to black for brand consistency
- Switched from dark theme to light theme matching logo aesthetic
- Updated all accent colors to black-based palette

### Dynamic Background Animation
- Added subtle animated gradient background using CSS keyframes
- Three radial gradients in gray tones (opacity 0.3-0.4)
- 15-second smooth animation cycle for gentle movement
- Fixed positioning maintains animation during scroll
- Non-jarring, professional aesthetic that doesn't distract from content

### Markchain.io Layout Structure (Maintained)
- Tabbed case study layout with categories
- Accordion-style expandable services
- Minimal hero section
- Button-based contact interface
- 100% Magnor content (partners, services, company info)

### Technical Details
- All interactive elements have data-testid attributes for testing
- Service expansion behavior: description always visible, details expand/collapse
- Default tab set to "Exchanges" category
- Partner logos use placeholder stock images
- Smooth transitions and hover states throughout
- CSS animation runs on body::before pseudo-element for performance

## User Preferences
- Design structure inspired by Markchain.io's clean, professional aesthetic
- Content must be 100% Magnor-specific (not borrowed from examples)
- Emphasis on proven results, trust, and measurable outcomes
- Minimalist approach with generous whitespace
- Purple/blue Web3 color scheme maintained

## Development Guidelines
- Follow design_guidelines.md for all UI implementations
- Use shadcn components exclusively (Tabs, Card, Button, Badge)
- Never add manual hover colors to Button components
- Maintain typography hierarchy (Space Grotesk for headers, Inter for body)
- All interactive elements must have data-testid attributes
- Elevation utilities (hover-elevate, active-elevate-2) only on Cards
- Service accordion: description always visible, details expand/collapse on click
