﻿using System;
using System.Threading.Tasks;

namespace NetCore.Docker
{
    class Program
    {
        static async Task Main(string[] args)
        {
            var counter = 0;
            var max = args.Length != 0 ? Convert.ToInt32(args[0]) : -1;
            while (max == -1 || counter < max)
            {
                Console.Write($"\rCounter: {++counter}");
                await Task.Delay(1000);
            }
            Console.Write("\n");
        }
    }
}
