Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7605C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9A8520866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409165AbfFLMx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 08:53:29 -0400
Received: from mga03.intel.com ([134.134.136.65]:3953 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726061AbfFLMx2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 08:53:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jun 2019 05:53:27 -0700
X-ExtLoop1: 1
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.198]) ([10.237.72.198])
  by orsmga001.jf.intel.com with ESMTP; 12 Jun 2019 05:53:26 -0700
Subject: Re: [PATCH 01/11] perf intel-pt: Add new packets for PEBS via PT
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
References: <20190610072803.10456-1-adrian.hunter@intel.com>
 <20190610072803.10456-2-adrian.hunter@intel.com>
 <20190612000945.GE28689@kernel.org>
 <e0a9a4e9-6c49-ecd1-4729-79002c66fafe@intel.com>
 <20190612124140.GA4836@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <a3efee50-cf64-d139-237f-b51be8f76f3c@intel.com>
Date:   Wed, 12 Jun 2019 15:52:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190612124140.GA4836@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/06/19 3:41 PM, Arnaldo Carvalho de Melo wrote:
> Em Wed, Jun 12, 2019 at 08:58:00AM +0300, Adrian Hunter escreveu:
>> On 12/06/19 3:09 AM, Arnaldo Carvalho de Melo wrote:
>>> Em Mon, Jun 10, 2019 at 10:27:53AM +0300, Adrian Hunter escreveu:
>>>> Add 3 new packets to supports PEBS via PT, namely Block Begin Packet (BBP),
>>>> Block Item Packet (BIP) and Block End Packet (BEP). PEBS data is encoded
>>>> into multiple BIP packets that come between BBP and BEP. The BEP packet
>>>> might be associated with a FUP packet. That is indicated by using a
>>>> separate packet type (INTEL_PT_BEP_IP) similar to other packets types with
>>>> the _IP suffix.
>>>>
>>>> Refer to the Intel SDM for more information about PEBS via PT.
>>>
>>> In these cases would be nice to provide an URL and page number, for
>>> convenience.
>>
>> Intel SDM:
>>
>> 	https://software.intel.com/en-us/articles/intel-sdm
>>
>> May 2019 version: Vol. 3B 18.5.5.2 PEBS output to Intel® Processor Trace
> 
> Thanks! I'll add to that cset.
> 
> What about the kernel bits?

Awaiting V2, here is a link to the patches:

	https://lore.kernel.org/lkml/20190502105022.15534-1-alexander.shishkin@linux.intel.com/

There is also still a few more tools changes dependent upon the kernel patches.
