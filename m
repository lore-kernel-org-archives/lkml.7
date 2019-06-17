Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3BCDC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 16:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65C9C2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 16:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbfFQQUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 12:20:16 -0400
Received: from mga02.intel.com ([134.134.136.20]:46891 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725863AbfFQQUP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 12:20:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jun 2019 09:10:32 -0700
X-ExtLoop1: 1
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 17 Jun 2019 09:10:31 -0700
Received: from [10.251.13.32] (kliang2-mobl.ccr.corp.intel.com [10.251.13.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 39A045801A8;
        Mon, 17 Jun 2019 09:10:30 -0700 (PDT)
Subject: Re: [PATCH trivial] perf vendor events intel: Assorted style fixes
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Andi Kleen <andi@firstfloor.org>, Kan Liang <kan.liang@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Kosina <trivial@kernel.org>, linux-kernel@vger.kernel.org
References: <20190617142156.2526-1-geert+renesas@glider.be>
 <20190617155633.GA3927@kernel.org>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <c0fcd807-abf1-c7b1-4601-e0e46b0199b4@linux.intel.com>
Date:   Mon, 17 Jun 2019 12:10:28 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190617155633.GA3927@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/17/2019 11:56 AM, Arnaldo Carvalho de Melo wrote:
> Em Mon, Jun 17, 2019 at 04:21:56PM +0200, Geert Uytterhoeven escreveu:
>>    - Do not use apostrophes for plurals,
>>    - Insert commas before "and",
>>    - Spelling s/statisfied/satisfied/.
> 
> I think these files are generated from some other material from Intel,
> i.e. if they update something somewhere else and regenerate those files,
> your changes would be lost, right Andi, Kan? (Adding them to the CC list).
>

Yes, they are generated from JSON files in
https://download.01.org/perfmon/

I will forward the patch to our internal team to check the issues in 
JSON file.

Thanks,
Kan


> - Arnaldo
>   
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> ---
>>   tools/perf/pmu-events/arch/x86/nehalemep/cache.json  | 12 ++++++------
>>   tools/perf/pmu-events/arch/x86/nehalemep/memory.json |  4 ++--
>>   tools/perf/pmu-events/arch/x86/nehalemex/cache.json  | 12 ++++++------
>>   tools/perf/pmu-events/arch/x86/nehalemex/memory.json |  4 ++--
>>   .../pmu-events/arch/x86/westmereep-sp/cache.json     | 12 ++++++------
>>   .../pmu-events/arch/x86/westmereep-sp/memory.json    |  4 ++--
>>   tools/perf/pmu-events/arch/x86/westmereex/cache.json | 12 ++++++------
>>   .../perf/pmu-events/arch/x86/westmereex/memory.json  |  4 ++--
>>   8 files changed, 32 insertions(+), 32 deletions(-)
>>
>> diff --git a/tools/perf/pmu-events/arch/x86/nehalemep/cache.json b/tools/perf/pmu-events/arch/x86/nehalemep/cache.json
>> index a11029efda2f01e6..1c4fd6af138229e3 100644
>> --- a/tools/perf/pmu-events/arch/x86/nehalemep/cache.json
>> +++ b/tools/perf/pmu-events/arch/x86/nehalemep/cache.json
>> @@ -1804,7 +1804,7 @@
>>           "EventName": "OFFCORE_RESPONSE.DATA_IN.IO_CSR_MMIO",
>>           "MSRIndex": "0x1A6",
>>           "SampleAfterValue": "100000",
>> -        "BriefDescription": "Offcore data reads, RFO's and prefetches satisfied by the IO, CSR, MMIO unit",
>> +        "BriefDescription": "Offcore data reads, RFOs, and prefetches satisfied by the IO, CSR, MMIO unit",
>>           "Offcore": "1"
>>       },
>>       {
>> @@ -1815,7 +1815,7 @@
>>           "EventName": "OFFCORE_RESPONSE.DATA_IN.LLC_HIT_NO_OTHER_CORE",
>>           "MSRIndex": "0x1A6",
>>           "SampleAfterValue": "100000",
>> -        "BriefDescription": "Offcore data reads, RFO's and prefetches statisfied by the LLC and not found in a sibling core",
>> +        "BriefDescription": "Offcore data reads, RFOs, and prefetches satisfied by the LLC and not found in a sibling core",
>>           "Offcore": "1"
>>       },
>>       {
>> @@ -1826,7 +1826,7 @@
>>           "EventName": "OFFCORE_RESPONSE.DATA_IN.LLC_HIT_OTHER_CORE_HIT",
>>           "MSRIndex": "0x1A6",
>>           "SampleAfterValue": "100000",
>> -        "BriefDescription": "Offcore data reads, RFO's and prefetches satisfied by the LLC and HIT in a sibling core",
>> +        "BriefDescription": "Offcore data reads, RFOs, and prefetches satisfied by the LLC and HIT in a sibling core",
>>           "Offcore": "1"
>>       },
>>       {
>> @@ -1837,7 +1837,7 @@
>>           "EventName": "OFFCORE_RESPONSE.DATA_IN.LLC_HIT_OTHER_CORE_HITM",
>>           "MSRIndex": "0x1A6",
>>           "SampleAfterValue": "100000",
>> -        "BriefDescription": "Offcore data reads, RFO's and prefetches satisfied by the LLC  and HITM in a sibling core",
>> +        "BriefDescription": "Offcore data reads, RFOs, and prefetches satisfied by the LLC  and HITM in a sibling core",
>>           "Offcore": "1"
>>       },
>>       {
>> @@ -1892,7 +1892,7 @@
>>           "EventName": "OFFCORE_RESPONSE.DATA_IN.REMOTE_CACHE_HIT",
>>           "MSRIndex": "0x1A6",
>>           "SampleAfterValue": "100000",
>> -        "BriefDescription": "Offcore data reads, RFO's and prefetches that HIT in a remote cache ",
>> +        "BriefDescription": "Offcore data reads, RFOs, and prefetches that HIT in a remote cache ",
>>           "Offcore": "1"
>>       },
>>       {
>> @@ -1903,7 +1903,7 @@
>>           "EventName": "OFFCORE_RESPONSE.DATA_IN.REMOTE_CACHE_HITM",
>>           "MSRIndex": "0x1A6",
>>           "SampleAfterValue": "100000",
>> -        "BriefDescription": "Offcore data reads, RFO's and prefetches that HITM in a remote cache",
>> +        "BriefDescription": "Offcore data reads, RFOs, and prefetches that HITM in a remote cache",
>>           "Offcore": "1"
>>       },
>>       {
>> diff --git a/tools/perf/pmu-events/arch/x86/nehalemep/memory.json b/tools/perf/pmu-events/arch/x86/nehalemep/memory.json
>> index f914a4525b651d0f..029a7fc8561c0629 100644
>> --- a/tools/perf/pmu-events/arch/x86/nehalemep/memory.json
>> +++ b/tools/perf/pmu-events/arch/x86/nehalemep/memory.json
>> @@ -293,7 +293,7 @@
>>           "EventName": "OFFCORE_RESPONSE.DATA_IN.LOCAL_DRAM",
>>           "MSRIndex": "0x1A6",
>>           "SampleAfterValue": "100000",
>> -        "BriefDescription": "Offcore data reads, RFO's and prefetches statisfied by the local DRAM.",
>> +        "BriefDescription": "Offcore data reads, RFOs, and prefetches satisfied by the local DRAM.",
>>           "Offcore": "1"
>>       },
>>       {
>> @@ -304,7 +304,7 @@
>>           "EventName": "OFFCORE_RESPONSE.DATA_IN.REMOTE_DRAM",
>>           "MSRIndex": "0x1A6",
>>           "SampleAfterValue": "100000",
>> -        "BriefDescription": "Offcore data reads, RFO's and prefetches statisfied by the remote DRAM",
>> +        "BriefDescription": "Offcore data reads, RFOs, and prefetches satisfied by the remote DRAM",
>>           "Offcore": "1"
>>       },
>>       {
>> diff --git a/tools/perf/pmu-events/arch/x86/nehalemex/cache.json b/tools/perf/pmu-events/arch/x86/nehalemex/cache.json
>> index 21a0f8fd057e8388..980352618ad7e987 100644
>> --- a/tools/perf/pmu-events/arch/x86/nehalemex/cache.json
>> +++ b/tools/perf/pmu-events/arch/x86/nehalemex/cache.json
>> @@ -1759,7 +1759,7 @@
>>           "EventName": "OFFCORE_RESPONSE.DATA_IN.IO_CSR_MMIO",
>>           "MSRIndex": "0x1A6",
>>           "SampleAfterValue": "100000",
>> -        "BriefDescription": "Offcore data reads, RFO's and prefetches satisfied by the IO, CSR, MMIO unit",
>> +        "BriefDescription": "Offcore data reads, RFOs, and prefetches satisfied by the IO, CSR, MMIO unit",
>>           "Offcore": "1"
>>       },
>>       {
>> @@ -1770,7 +1770,7 @@
>>           "EventName": "OFFCORE_RESPONSE.DATA_IN.LLC_HIT_NO_OTHER_CORE",
>>           "MSRIndex": "0x1A6",
>>           "SampleAfterValue": "100000",
>> -        "BriefDescription": "Offcore data reads, RFO's and prefetches statisfied by the LLC and not found in a sibling core",
>> +        "BriefDescription": "Offcore data reads, RFOs, and prefetches satisfied by the LLC and not found in a sibling core",
>>           "Offcore": "1"
>>       },
>>       {
>> @@ -1781,7 +1781,7 @@
>>           "EventName": "OFFCORE_RESPONSE.DATA_IN.LLC_HIT_OTHER_CORE_HIT",
>>           "MSRIndex": "0x1A6",
>>           "SampleAfterValue": "100000",
>> -        "BriefDescription": "Offcore data reads, RFO's and prefetches satisfied by the LLC and HIT in a sibling core",
>> +        "BriefDescription": "Offcore data reads, RFOs, and prefetches satisfied by the LLC and HIT in a sibling core",
>>           "Offcore": "1"
>>       },
>>       {
>> @@ -1792,7 +1792,7 @@
>>           "EventName": "OFFCORE_RESPONSE.DATA_IN.LLC_HIT_OTHER_CORE_HITM",
>>           "MSRIndex": "0x1A6",
>>           "SampleAfterValue": "100000",
>> -        "BriefDescription": "Offcore data reads, RFO's and prefetches satisfied by the LLC  and HITM in a sibling core",
>> +        "BriefDescription": "Offcore data reads, RFOs, and prefetches satisfied by the LLC  and HITM in a sibling core",
>>           "Offcore": "1"
>>       },
>>       {
>> @@ -1847,7 +1847,7 @@
>>           "EventName": "OFFCORE_RESPONSE.DATA_IN.REMOTE_CACHE_HIT",
>>           "MSRIndex": "0x1A6",
>>           "SampleAfterValue": "100000",
>> -        "BriefDescription": "Offcore data reads, RFO's and prefetches that HIT in a remote cache ",
>> +        "BriefDescription": "Offcore data reads, RFOs, and prefetches that HIT in a remote cache ",
>>           "Offcore": "1"
>>       },
>>       {
>> @@ -1858,7 +1858,7 @@
>>           "EventName": "OFFCORE_RESPONSE.DATA_IN.REMOTE_CACHE_HITM",
>>           "MSRIndex": "0x1A6",
>>           "SampleAfterValue": "100000",
>> -        "BriefDescription": "Offcore data reads, RFO's and prefetches that HITM in a remote cache",
>> +        "BriefDescription": "Offcore data reads, RFOs, and prefetches that HITM in a remote cache",
>>           "Offcore": "1"
>>       },
>>       {
>> diff --git a/tools/perf/pmu-events/arch/x86/nehalemex/memory.json b/tools/perf/pmu-events/arch/x86/nehalemex/memory.json
>> index f914a4525b651d0f..029a7fc8561c0629 100644
>> --- a/tools/perf/pmu-events/arch/x86/nehalemex/memory.json
>> +++ b/tools/perf/pmu-events/arch/x86/nehalemex/memory.json
>> @@ -293,7 +293,7 @@
>>           "EventName": "OFFCORE_RESPONSE.DATA_IN.LOCAL_DRAM",
>>           "MSRIndex": "0x1A6",
>>           "SampleAfterValue": "100000",
>> -        "BriefDescription": "Offcore data reads, RFO's and prefetches statisfied by the local DRAM.",
>> +        "BriefDescription": "Offcore data reads, RFOs, and prefetches satisfied by the local DRAM.",
>>           "Offcore": "1"
>>       },
>>       {
>> @@ -304,7 +304,7 @@
>>           "EventName": "OFFCORE_RESPONSE.DATA_IN.REMOTE_DRAM",
>>           "MSRIndex": "0x1A6",
>>           "SampleAfterValue": "100000",
>> -        "BriefDescription": "Offcore data reads, RFO's and prefetches statisfied by the remote DRAM",
>> +        "BriefDescription": "Offcore data reads, RFOs, and prefetches satisfied by the remote DRAM",
>>           "Offcore": "1"
>>       },
>>       {
>> diff --git a/tools/perf/pmu-events/arch/x86/westmereep-sp/cache.json b/tools/perf/pmu-events/arch/x86/westmereep-sp/cache.json
>> index dad20f0e3cac235f..62cddfff9781766d 100644
>> --- a/tools/perf/pmu-events/arch/x86/westmereep-sp/cache.json
>> +++ b/tools/perf/pmu-events/arch/x86/westmereep-sp/cache.json
>> @@ -1808,7 +1808,7 @@
>>           "EventName": "OFFCORE_RESPONSE.DATA_IN.IO_CSR_MMIO",
>>           "MSRIndex": "0x1a6,0x1a7",
>>           "SampleAfterValue": "100000",
>> -        "BriefDescription": "Offcore data reads, RFO's and prefetches satisfied by the IO, CSR, MMIO unit",
>> +        "BriefDescription": "Offcore data reads, RFOs, and prefetches satisfied by the IO, CSR, MMIO unit",
>>           "Offcore": "1"
>>       },
>>       {
>> @@ -1819,7 +1819,7 @@
>>           "EventName": "OFFCORE_RESPONSE.DATA_IN.LLC_HIT_NO_OTHER_CORE",
>>           "MSRIndex": "0x1a6,0x1a7",
>>           "SampleAfterValue": "100000",
>> -        "BriefDescription": "Offcore data reads, RFO's and prefetches statisfied by the LLC and not found in a sibling core",
>> +        "BriefDescription": "Offcore data reads, RFOs, and prefetches satisfied by the LLC and not found in a sibling core",
>>           "Offcore": "1"
>>       },
>>       {
>> @@ -1830,7 +1830,7 @@
>>           "EventName": "OFFCORE_RESPONSE.DATA_IN.LLC_HIT_OTHER_CORE_HIT",
>>           "MSRIndex": "0x1a6,0x1a7",
>>           "SampleAfterValue": "100000",
>> -        "BriefDescription": "Offcore data reads, RFO's and prefetches satisfied by the LLC and HIT in a sibling core",
>> +        "BriefDescription": "Offcore data reads, RFOs, and prefetches satisfied by the LLC and HIT in a sibling core",
>>           "Offcore": "1"
>>       },
>>       {
>> @@ -1841,7 +1841,7 @@
>>           "EventName": "OFFCORE_RESPONSE.DATA_IN.LLC_HIT_OTHER_CORE_HITM",
>>           "MSRIndex": "0x1a6,0x1a7",
>>           "SampleAfterValue": "100000",
>> -        "BriefDescription": "Offcore data reads, RFO's and prefetches satisfied by the LLC  and HITM in a sibling core",
>> +        "BriefDescription": "Offcore data reads, RFOs, and prefetches satisfied by the LLC  and HITM in a sibling core",
>>           "Offcore": "1"
>>       },
>>       {
>> @@ -1896,7 +1896,7 @@
>>           "EventName": "OFFCORE_RESPONSE.DATA_IN.REMOTE_CACHE_HIT",
>>           "MSRIndex": "0x1a6,0x1a7",
>>           "SampleAfterValue": "100000",
>> -        "BriefDescription": "Offcore data reads, RFO's and prefetches that HIT in a remote cache ",
>> +        "BriefDescription": "Offcore data reads, RFOs, and prefetches that HIT in a remote cache ",
>>           "Offcore": "1"
>>       },
>>       {
>> @@ -1907,7 +1907,7 @@
>>           "EventName": "OFFCORE_RESPONSE.DATA_IN.REMOTE_CACHE_HITM",
>>           "MSRIndex": "0x1a6,0x1a7",
>>           "SampleAfterValue": "100000",
>> -        "BriefDescription": "Offcore data reads, RFO's and prefetches that HITM in a remote cache",
>> +        "BriefDescription": "Offcore data reads, RFOs, and prefetches that HITM in a remote cache",
>>           "Offcore": "1"
>>       },
>>       {
>> diff --git a/tools/perf/pmu-events/arch/x86/westmereep-sp/memory.json b/tools/perf/pmu-events/arch/x86/westmereep-sp/memory.json
>> index 90eb6aac357b5ffa..8355b5d3945ba8fa 100644
>> --- a/tools/perf/pmu-events/arch/x86/westmereep-sp/memory.json
>> +++ b/tools/perf/pmu-events/arch/x86/westmereep-sp/memory.json
>> @@ -293,7 +293,7 @@
>>           "EventName": "OFFCORE_RESPONSE.DATA_IN.LOCAL_DRAM",
>>           "MSRIndex": "0x1a6,0x1a7",
>>           "SampleAfterValue": "100000",
>> -        "BriefDescription": "Offcore data reads, RFO's and prefetches statisfied by the local DRAM.",
>> +        "BriefDescription": "Offcore data reads, RFOs, and prefetches satisfied by the local DRAM.",
>>           "Offcore": "1"
>>       },
>>       {
>> @@ -304,7 +304,7 @@
>>           "EventName": "OFFCORE_RESPONSE.DATA_IN.REMOTE_DRAM",
>>           "MSRIndex": "0x1a6,0x1a7",
>>           "SampleAfterValue": "100000",
>> -        "BriefDescription": "Offcore data reads, RFO's and prefetches statisfied by the remote DRAM",
>> +        "BriefDescription": "Offcore data reads, RFOs, and prefetches satisfied by the remote DRAM",
>>           "Offcore": "1"
>>       },
>>       {
>> diff --git a/tools/perf/pmu-events/arch/x86/westmereex/cache.json b/tools/perf/pmu-events/arch/x86/westmereex/cache.json
>> index f9bc7fdd48d6e648..30266602fc82e85d 100644
>> --- a/tools/perf/pmu-events/arch/x86/westmereex/cache.json
>> +++ b/tools/perf/pmu-events/arch/x86/westmereex/cache.json
>> @@ -1800,7 +1800,7 @@
>>           "EventName": "OFFCORE_RESPONSE.DATA_IN.IO_CSR_MMIO",
>>           "MSRIndex": "0x1A6",
>>           "SampleAfterValue": "100000",
>> -        "BriefDescription": "Offcore data reads, RFO's and prefetches satisfied by the IO, CSR, MMIO unit",
>> +        "BriefDescription": "Offcore data reads, RFOs, and prefetches satisfied by the IO, CSR, MMIO unit",
>>           "Offcore": "1"
>>       },
>>       {
>> @@ -1811,7 +1811,7 @@
>>           "EventName": "OFFCORE_RESPONSE.DATA_IN.LLC_HIT_NO_OTHER_CORE",
>>           "MSRIndex": "0x1A6",
>>           "SampleAfterValue": "100000",
>> -        "BriefDescription": "Offcore data reads, RFO's and prefetches statisfied by the LLC and not found in a sibling core",
>> +        "BriefDescription": "Offcore data reads, RFOs, and prefetches satisfied by the LLC and not found in a sibling core",
>>           "Offcore": "1"
>>       },
>>       {
>> @@ -1822,7 +1822,7 @@
>>           "EventName": "OFFCORE_RESPONSE.DATA_IN.LLC_HIT_OTHER_CORE_HIT",
>>           "MSRIndex": "0x1A6",
>>           "SampleAfterValue": "100000",
>> -        "BriefDescription": "Offcore data reads, RFO's and prefetches satisfied by the LLC and HIT in a sibling core",
>> +        "BriefDescription": "Offcore data reads, RFOs, and prefetches satisfied by the LLC and HIT in a sibling core",
>>           "Offcore": "1"
>>       },
>>       {
>> @@ -1833,7 +1833,7 @@
>>           "EventName": "OFFCORE_RESPONSE.DATA_IN.LLC_HIT_OTHER_CORE_HITM",
>>           "MSRIndex": "0x1A6",
>>           "SampleAfterValue": "100000",
>> -        "BriefDescription": "Offcore data reads, RFO's and prefetches satisfied by the LLC  and HITM in a sibling core",
>> +        "BriefDescription": "Offcore data reads, RFOs, and prefetches satisfied by the LLC  and HITM in a sibling core",
>>           "Offcore": "1"
>>       },
>>       {
>> @@ -1888,7 +1888,7 @@
>>           "EventName": "OFFCORE_RESPONSE.DATA_IN.REMOTE_CACHE_HIT",
>>           "MSRIndex": "0x1A6",
>>           "SampleAfterValue": "100000",
>> -        "BriefDescription": "Offcore data reads, RFO's and prefetches that HIT in a remote cache ",
>> +        "BriefDescription": "Offcore data reads, RFOs, and prefetches that HIT in a remote cache ",
>>           "Offcore": "1"
>>       },
>>       {
>> @@ -1899,7 +1899,7 @@
>>           "EventName": "OFFCORE_RESPONSE.DATA_IN.REMOTE_CACHE_HITM",
>>           "MSRIndex": "0x1A6",
>>           "SampleAfterValue": "100000",
>> -        "BriefDescription": "Offcore data reads, RFO's and prefetches that HITM in a remote cache",
>> +        "BriefDescription": "Offcore data reads, RFOs, and prefetches that HITM in a remote cache",
>>           "Offcore": "1"
>>       },
>>       {
>> diff --git a/tools/perf/pmu-events/arch/x86/westmereex/memory.json b/tools/perf/pmu-events/arch/x86/westmereex/memory.json
>> index 3ba555e73cbd60d5..794e6773bf74cc0c 100644
>> --- a/tools/perf/pmu-events/arch/x86/westmereex/memory.json
>> +++ b/tools/perf/pmu-events/arch/x86/westmereex/memory.json
>> @@ -301,7 +301,7 @@
>>           "EventName": "OFFCORE_RESPONSE.DATA_IN.LOCAL_DRAM",
>>           "MSRIndex": "0x1A6",
>>           "SampleAfterValue": "100000",
>> -        "BriefDescription": "Offcore data reads, RFO's and prefetches statisfied by the local DRAM.",
>> +        "BriefDescription": "Offcore data reads, RFOs, and prefetches satisfied by the local DRAM.",
>>           "Offcore": "1"
>>       },
>>       {
>> @@ -312,7 +312,7 @@
>>           "EventName": "OFFCORE_RESPONSE.DATA_IN.REMOTE_DRAM",
>>           "MSRIndex": "0x1A6",
>>           "SampleAfterValue": "100000",
>> -        "BriefDescription": "Offcore data reads, RFO's and prefetches statisfied by the remote DRAM",
>> +        "BriefDescription": "Offcore data reads, RFOs, and prefetches satisfied by the remote DRAM",
>>           "Offcore": "1"
>>       },
>>       {
>> -- 
>> 2.17.1
> 
