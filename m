Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EFDDC10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 08:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A5582073F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 08:16:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Bbz+OmU4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731278AbfDQIQF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 04:16:05 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:50780 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbfDQIQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 04:16:04 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3H8FBbJ081109;
        Wed, 17 Apr 2019 03:15:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1555488911;
        bh=wumQSc7E0aWFhIfz28v7eV7qfBezwMbHOMI9jrH1/X0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Bbz+OmU4bgWdnzlzCPj8sCOY1KcawHsGxVOQrGNOHsOiG045xF2xqAa6VdSFzburZ
         EP17W+4h4AyK0Qn13JQRmJfzDBMfcWgpywFAkr8CmFq8J9+fztgD2rcrLXMTNT48EF
         LFaadv7fIwkIrVEiJ4460JEfxycfZpvPP4npeWtc=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3H8FBK5075612
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 17 Apr 2019 03:15:11 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 17
 Apr 2019 03:15:10 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 17 Apr 2019 03:15:11 -0500
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3H8F7R3061372;
        Wed, 17 Apr 2019 03:15:07 -0500
Subject: Re: [PATCH v3 1/3] ARM: dts: da850: add cpu node and operating points
 to DT
To:     Adam Ford <aford173@gmail.com>, Bartosz Golaszewski <brgl@bgdev.pl>
CC:     David Lechner <david@lechnology.com>,
        Kevin Hilman <khilman@kernel.org>,
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
 <CAHCN7x+CAr9MjckhVP_suBRHY+o8Je1aLz28XTL9bnDBd4WyKA@mail.gmail.com>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <7a26df9e-4e8d-2da2-48ad-157a1fe68d66@ti.com>
Date:   Wed, 17 Apr 2019 13:45:06 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAHCN7x+CAr9MjckhVP_suBRHY+o8Je1aLz28XTL9bnDBd4WyKA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/04/19 5:18 PM, Adam Ford wrote:
> On Tue, Apr 16, 2019 at 3:38 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>>
>> pon., 15 kwi 2019 o 12:21 Sekhar Nori <nsekhar@ti.com> napisał(a):
>>>
>>> On 12/04/19 9:01 PM, Bartosz Golaszewski wrote:
>>>> pt., 12 kwi 2019 o 15:53 Sekhar Nori <nsekhar@ti.com> napisał(a):
>>>>>
>>>>> On 12/04/19 5:41 PM, Bartosz Golaszewski wrote:
>>>>>> pt., 12 kwi 2019 o 13:26 Sekhar Nori <nsekhar@ti.com> napisał(a):
>>>>>>>
>>>>>>> Hi Bartosz,
>>>>>>>
>>>>>>> On 08/04/19 1:29 PM, Bartosz Golaszewski wrote:
>>>>>>>> From: David Lechner <david@lechnology.com>
>>>>>>>>
>>>>>>>> This adds a cpu node and operating points to the common da850.dtsi file.
>>>>>>>>
>>>>>>>> Additionally, a regulator is added to the LEGO EV3 board along with
>>>>>>>> some board-specific CPU configuration.
>>>>>>>>
>>>>>>>> Regulators need to be hooked up on other boards to get them working.
>>>>>>>>
>>>>>>>> Signed-off-by: David Lechner <david@lechnology.com>
>>>>>>>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>>>>>>
>>>>>>> I remember you mentioning about some problems using OCHI and cpufreq
>>>>>>> together. Are those resolved now? CPU PLL on DA850 can affect other
>>>>>>> peripheral clock frequencies too. So enabling it should really be a
>>>>>>> per-board decision.
>>>>>>>
>>>>>>
>>>>>> The problems are still there. I've never been able to find the
>>>>>> culprit, but it also occurs on TI BSP in the same way (a couple
>>>>>> cpufreq transitions will make the controller unresponsive).
>>>>>
>>>>> Is that on LCDK as well? As I recall cpufreq was never enabled on LCDK
>>>>> in TI BSP.
>>>>>
>>>>
>>>> Yes, I just verified that the bug occurs on LCDK with patches from this series.
>>>>
>>>>> If the OHCI problem is present on LCDK, then there is a user visible
>>>>> regression on mainline after this patch. Lets enable cpufreq in LCDK
>>>>> only if all working peripherals keep working afterwards.
>>>>>
>>>>
>>>> The OHCI driver doesn't register any cpufreq transition notifier
>>>> callbacks. I can't really find anything in the datasheet, but I'm
>>>> wondering if we shouldn't do something similar to what the driver for
>>>> davinci i2c controller does. I'll try a couple things tomorrow.
>>>
>>> Even if OHCI issue is fixed, with a fixed regulator like on LCDK, I am
>>> not sure the benefits of just frequency scaling will be justifiable enough.
>>>
>>> Fixing the OHCI issue may help in other boards like da850-evm use it
>>> though. So that will be a good thing.
>>>
>>
>> I've been trying different things, like suspending the device before
>> the transition, resetting the controller or playing with the clock
>> during transitions but it always results in the same kind of error:
>>
>> ohci-da8xx 1e25000.usb: frame counter not updating; disabled
>> ohci-da8xx 1e25000.usb: HC died; cleaning up
>> usb 1-1: USB disconnect, device number 2
>>
>> If you have any idea - let me know, otherwise I'll give up.
>>
>> If we agree on the direction of these patches, then I can go with a
>> single enabled OPP for lcdk (456 MHz) and all OPPs up to 375 MHz
>> enabled for da850-evm.
> 
> One last questions, and this probably directed at Sekhar, but what
> happens if you modify the OPP for the boards with fixed regulators to
> enable all the frequencies but with the only available voltage.  Is
> there harm is running the processor at a higher voltage than
> necessary?  I did some quick experiments on a different ARM board and
> I saw some changes in power consumption.  I would think some power
> savings might be better than none, but I don't know if it causes> damage.

The OMAP-L138 datasheet mentions two versions of devices in core voltage
specification:

Variable (1.2V-1.0V) for 375 MHz version
Variable (1.3V-1.0V) for 456 MHz version

If you have 375 MHz version of device, I do not think you should run at
1.3V. I don't know what "damage" it will cause or how long it takes for
any of it to be visible.

Keeping that aside, I doubt there will be a lot of power-saving benefit
without voltage scaling. Even if you see a slightly lower power number
when you reduce frequency, there is also work to be done for the scaling
operation itself.

Thanks,
Sekhar
