Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F21FC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4E932084D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="drIaVAS3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbfDLNx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 09:53:57 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:55102 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbfDLNx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 09:53:57 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3CDr8q2079636;
        Fri, 12 Apr 2019 08:53:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1555077188;
        bh=BFnGBDtxB2SHNQGDS/nLTQvjwAaiKH8vjTcwm/+DT6I=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=drIaVAS338jd8fC2d9TJJUx6EnAmNdrXT1NeogwjUbmGamNRV6jsFW0JhOcfEmOo5
         TChDSKAEi+k6mAk6pipMjPSvXUfTD5lIpcRkI4ZpvX10TqvZOXwarOgmUO4YI3gZSY
         5ANAwP6iiUJHsVsobbuSRPjDlIlqRV9OuffJpuEw=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3CDr8sx037576
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 12 Apr 2019 08:53:08 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 12
 Apr 2019 08:53:07 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 12 Apr 2019 08:53:08 -0500
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3CDr1ud088212;
        Fri, 12 Apr 2019 08:53:05 -0500
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
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <3f6c906b-53b0-8284-bf4d-9b404f341e7b@ti.com>
Date:   Fri, 12 Apr 2019 19:23:01 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAMRc=McGwGh9RKhxxCDnz3aMG_EVjjXzN+pmMZVtE7aChdU3jw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/19 5:41 PM, Bartosz Golaszewski wrote:
> pt., 12 kwi 2019 o 13:26 Sekhar Nori <nsekhar@ti.com> napisał(a):
>>
>> Hi Bartosz,
>>
>> On 08/04/19 1:29 PM, Bartosz Golaszewski wrote:
>>> From: David Lechner <david@lechnology.com>
>>>
>>> This adds a cpu node and operating points to the common da850.dtsi file.
>>>
>>> Additionally, a regulator is added to the LEGO EV3 board along with
>>> some board-specific CPU configuration.
>>>
>>> Regulators need to be hooked up on other boards to get them working.
>>>
>>> Signed-off-by: David Lechner <david@lechnology.com>
>>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> I remember you mentioning about some problems using OCHI and cpufreq
>> together. Are those resolved now? CPU PLL on DA850 can affect other
>> peripheral clock frequencies too. So enabling it should really be a
>> per-board decision.
>>
> 
> The problems are still there. I've never been able to find the
> culprit, but it also occurs on TI BSP in the same way (a couple
> cpufreq transitions will make the controller unresponsive).

Is that on LCDK as well? As I recall cpufreq was never enabled on LCDK
in TI BSP.

If the OHCI problem is present on LCDK, then there is a user visible
regression on mainline after this patch. Lets enable cpufreq in LCDK
only if all working peripherals keep working afterwards.

Thanks,
Sekhar
