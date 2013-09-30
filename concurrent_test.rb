#!/usr/bin/env ruby -wKU


import java.util.concurrent.Executors
import java.util.concurrent.atomic.AtomicInteger
import java.util.concurrent.CountDownLatch


counter = AtomicInteger.new(10000)
executor = Executors.new_fixed_thread_pool(10)
latch = CountDownLatch.new(10)

10.times do |time|
    executor.execute do
        puts "Executor runing for: #{time}"
        1000.times do |time|
            puts "Inside thread runing for #{time}"
            counter.add_and_get(-1)
        end
        latch.count_down
    end
end

latch.await
puts counter

executor.shutdown