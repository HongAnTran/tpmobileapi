export function formatCurrency(value: number, currency: string = "đ"): string {

    // Format the number to two decimal places Việt nam

    const formattedValue = value.toLocaleString('vi-VN', {
        minimumFractionDigits: 2,
        maximumFractionDigits: 2,
    });

    return `${formattedValue}${currency}`;
    
}