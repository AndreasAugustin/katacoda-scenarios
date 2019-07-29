import { describe, it } from 'mocha';
import { expect } from 'chai';

import { add } from '../src';

describe('simple test example', () => {
  it('adds two numbers', () => {
    const a = 1;
    const b = 2;
    const expected = 3;
    const res = add(a, b);
    expect(res).to.be.eqls(expected);
  });
});
