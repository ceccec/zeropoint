import { Controller } from '@hotwired/stimulus';
import type { ZeropointApiResponse } from '../types/api-client';
export default class ApiClientController extends Controller {
    static targets: string[];
    static values: {
        baseUrl: {
            type: StringConstructor;
            default: string;
        };
        timeout: {
            type: NumberConstructor;
            default: number;
        };
    };
    readonly statusTarget: HTMLElement;
    readonly resultTarget: HTMLElement;
    readonly errorTarget: HTMLElement;
    readonly baseUrlValue: string;
    readonly timeoutValue: number;
    connect(): void;
    callService(event: Event): Promise<void>;
    get(url: string): Promise<ZeropointApiResponse<any>>;
    post(data: any): Promise<ZeropointApiResponse<any>>;
    put(url: string, data: any): Promise<ZeropointApiResponse<any>>;
    delete(url: string): Promise<ZeropointApiResponse<any>>;
    private request;
    private updateStatus;
    private showResult;
    private showError;
}
//# sourceMappingURL=api-client-controller.d.ts.map