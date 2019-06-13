Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4954C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A442720644
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:32:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392376AbfFMQct (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:32:49 -0400
Received: from mga12.intel.com ([192.55.52.136]:24383 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730847AbfFMIPL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 04:15:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jun 2019 01:15:10 -0700
X-ExtLoop1: 1
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.198]) ([10.237.72.198])
  by fmsmga006.fm.intel.com with ESMTP; 13 Jun 2019 01:15:09 -0700
Subject: Re: [PATCH 01/11] perf intel-pt: Add new packets for PEBS via PT
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
References: <20190610072803.10456-1-adrian.hunter@intel.com>
 <20190610072803.10456-2-adrian.hunter@intel.com>
 <20190612000945.GE28689@kernel.org>
 <e0a9a4e9-6c49-ecd1-4729-79002c66fafe@intel.com>
 <20190612124140.GA4836@kernel.org>
 <a3efee50-cf64-d139-237f-b51be8f76f3c@intel.com>
 <20190612132852.GB4836@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <f94716f2-5696-ad3b-64d7-0620975116e2@intel.com>
Date:   Thu, 13 Jun 2019 11:13:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190612132852.GB4836@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/06/19 4:28 PM, Arnaldo Carvalho de Melo wrote:
> Em Wed, Jun 12, 2019 at 03:52:11PM +0300, Adrian Hunter escreveu:
>> On 12/06/19 3:41 PM, Arnaldo Carvalho de Melo wrote:
>>> Em Wed, Jun 12, 2019 at 08:58:00AM +0300, Adrian Hunter escreveu:
>>>> On 12/06/19 3:09 AM, Arnaldo Carvalho de Melo wrote:
>>>>> Em Mon, Jun 10, 2019 at 10:27:53AM +0300, Adrian Hunter escreveu:
>>>>>> Add 3 new packets to supports PEBS via PT, namely Block Begin Packet (BBP),
>>>>>> Block Item Packet (BIP) and Block End Packet (BEP). PEBS data is encoded
>>>>>> into multiple BIP packets that come between BBP and BEP. The BEP packet
>>>>>> might be associated with a FUP packet. That is indicated by using a
>>>>>> separate packet type (INTEL_PT_BEP_IP) similar to other packets types with
>>>>>> the _IP suffix.
>>>>>>
>>>>>> Refer to the Intel SDM for more information about PEBS via PT.
>>>>>
>>>>> In these cases would be nice to provide an URL and page number, for
>>>>> convenience.
>>>>
>>>> Intel SDM:
>>>>
>>>> 	https://software.intel.com/en-us/articles/intel-sdm
>>>>
>>>> May 2019 version: Vol. 3B 18.5.5.2 PEBS output to Intel® Processor Trace
>>>
>>> Thanks! I'll add to that cset.
>>>
>>> What about the kernel bits?
>>
>> Awaiting V2, here is a link to the patches:
>>
>> 	https://lore.kernel.org/lkml/20190502105022.15534-1-alexander.shishkin@linux.intel.com/
> 
> yeah, I saw those and PeterZ's comments, that is why I asked about them
> :-)
>  
>> There is also still a few more tools changes dependent upon the kernel patches.
> 
> But I think I can go ahead and push the decoder bits, when the kernel
> patches get merged we'll be almost ready to make full use of what it
> provides, right?

Yes


