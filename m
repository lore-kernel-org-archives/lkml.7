Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B48C49ED9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 09:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15C8E208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 09:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="tT2eclH0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730671AbfILJT2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 05:19:28 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:40622 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730428AbfILJT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 05:19:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1568279965; x=1599815965;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=LkwyiRDW5AuLTlrvucn0bIl3DDuBsIfG9ze/YovR0r4=;
  b=tT2eclH0t1O1K5+I0lhST20dS4AOIzhblWfdbd7pZimUypZuPIRDqP4d
   Hp2bNeF7WCESonSrUNV+eNh2tTCU+a2+Zftc1sJz8dgJKC8Q+Ic8Bg5zf
   1OaxdqIzR8/Ne6Y4PCeAtF4hA6hoHwIaEJd6+Xm1GakeHtZKwNVXT7z1a
   s=;
X-IronPort-AV: E=Sophos;i="5.64,495,1559520000"; 
   d="scan'208";a="784588455"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-55156cd4.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 12 Sep 2019 09:19:22 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-55156cd4.us-west-2.amazon.com (Postfix) with ESMTPS id 042B5A1EB8;
        Thu, 12 Sep 2019 09:19:21 +0000 (UTC)
Received: from EX13D01EUB002.ant.amazon.com (10.43.166.113) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 09:19:20 +0000
Received: from [10.125.238.52] (10.43.162.218) by EX13D01EUB002.ant.amazon.com
 (10.43.166.113) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 12 Sep
 2019 09:19:14 +0000
Subject: Re: [UNVERIFIED SENDER] Re: [UNVERIFIED SENDER] Re: [PATCH v2 2/3]
 soc: amazon: al-pos: Introduce Amazon's Annapurna Labs POS driver
To:     Marc Zyngier <maz@kernel.org>
CC:     <robh+dt@kernel.org>, <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <mark.rutland@arm.com>, <nicolas.ferre@microchip.com>,
        <mchehab+samsung@kernel.org>, <shawn.lin@rock-chips.com>,
        <gregkh@linuxfoundation.org>, <dwmw@amazon.co.uk>,
        <benh@kernel.crashing.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, James Morse <james.morse@arm.com>
References: <1568142310-17622-1-git-send-email-talel@amazon.com>
 <1568142310-17622-3-git-send-email-talel@amazon.com>
 <86d0g6syva.wl-maz@kernel.org>
 <3205f7ae-5568-c064-23ac-ea726246173b@amazon.com>
 <865zlxsxtd.wl-maz@kernel.org>
From:   "Shenhar, Talel" <talel@amazon.com>
Message-ID: <36f19b3f-46d3-f6d0-3681-71e3a9bb52ce@amazon.com>
Date:   Thu, 12 Sep 2019 12:19:09 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <865zlxsxtd.wl-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.43.162.218]
X-ClientProxiedBy: EX13D19UWA004.ant.amazon.com (10.43.160.102) To
 EX13D01EUB002.ant.amazon.com (10.43.166.113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/12/2019 11:50 AM, Marc Zyngier wrote:
> On Thu, 12 Sep 2019 07:50:03 +0100,
> "Shenhar, Talel" <talel@amazon.com> wrote:
>> Hi Marc,
>>
>>
>> On 9/11/2019 5:15 PM, Marc Zyngier wrote:
>>> [+James]
>>>
>>> Hi Talel,
>>>
>>> On Tue, 10 Sep 2019 20:05:09 +0100,
>>> Talel Shenhar <talel@amazon.com> wrote:
>>>
>>>> +	log1 = readl(pos->mmio_base + AL_POS_ERROR_LOG_1);
>>> Do you actually need the implied barriers? I'd expect that relaxed
>>> accesses should be enough.
>> You are correct. Barriers are not needed, In v1 this driver indeed
>> used _relaxed versions.
>>
>> Due to request coming from Arnd in v1 patch series I removed it. As
>> this is not data path I had no strong objection for removing it.
> Independently from whether this has any material impact on performance
> (this obviously isn't a hot path, unless it can be directly generated
> by userspace or a guest), I believe it is important to use the right
> type of accessor, if only because code gets copied around... Others
> would probably argue that this is the very reason why we should always
> use the "safe" option...
Arnld, would love your inputs before publishing v3 to avoid ping-pong.
>
>>>> +	if (!FIELD_GET(AL_POS_ERROR_LOG_1_VALID, log1))
>>>> +		return IRQ_NONE;
>>>> +
>>>> +	log0 = readl(pos->mmio_base + AL_POS_ERROR_LOG_0);
>>>> +	writel(0, pos->mmio_base + AL_POS_ERROR_LOG_1);
>>>> +
>>>> +	addr = FIELD_GET(AL_POS_ERROR_LOG_0_ADDR_LOW, log0);
>>>> +	addr |= (FIELD_GET(AL_POS_ERROR_LOG_1_ADDR_HIGH, log1) << 32);
>>>> +	request_id = FIELD_GET(AL_POS_ERROR_LOG_1_REQUEST_ID, log1);
>>>> +	bresp = FIELD_GET(AL_POS_ERROR_LOG_1_BRESP, log1);
>>>> +
>>>> +	dev_err(&pdev->dev, "addr=0x%llx request_id=0x%x bresp=0x%x\n",
>>>> +		addr, request_id, bresp);
>>> What is this information? How do we make use of it? Given that this is
>>> asynchronous, how do we correlate it to the offending software?
>> Indeed this information arriving from the HW is asynchronous.
>>
>> There is no direct method to get the offending software.
>>
>> There are all kinds of hacks we do to find the offending software once
>> we find this error. most of the time its a new patch introduced but
>> some of the time is just digging.
> OK, so that the moment, this is more of a debug tool than anything
> else, right?
Not sure what do you mean by debug tool. this is used to capture iliigle 
access and allow panic() based on them or simple logging.
>
>>> The whole think looks to me like a poor man's EDAC handling, and I'd
>>> expect to be plugged in that subsystem instead. Any reason why this
>>> isn't the case? It would certainly make the handling uniform for the
>>> user.
>> This logic was not plugged into EDAC as there is no "Correctable"
>> error here. its just error event. Not all errors are EDAC in the sense
>> of Error Detection And *Correction*. There are no correctable errors
>> for this driver.
> I'd argue the opposite! Because you obviously don't let a read-only
> register being written to, the error has been corrected, and you
> signal the correction status.

Not the meaning of corrected from my point of view - the system as a 
whole (sw&hw) are not working state. a driver thinks it configured the 
system to do A while the system doesn't really do that. and the critical 
part is that the driver that did operation A doesn't even have a way to 
know it.

So I would not call this corrected.

>
>> So plugging it  under EDAC seems like abusing the EDAC system.
>>
>> Now that I've emphasize the reason for not putting this under EDAC,
>> what do you think? should this "only uncorrectable event" driver
>> should be part of EDAC?
> My choice would be to plug it into the EDAC subsystem, and report all
> interrupts as "Corrected" events. Optionally, and only if you are
> debugging something that requires it, report the error as
> "Uncorrectable", in which case the EDAC subsystem should trigger a
> panic.
>
> At least you'd get the infrastructure, logging and tooling that the
> EDAC subsystem offers (parsing the kernel log doesn't really count).

I see what you say. However, I don't see too much added value in 
plugging this to EDAC and feel like it would abuse EDAC framework.

James, will love your input from EDAC point of view, does it make sense 
to plug un-correctable only event to EDAC?

>
> Thanks,
>
> 	M.
>
