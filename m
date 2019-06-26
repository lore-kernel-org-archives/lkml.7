Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C91C48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 278062063F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbfFZOy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 10:54:57 -0400
Received: from mga02.intel.com ([134.134.136.20]:36496 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726948AbfFZOy4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 10:54:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2019 07:54:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,420,1557212400"; 
   d="scan'208";a="313450847"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 26 Jun 2019 07:54:55 -0700
Received: from [10.254.65.243] (kliang2-mobl.ccr.corp.intel.com [10.254.65.243])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 39306580238;
        Wed, 26 Jun 2019 07:54:55 -0700 (PDT)
Subject: Re: [PATCH] perf vendor events intel: Fix typos in
 floating-point.json
To:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Masanari Iida <standby24x7@gmail.com>
Cc:     ak@linux.intel.com, kan.liang@intel.com,
        linux-kernel@vger.kernel.org, acme@kernel.org,
        Jin Yao <yao.jin@linux.intel.com>
References: <20190626110436.22563-1-standby24x7@gmail.com>
 <20190626134746.GA2227@redhat.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <fb1f9673-6b6a-e5c8-2ff4-945a59f1d919@linux.intel.com>
Date:   Wed, 26 Jun 2019 10:54:53 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190626134746.GA2227@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/26/2019 9:47 AM, Arnaldo Carvalho de Melo wrote:
> Em Wed, Jun 26, 2019 at 08:04:36PM +0900, Masanari Iida escreveu:
>> This patch fix some spelling typo in x86/*/floating-point.json
> 
> These are auto-generated files, glad that you CCed your fixes to the
> Intel folks, hopefully they will in turn send it internally so that next

Yes, I have already fw the fixes to the internal team.
Once they update the database and release a new version, we will 
generate a new patch.

Thanks,
Kan

> time we get an update with the fixes, ok?
> 
> Thanks,
> 
> - Arnaldo
>   
>> Signed-off-by: Masanari Iida <standby24x7@gmail.com>
>> ---
>>   tools/perf/pmu-events/arch/x86/nehalemep/floating-point.json    | 2 +-
>>   tools/perf/pmu-events/arch/x86/nehalemex/floating-point.json    | 2 +-
>>   .../perf/pmu-events/arch/x86/westmereep-dp/floating-point.json  | 2 +-
>>   .../perf/pmu-events/arch/x86/westmereep-sp/floating-point.json  | 2 +-
>>   tools/perf/pmu-events/arch/x86/westmereex/floating-point.json   | 2 +-
>>   5 files changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/tools/perf/pmu-events/arch/x86/nehalemep/floating-point.json b/tools/perf/pmu-events/arch/x86/nehalemep/floating-point.json
>> index 7d2f71a9dee3..6b9b9fe74f3b 100644
>> --- a/tools/perf/pmu-events/arch/x86/nehalemep/floating-point.json
>> +++ b/tools/perf/pmu-events/arch/x86/nehalemep/floating-point.json
>> @@ -15,7 +15,7 @@
>>           "UMask": "0x4",
>>           "EventName": "FP_ASSIST.INPUT",
>>           "SampleAfterValue": "20000",
>> -        "BriefDescription": "X87 Floating poiint assists for invalid input value (Precise Event)"
>> +        "BriefDescription": "X87 Floating point assists for invalid input value (Precise Event)"
>>       },
>>       {
>>           "PEBS": "1",
>> diff --git a/tools/perf/pmu-events/arch/x86/nehalemex/floating-point.json b/tools/perf/pmu-events/arch/x86/nehalemex/floating-point.json
>> index 7d2f71a9dee3..6b9b9fe74f3b 100644
>> --- a/tools/perf/pmu-events/arch/x86/nehalemex/floating-point.json
>> +++ b/tools/perf/pmu-events/arch/x86/nehalemex/floating-point.json
>> @@ -15,7 +15,7 @@
>>           "UMask": "0x4",
>>           "EventName": "FP_ASSIST.INPUT",
>>           "SampleAfterValue": "20000",
>> -        "BriefDescription": "X87 Floating poiint assists for invalid input value (Precise Event)"
>> +        "BriefDescription": "X87 Floating point assists for invalid input value (Precise Event)"
>>       },
>>       {
>>           "PEBS": "1",
>> diff --git a/tools/perf/pmu-events/arch/x86/westmereep-dp/floating-point.json b/tools/perf/pmu-events/arch/x86/westmereep-dp/floating-point.json
>> index 7d2f71a9dee3..6b9b9fe74f3b 100644
>> --- a/tools/perf/pmu-events/arch/x86/westmereep-dp/floating-point.json
>> +++ b/tools/perf/pmu-events/arch/x86/westmereep-dp/floating-point.json
>> @@ -15,7 +15,7 @@
>>           "UMask": "0x4",
>>           "EventName": "FP_ASSIST.INPUT",
>>           "SampleAfterValue": "20000",
>> -        "BriefDescription": "X87 Floating poiint assists for invalid input value (Precise Event)"
>> +        "BriefDescription": "X87 Floating point assists for invalid input value (Precise Event)"
>>       },
>>       {
>>           "PEBS": "1",
>> diff --git a/tools/perf/pmu-events/arch/x86/westmereep-sp/floating-point.json b/tools/perf/pmu-events/arch/x86/westmereep-sp/floating-point.json
>> index 7d2f71a9dee3..6b9b9fe74f3b 100644
>> --- a/tools/perf/pmu-events/arch/x86/westmereep-sp/floating-point.json
>> +++ b/tools/perf/pmu-events/arch/x86/westmereep-sp/floating-point.json
>> @@ -15,7 +15,7 @@
>>           "UMask": "0x4",
>>           "EventName": "FP_ASSIST.INPUT",
>>           "SampleAfterValue": "20000",
>> -        "BriefDescription": "X87 Floating poiint assists for invalid input value (Precise Event)"
>> +        "BriefDescription": "X87 Floating point assists for invalid input value (Precise Event)"
>>       },
>>       {
>>           "PEBS": "1",
>> diff --git a/tools/perf/pmu-events/arch/x86/westmereex/floating-point.json b/tools/perf/pmu-events/arch/x86/westmereex/floating-point.json
>> index 7d2f71a9dee3..6b9b9fe74f3b 100644
>> --- a/tools/perf/pmu-events/arch/x86/westmereex/floating-point.json
>> +++ b/tools/perf/pmu-events/arch/x86/westmereex/floating-point.json
>> @@ -15,7 +15,7 @@
>>           "UMask": "0x4",
>>           "EventName": "FP_ASSIST.INPUT",
>>           "SampleAfterValue": "20000",
>> -        "BriefDescription": "X87 Floating poiint assists for invalid input value (Precise Event)"
>> +        "BriefDescription": "X87 Floating point assists for invalid input value (Precise Event)"
>>       },
>>       {
>>           "PEBS": "1",
>> -- 
>> 2.22.0.214.g8dca754b1e87
