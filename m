Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F30BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 16:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31316218A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 16:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729496AbfCOQWQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 12:22:16 -0400
Received: from mga01.intel.com ([192.55.52.88]:8414 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726632AbfCOQWQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 12:22:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Mar 2019 09:22:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,482,1544515200"; 
   d="scan'208";a="214518067"
Received: from tthayer-hp-z620.an.intel.com (HELO [10.122.105.146]) ([10.122.105.146])
  by orsmga001.jf.intel.com with ESMTP; 15 Mar 2019 09:22:14 -0700
Reply-To: thor.thayer@linux.intel.com
Subject: Re: [PATCHv2 2/5] Documentation: dt: edac: Add Stratix10 Peripheral
 bindings
To:     Rob Herring <robh@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>, Dinh Nguyen <dinguyen@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        devicetree@vger.kernel.org, linux-edac@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1551288445-22335-1-git-send-email-thor.thayer@linux.intel.com>
 <1551288445-22335-3-git-send-email-thor.thayer@linux.intel.com>
 <20190312160445.GA8802@bogus>
 <8b671f75-8488-1e06-a020-5f7d95166918@linux.intel.com>
 <CAL_JsqJHKwOBcHLwfHfB407XkU4SFDymbWR05fN+Zft1ki+b=w@mail.gmail.com>
From:   Thor Thayer <thor.thayer@linux.intel.com>
Message-ID: <58583ae5-2a8c-97ab-9a82-fef8d4077169@linux.intel.com>
Date:   Fri, 15 Mar 2019 11:24:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJHKwOBcHLwfHfB407XkU4SFDymbWR05fN+Zft1ki+b=w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 3/13/19 2:20 PM, Rob Herring wrote:
> On Tue, Mar 12, 2019 at 2:28 PM Thor Thayer <thor.thayer@linux.intel.com> wrote:
>>
>> Hi Rob,
>>
>> On 3/12/19 11:04 AM, Rob Herring wrote:
>>> On Wed, Feb 27, 2019 at 11:27:22AM -0600, thor.thayer@linux.intel.com wrote:
>>>> From: Thor Thayer <thor.thayer@linux.intel.com>
>>>>
>>>> Add peripheral bindings for Stratix10 EDAC to capture
>>>> the differences between the ARM64 and ARM32 architecture.
>>>
>>> What's the difference? Sounds like 2 different chips, so Stratix10 or
>>> s10 is not specific enough perhaps.
>>>
>>
>> Yes, our ARM32 chips are the Cyclone5 and Arria10. The Stratix10 is
>> ARM64 and I'm using S10 as shorthand for the Stratix10.
> 
> So it's really just differences between one chip and another... ARM32
> vs 64 really has nothing to do with that.
> 
>>
>> The ECC blocks are very similar between Arria10 and Stratix10 but there
>> are differences as a result of the ARM32 vs ARM64 architecture
>> differences. The major difference is how Double Bit Errors are handled.
>> In the ARM32, the DBE is mapped to an IRQ. On ARM64, the DBE is mapped
>> to a SError.
> 
> Okay, I guess that's why arm64 matters...
> 
>> I had started out re-using the Arria10 bindings for Stratix10 since they
>> were very similar. Dinh pointed out that having separate bindings for
>> ARM64 would allow separation between the architectures and make future
>> changes easier.
>>
>> I'm unclear on the comment about being specific enough. Are you
>> suggesting that I use arm64 in the binding name instead of s10? Or is
>> there a better naming convention I should follow?
> 
> NM, it was me that was confused. It was that Stratix10 was already
> mentioned in the doc that confused me.
> 
> Rob

I can reword this to make it clearer. Do you have any additional 
suggestions for clarification aside from ARM64 vs ARM32 IRQ handling as 
we discuss above that you would need to ack this patch?

Thanks,

Thor
