Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 705EAC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 08:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3202E21901
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 08:03:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388984AbfGYIDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 04:03:31 -0400
Received: from mga03.intel.com ([134.134.136.65]:12585 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387824AbfGYIDb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 04:03:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jul 2019 01:03:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,306,1559545200"; 
   d="scan'208";a="170171327"
Received: from rbhardw1-mobl.gar.corp.intel.com (HELO [10.66.75.233]) ([10.66.75.233])
  by fmsmga008.fm.intel.com with ESMTP; 25 Jul 2019 01:03:28 -0700
Subject: Re: [PATCH 2/2] powercap/rapl: Add Ice Lake NNPI support to RAPL
 driver
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-kernel@vger.kernel.org, len.brown@intel.com,
        rafael.j.wysocki@intel.com, linux-pm@vger.kernel.org
References: <20190614080523.13464-1-rajneesh.bhardwaj@linux.intel.com>
 <2359736.lHFMKXy7DL@kreacher>
From:   "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@linux.intel.com>
Message-ID: <23df19ca-1ec5-ce9b-9862-29d33008e581@linux.intel.com>
Date:   Thu, 25 Jul 2019 13:33:28 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <2359736.lHFMKXy7DL@kreacher>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael

On 28-Jun-19 3:32 AM, Rafael J. Wysocki wrote:
> On Friday, June 14, 2019 10:05:23 AM CEST Rajneesh Bhardwaj wrote:
>> Enables support for ICL-NNPI, which is a neural network processor for deep
>> learning inference. From RAPL point of view it is same as Ice Lake Mobile
>> processor.
>>
>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>> Cc: linux-pm@vger.kernel.org
>> Link: https://lkml.org/lkml/2019/6/5/1034
>> Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
>> ---
>>   drivers/powercap/intel_rapl.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
>> index 4347f15165f8..431c8c8bdf07 100644
>> --- a/drivers/powercap/intel_rapl.c
>> +++ b/drivers/powercap/intel_rapl.c
>> @@ -1157,6 +1157,7 @@ static const struct x86_cpu_id rapl_ids[] __initconst = {
>>   	INTEL_CPU_FAM6(KABYLAKE_DESKTOP,	rapl_defaults_core),
>>   	INTEL_CPU_FAM6(CANNONLAKE_MOBILE,	rapl_defaults_core),
>>   	INTEL_CPU_FAM6(ICELAKE_MOBILE,		rapl_defaults_core),
>> +	INTEL_CPU_FAM6(ICELAKE_NNPI,		rapl_defaults_core),
>>   
>>   	INTEL_CPU_FAM6(ATOM_SILVERMONT,		rapl_defaults_byt),
>>   	INTEL_CPU_FAM6(ATOM_AIRMONT,		rapl_defaults_cht),
>>
> It is in my queue, but I get build errors when I try to apply it.
>
> I guess the definition of ICELAKE_NNPI is not there in the Linus' tree yet.

The dependent patch is now available in mainline, so can you please 
apply this one?

https://github.com/torvalds/linux/blob/bed38c3e2dca01b358a62b5e73b46e875742fd75/arch/x86/include/asm/intel-family.h#L59 


Thanks

Rajneesh


>
>
>
