import { describe, it, expect } from 'vitest';
import { render, screen } from '@testing-library/react';
import {
  Badge,
  EquipmentStatusBadge,
  BookingStatusBadge,
  TransactionStatusBadge,
} from '@/components/ui/Badge';

describe('Badge', () => {
  it('renders text', () => {
    render(<Badge>ACTIVE</Badge>);
    expect(screen.getByText('ACTIVE')).toBeInTheDocument();
  });

  it('applies success variant', () => {
    render(<Badge variant="success">OK</Badge>);
    expect(screen.getByText('OK')).toHaveClass('bg-green-100');
  });

  it('applies danger variant', () => {
    render(<Badge variant="danger">FAIL</Badge>);
    expect(screen.getByText('FAIL')).toHaveClass('bg-red-100');
  });
});

describe('EquipmentStatusBadge', () => {
  it('AVAILABLE is success', () => {
    render(<EquipmentStatusBadge status="AVAILABLE" />);
    expect(screen.getByText('AVAILABLE')).toHaveClass('bg-green-100');
  });

  it('MAINTENANCE is danger', () => {
    render(<EquipmentStatusBadge status="MAINTENANCE" />);
    expect(screen.getByText('MAINTENANCE')).toHaveClass('bg-red-100');
  });
});

describe('BookingStatusBadge', () => {
  it('CONFIRMED is success', () => {
    render(<BookingStatusBadge status="CONFIRMED" />);
    expect(screen.getByText('CONFIRMED')).toHaveClass('bg-green-100');
  });

  it('WAITLISTED is warning', () => {
    render(<BookingStatusBadge status="WAITLISTED" />);
    expect(screen.getByText('WAITLISTED')).toHaveClass('bg-amber-100');
  });
});

describe('TransactionStatusBadge', () => {
  it('OVERDUE is danger', () => {
    render(<TransactionStatusBadge status="OVERDUE" />);
    expect(screen.getByText('OVERDUE')).toHaveClass('bg-red-100');
  });
});
