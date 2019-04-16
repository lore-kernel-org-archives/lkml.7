Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB87C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E37720656
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:38:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="a1Af/8Mj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729650AbfDPOir (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 10:38:47 -0400
Received: from vern.gendns.com ([98.142.107.122]:39850 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726605AbfDPOiq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 10:38:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=G2x9v5SgENGnSRUr1tDFEE7imz6Sn30s9pgACIadTQo=; b=a1Af/8MjWfDTnQgwQiBmbDmARG
        EQtqTvOcrElk3unPWDSnJ4cNuxJg08A1u+Ktt/DDrKIo0Lc+IswfiCMFt/yniUEZkhgU+QheHUNVK
        OreKerHLZqAcQiq9w7VeLgLbASQ+PKlr6sFhzO+xSr4faKODN3DXxyimYMoZMutFjZdq5vFtwHIZc
        J4IMlZMqNdmldag79y8kBfuBw2EzjsULAV9C5WVQu4RE4rDijRMJ5PcbRBkHeK041l3bBtct5G/G4
        ozfjUXeLxUtEM62p7hVE+E/ardkJEn9cYqUA9tQLzth5kN7zTHvgHTaZ0MaxlU954ZNdotEOZbdus
        MpTN1RkQ==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:56076 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1hGPES-00067M-6M; Tue, 16 Apr 2019 10:38:44 -0400
Subject: Re: [PATCH v3 1/3] ARM: dts: da850: add cpu node and operating points
 to DT
To:     Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>,
        Adam Ford <aford173@gmail.com>
Cc:     Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20190408075924.2284-1-brgl@bgdev.pl>
 <20190408075924.2284-2-brgl@bgdev.pl>
 <5f72a26b-428a-c50e-cb6a-7c888ea22329@ti.com>
 <CAMRc=McGwGh9RKhxxCDnz3aMG_EVjjXzN+pmMZVtE7aChdU3jw@mail.gmail.com>
 <3f6c906b-53b0-8284-bf4d-9b404f341e7b@ti.com>
 <CAMRc=Me8vppb9vEmKOUcU28YKVR9jJ64sBSn-KwNyNnZA=VB9Q@mail.gmail.com>
 <6ff5711c-b607-1f3a-e362-709b53762179@ti.com>
 <CAMRc=Mfb4xrpLkJoX0SyoCPU6Au1TPxCtr29EhvU=VsKkSt2xQ@mail.gmail.com>
From:   David Lechner <david@lechnology.com>
Message-ID: <06d2ab37-1d79-e1d3-b597-e69c99527c94@lechnology.com>
Date:   Tue, 16 Apr 2019 09:38:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAMRc=Mfb4xrpLkJoX0SyoCPU6Au1TPxCtr29EhvU=VsKkSt2xQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/16/19 3:37 AM, Bartosz Golaszewski wrote:
> pon., 15 kwi 2019 o 12:21 Sekhar Nori <nsekhar@ti.com> napisał(a):
>>
>> On 12/04/19 9:01 PM, Bartosz Golaszewski wrote:
>>> pt., 12 kwi 2019 o 15:53 Sekhar Nori <nsekhar@ti.com> napisał(a):
>>>>
>>>> On 12/04/19 5:41 PM, Bartosz Golaszewski wrote:
>>>>> pt., 12 kwi 2019 o 13:26 Sekhar Nori <nsekhar@ti.com> napisał(a):
>>>>>>
>>>>>> Hi Bartosz,
>>>>>>
>>>>>> On 08/04/19 1:29 PM, Bartosz Golaszewski wrote:
>>>>>>> From: David Lechner <david@lechnology.com>
>>>>>>>
>>>>>>> This adds a cpu node and operating points to the common da850.dtsi file.
>>>>>>>
>>>>>>> Additionally, a regulator is added to the LEGO EV3 board along with
>>>>>>> some board-specific CPU configuration.
>>>>>>>
>>>>>>> Regulators need to be hooked up on other boards to get them working.
>>>>>>>
>>>>>>> Signed-off-by: David Lechner <david@lechnology.com>
>>>>>>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>>>>>
>>>>>> I remember you mentioning about some problems using OCHI and cpufreq
>>>>>> together. Are those resolved now? CPU PLL on DA850 can affect other
>>>>>> peripheral clock frequencies too. So enabling it should really be a
>>>>>> per-board decision.
>>>>>>
>>>>>
>>>>> The problems are still there. I've never been able to find the
>>>>> culprit, but it also occurs on TI BSP in the same way (a couple
>>>>> cpufreq transitions will make the controller unresponsive).
>>>>
>>>> Is that on LCDK as well? As I recall cpufreq was never enabled on LCDK
>>>> in TI BSP.
>>>>
>>>
>>> Yes, I just verified that the bug occurs on LCDK with patches from this series.
>>>
>>>> If the OHCI problem is present on LCDK, then there is a user visible
>>>> regression on mainline after this patch. Lets enable cpufreq in LCDK
>>>> only if all working peripherals keep working afterwards.
>>>>
>>>
>>> The OHCI driver doesn't register any cpufreq transition notifier
>>> callbacks. I can't really find anything in the datasheet, but I'm
>>> wondering if we shouldn't do something similar to what the driver for
>>> davinci i2c controller does. I'll try a couple things tomorrow.
>>
>> Even if OHCI issue is fixed, with a fixed regulator like on LCDK, I am
>> not sure the benefits of just frequency scaling will be justifiable enough.
>>
>> Fixing the OHCI issue may help in other boards like da850-evm use it
>> though. So that will be a good thing.
>>
> 
> I've been trying different things, like suspending the device before
> the transition, resetting the controller or playing with the clock
> during transitions but it always results in the same kind of error:
> 
> ohci-da8xx 1e25000.usb: frame counter not updating; disabled
> ohci-da8xx 1e25000.usb: HC died; cleaning up
> usb 1-1: USB disconnect, device number 2
> 
> If you have any idea - let me know, otherwise I'll give up.
> 
> If we agree on the direction of these patches, then I can go with a
> single enabled OPP for lcdk (456 MHz) and all OPPs up to 375 MHz
> enabled for da850-evm.
> 
> David - do you want to keep the lego board as is?

Yes, I think so. Even if we can't use CPU frequency throttling because
of the USB issue, I think it would still be nice if we could use this
to increase the frequency once during early boot so that we can run
faster than what the bootloader set.

I've actually been running one of my EV3 bricks at 456MHz for almost
a year now without noticing any problems. (This is of course out of
spec since we only have 1.2V so I'm not saying we should add that
operating point to the mainline kernel.)

> 
> Bart
> 
>> How do you feel about keeping all OPPs disabled by default in da850.dtsi
>> and enabling only the ones that make sense for a board in <board>.dts?
>>
>> Empty OPP table is illegal, so this does mean that every board must
>> enable at least one OPP.
>>
>> Thanks,
>> Sekhar

