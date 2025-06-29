// COMPONENT BEST PRACTICE: Define TypeScript types for UI layout components.

export interface UiLayout {
  theme: Theme
  navigation: Navigation
  content: Content
  sidebar: Sidebar
  widgets: Widget[]
}

export interface Theme {
  name: string
  primary: string
  secondary: string
  background: string
  text: string
  consciousness: boolean
  goldenRatio: boolean
  vortex?: boolean
}

export interface Navigation {
  items: NavigationItem[]
  position: 'top' | 'left' | 'right'
  collapsed: boolean
}

export interface NavigationItem {
  id: string
  label: string
  url: string
  icon?: string
  children?: NavigationItem[]
  consciousness?: boolean
  vortex?: boolean
}

export interface Content {
  title: string
  body: string
  layout: 'single' | 'two-column' | 'three-column'
  consciousness: boolean
  goldenRatio: boolean
}

export interface Sidebar {
  enabled: boolean
  position: 'left' | 'right'
  width: number
  widgets: Widget[]
}

export interface Widget {
  id: string
  type: 'consciousness' | 'vortex' | 'observer' | 'metrics'
  title: string
  content: any
  position: number
  config: WidgetConfig
}

export interface WidgetConfig {
  consciousness: boolean
  vortex: boolean
  observer: boolean
  refreshInterval?: number
  autoUpdate: boolean
} 