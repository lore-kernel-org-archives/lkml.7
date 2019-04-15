Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2292C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 10:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD65020883
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 10:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KoQdK5wB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfDOKWN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 06:22:13 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:45646 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbfDOKWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 06:22:13 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3FALJZT110511;
        Mon, 15 Apr 2019 05:21:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1555323679;
        bh=8b6kBhBFdSOPc8SDTqfFQA0rlFoTm7OJpkSsvharSJM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=KoQdK5wBVpzrrLzM8DGwZAvw6QIEXMeSjnqx65zHyPGTU4yaLZeL4mZWMGpAEs3xg
         pCWE7QdSODuK2/LpLkZbkwSszNXVVoHlHoEUisDi8ZzH2QahlhkaNpazmPTJpEBaEw
         wtm6YBB5arWBwi2BQ33SSLN0AXBf2GiPajwTVIiA=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3FALITm046495
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 15 Apr 2019 05:21:19 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 15
 Apr 2019 05:21:18 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 15 Apr 2019 05:21:18 -0500
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3FALEpE020868;
        Mon, 15 Apr 2019 05:21:15 -0500
Subject: Re: [PATCH v3 1/3] ARM: dts: da850: add cpu node and operating points
 to DT
To:     Bartosz Golaszewski <brgl@bgdev.pl>
CC:     Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Lechner <david@lechnology.com>,
        Adam Ford <aford173@gmail.com>,
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
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <6ff5711c-b607-1f3a-e362-709b53762179@ti.com>
Date:   Mon, 15 Apr 2019 15:51:13 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAMRc=Me8vppb9vEmKOUcU28YKVR9jJ64sBSn-KwNyNnZA=VB9Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/19 9:01 PM, Bartosz Golaszewski wrote:
> pt., 12 kwi 2019 o 15:53 Sekhar Nori <nsekhar@ti.com> napisał(a):
>>
>> On 12/04/19 5:41 PM, Bartosz Golaszewski wrote:
>>> pt., 12 kwi 2019 o 13:26 Sekhar Nori <nsekhar@ti.com> napisał(a):
>>>>
>>>> Hi Bartosz,
>>>>
>>>> On 08/04/19 1:29 PM, Bartosz Golaszewski wrote:
>>>>> From: David Lechner <david@lechnology.com>
>>>>>
>>>>> This adds a cpu node and operating points to the common da850.dtsi file.
>>>>>
>>>>> Additionally, a regulator is added to the LEGO EV3 board along with
>>>>> some board-specific CPU configuration.
>>>>>
>>>>> Regulators need to be hooked up on other boards to get them working.
>>>>>
>>>>> Signed-off-by: David Lechner <david@lechnology.com>
>>>>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>>>
>>>> I remember you mentioning about some problems using OCHI and cpufreq
>>>> together. Are those resolved now? CPU PLL on DA850 can affect other
>>>> peripheral clock frequencies too. So enabling it should really be a
>>>> per-board decision.
>>>>
>>>
>>> The problems are still there. I've never been able to find the
>>> culprit, but it also occurs on TI BSP in the same way (a couple
>>> cpufreq transitions will make the controller unresponsive).
>>
>> Is that on LCDK as well? As I recall cpufreq was never enabled on LCDK
>> in TI BSP.
>>
> 
> Yes, I just verified that the bug occurs on LCDK with patches from this series.
> 
>> If the OHCI problem is present on LCDK, then there is a user visible
>> regression on mainline after this patch. Lets enable cpufreq in LCDK
>> only if all working peripherals keep working afterwards.
>>
> 
> The OHCI driver doesn't register any cpufreq transition notifier
> callbacks. I can't really find anything in the datasheet, but I'm
> wondering if we shouldn't do something similar to what the driver for
> davinci i2c controller does. I'll try a couple things tomorrow.

Even if OHCI issue is fixed, with a fixed regulator like on LCDK, I am
not sure the benefits of just frequency scaling will be justifiable enough.

Fixing the OHCI issue may help in other boards like da850-evm use it
though. So that will be a good thing.

How do you feel about keeping all OPPs disabled by default in da850.dtsi
and enabling only the ones that make sense for a board in <board>.dts?

Empty OPP table is illegal, so this does mean that every board must
enable at least one OPP.

Thanks,
Sekhar
