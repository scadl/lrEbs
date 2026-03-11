import React from 'react';
import {PageProps} from '@inertiajs/core';

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
