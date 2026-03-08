import React from 'react';
import { PageProps } from '@inertiajs/react';

interface HelloProps extends PageProps {
  name: string;
}

export default function Hello({ name }: HelloProps) {
  return (
    <div className="p-6 text-xl font-semibold">
      Привет {name}
    </div>
  );
}
