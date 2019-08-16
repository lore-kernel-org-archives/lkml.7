Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5906CC3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 03:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E5B5206C2
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 03:22:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfHPDWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 23:22:22 -0400
Received: from mga04.intel.com ([192.55.52.120]:46732 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726541AbfHPDWV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 23:22:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Aug 2019 20:22:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,391,1559545200"; 
   d="scan'208";a="171298712"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 15 Aug 2019 20:22:21 -0700
Received: from [10.226.38.74] (rtanwar-mobl.gar.corp.intel.com [10.226.38.74])
        by linux.intel.com (Postfix) with ESMTP id CD0AC5806C4;
        Thu, 15 Aug 2019 20:22:17 -0700 (PDT)
Subject: Re: [PATCH 2/3] x86: cpu: Add new Intel Atom CPU type
To:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, andriy.shevchenko@intel.com, alan@linux.intel.com,
        ricardo.neri-calderon@linux.intel.com, rafael.j.wysocki@intel.com,
        linux-kernel@vger.kernel.org, qi-ming.wu@intel.com,
        cheol.yong.kim@intel.com, rahul.tanwar@intel.com
References: <cover.1565856842.git.rahul.tanwar@linux.intel.com>
 <16de4480ae1216d5949d4d36787811dae35d2eff.1565856842.git.rahul.tanwar@linux.intel.com>
 <20190815122222.GE15313@zn.tnic>
From:   "Tanwar, Rahul" <rahul.tanwar@linux.intel.com>
Message-ID: <68ad47a7-ac6f-0a1b-0892-850bb95c002b@linux.intel.com>
Date:   Fri, 16 Aug 2019 11:22:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190815122222.GE15313@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Boris,

Well noted, will have Tony in loop from now on. Thanks.

Regards,

Rahul

On 15/8/2019 8:22 PM, Borislav Petkov wrote:
> On Thu, Aug 15, 2019 at 05:46:46PM +0800, Rahul Tanwar wrote:
>> This patch adds a new variant of Intel Atom Airmont CPU model used in a
>> network processor SoC named Lightning Mountain.
>>
>> Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
>> ---
>>   arch/x86/include/asm/intel-family.h | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
>> index 0278aa66ef62..cbbb8250370f 100644
>> --- a/arch/x86/include/asm/intel-family.h
>> +++ b/arch/x86/include/asm/intel-family.h
>> @@ -73,6 +73,7 @@
>>   
>>   #define INTEL_FAM6_ATOM_AIRMONT		0x4C /* Cherry Trail, Braswell */
>>   #define INTEL_FAM6_ATOM_AIRMONT_MID	0x5A /* Moorefield */
>> +#define INTEL_FAM6_ATOM_AIRMONT_NP	0x75 /* Lightning Mountain */
>>   
>>   #define INTEL_FAM6_ATOM_GOLDMONT	0x5C /* Apollo Lake */
>>   #define INTEL_FAM6_ATOM_GOLDMONT_X	0x5F /* Denverton */
>> -- 
> Also, in addition to what Thomas said, due to the fact that all the
> different groups within Intel are sending patches with model names,
> please synchronize that model naming and patch sending with Tony from
> now on:
>
> https://git.kernel.org/tip/5ed1c835ed8b522ce25071cc2d56a9a09bd5b59e
>
> He'll document the naming scheme and pay attention to what goes where so
> make sure you CC him, talk to him or have him in the loop, in general.
>
> Thx.
>
