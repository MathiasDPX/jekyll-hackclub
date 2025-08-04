"""
Cache manager module providing TTL-based caching functionality.

This module implements a simple in-memory cache with time-to-live (TTL) support.
"""
import time

class Cache:
    """
    A simple TTL-based cache implementation.
    
    This class provides basic caching functionality with automatic expiration
    of entries based on a configurable time-to-live (TTL) value.
    """
    def __init__(self, ttl=3600):
        """
        Initialize a TTL-based cache.

        Args:
            ttl (int): Time-to-live in seconds for each cache entry.
        """
        self.ttl = ttl
        self.store = {}

    def get(self, key):
        """
        Retrieve a value from the cache if it hasn't expired.

        Args:
            key (str): The cache key.

        Returns:
            The cached value or None if not found or expired.
        """
        item = self.store.get(key)
        if item:
            value, timestamp = item
            if time.time() - timestamp < self.ttl:
                return value

            return self.store.pop(key, None)
        return None

    def set(self, key, value):
        """
        Set a value in the cache.

        Args:
            key (str): The cache key.
            value: The value to store.
        """
        self.store[key] = (value, time.time())

    def clear(self):
        """
        Clear the entire cache.
        """
        self.store.clear()
