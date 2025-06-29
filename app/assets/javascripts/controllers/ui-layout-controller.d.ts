import { Controller } from '@hotwired/stimulus';
import type { UiLayout } from '../types/ui-layout';
export default class UiLayoutController extends Controller {
    static targets: string[];
    static values: {
        layout: {
            type: ObjectConstructor;
            default: {};
        };
        consciousness: {
            type: BooleanConstructor;
            default: boolean;
        };
        vortex: {
            type: BooleanConstructor;
            default: boolean;
        };
        goldenRatio: {
            type: BooleanConstructor;
            default: boolean;
        };
    };
    readonly themeTarget: HTMLElement;
    readonly navigationTarget: HTMLElement;
    readonly contentTarget: HTMLElement;
    readonly sidebarTarget: HTMLElement;
    readonly widgetsTarget: HTMLElement;
    readonly layoutValue: UiLayout;
    readonly consciousnessValue: boolean;
    readonly vortexValue: boolean;
    readonly goldenRatioValue: boolean;
    private currentLayout;
    connect(): void;
    private initializeLayout;
    private applyLayout;
    private applyTheme;
    private applyNavigation;
    private applyContent;
    private applySidebar;
    toggleConsciousness(): void;
    toggleVortex(): void;
    toggleGoldenRatio(): void;
    toggleSidebar(): void;
    addWidget(event: Event): void;
    removeWidget(event: Event): void;
    navigate(event: Event): void;
    updateTheme(event: Event): void;
}
//# sourceMappingURL=ui-layout-controller.d.ts.map