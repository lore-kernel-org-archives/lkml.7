Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE00C3A589
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 03:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5977222DD6
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 03:21:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbfHUDVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 23:21:49 -0400
Received: from mga05.intel.com ([192.55.52.43]:51569 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726693AbfHUDVt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 23:21:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Aug 2019 20:21:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,410,1559545200"; 
   d="scan'208";a="179930968"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 20 Aug 2019 20:21:48 -0700
Received: from [10.226.38.83] (rtanwar-mobl.gar.corp.intel.com [10.226.38.83])
        by linux.intel.com (Postfix) with ESMTP id D5579580258;
        Tue, 20 Aug 2019 20:21:44 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] x86/cpu: Add new Intel Atom CPU model name
To:     Peter Zijlstra <peterz@infradead.org>,
        "Luck, Tony" <tony.luck@intel.com>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "alan@linux.intel.com" <alan@linux.intel.com>,
        "ricardo.neri-calderon@linux.intel.com" 
        <ricardo.neri-calderon@linux.intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Wu, Qiming" <qi-ming.wu@intel.com>,
        "Kim, Cheol Yong" <cheol.yong.kim@intel.com>,
        "Tanwar, Rahul" <rahul.tanwar@intel.com>
References: <cover.1565940653.git.rahul.tanwar@linux.intel.com>
 <83345984845d24b6ce97a32bef21cd0bbdffc86d.1565940653.git.rahul.tanwar@linux.intel.com>
 <20190820122233.GN2332@hirez.programming.kicks-ass.net>
 <1D9AE27C-D412-412D-8FE8-51B625A7CC98@intel.com>
 <20190820145735.GW2332@hirez.programming.kicks-ass.net>
From:   "Tanwar, Rahul" <rahul.tanwar@linux.intel.com>
Message-ID: <0a0ce209-697f-a20c-6be8-f3b7f683c978@linux.intel.com>
Date:   Wed, 21 Aug 2019 11:21:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190820145735.GW2332@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 20/8/2019 10:57 PM, Peter Zijlstra wrote:
> On Tue, Aug 20, 2019 at 12:48:05PM +0000, Luck, Tony wrote:
>>>> +#define INTEL_FAM6_ATOM_AIRMONT_NP    0x75 /* Lightning Mountain */
>>> What's _NP ?
>> Network Processor. But that is too narrow a descriptor. This is going to be used in
>> other areas besides networking.
>>
>> I’m contemplating calling it AIRMONT2
> What would describe the special sause that warranted a new SOC? If this
> thing is marketed as 'Network Processor' then I suppose we can actually
> use it, esp. if we're going to see this more, like the MID thing -- that
> lived for a while over multiple uarchs.
>
> Note that for the big cores we added the NNPI thing, which was for
> Neural Network Processing something.


INTEL_FAM6_ATOM_AIRMONT_NP was used keeping in mind the recommended

symbol naming form i.e. INTEL_FAM6{OPTFAMILY}_{MICROARCH}{OPTDIFF}

where OPTDIFF is supposed to be the market segment.


This SoC uses AMT (Admantium/Airmont) configuration which is supposed to be

a higher configuration. Looking at other existing examples, it seems that

INTEL_FAM6_ATOM_AIRMONT_PLUS is most appropriate. Would you have any

concerns with _PLUS name ? Thanks.


