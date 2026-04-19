import NodeCache from 'node-cache';

// In-memory cache — replacement for Redis
// stdTTL: default time-to-live in seconds (5 minutes)
// checkperiod: automatic delete check interval (60 seconds)
const cache = new NodeCache({
  stdTTL: 300,
  checkperiod: 60,
  useClones: false,
});

export default cache;
