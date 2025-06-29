import type { UiLayout, Theme, Navigation, Content, Sidebar, Widget } from '../types/ui-layout';
export declare function useUiLayout(): {
    layout: UiLayout;
    updateTheme: (theme: Partial<Theme>) => void;
    updateNavigation: (navigation: Partial<Navigation>) => void;
    updateContent: (content: Partial<Content>) => void;
    updateSidebar: (sidebar: Partial<Sidebar>) => void;
    addWidget: (widget: Widget) => void;
    removeWidget: (widgetId: string) => void;
    toggleConsciousness: () => void;
    toggleVortex: () => void;
};
//# sourceMappingURL=use-ui-layout.d.ts.map