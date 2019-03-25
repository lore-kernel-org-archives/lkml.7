Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F74DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 12:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FAE72085A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 12:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mEfCPlXc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731166AbfCYMgO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 08:36:14 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:54252 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730603AbfCYMgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 08:36:14 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2PCa7Za097548;
        Mon, 25 Mar 2019 07:36:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553517367;
        bh=FkThucz8FE1H0tijG4AoCQcV2Zm9NiuCavTJpcZkSWw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=mEfCPlXcUVyk1zhQ+V4Hkd6L8Z5h/ZkqccPLmeEVbajHgJdDvF+TjTRnSZZuQDVfv
         vgWIh3AzXD9UHC6znLb3atG+rwjcQfgfAiY00RWDYG+fmzm5J+xTTHFp6NiB81Ip7H
         EkaVnnmB7bhsvrsisXIZ2S45nIpSv1rxL65lUNqw=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2PCa7Ws004906
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 25 Mar 2019 07:36:07 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 25
 Mar 2019 07:36:06 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5 via Frontend Transport;
 Mon, 25 Mar 2019 07:36:06 -0500
Received: from [172.22.78.61] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2PCa6sE000567;
        Mon, 25 Mar 2019 07:36:06 -0500
Subject: Re: [PATCH 4/4] leds: lm3532: Introduce the lm3532 LED driver
To:     Tony Lindgren <tony@atomide.com>
CC:     <robh+dt@kernel.org>, <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>,
        <lee.jones@linaro.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        Sebastian Reichel <sre@kernel.org>
References: <20190321142838.22985-1-dmurphy@ti.com>
 <20190321142838.22985-4-dmurphy@ti.com> <20190322221654.GG19425@atomide.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <dc24b66c-658e-41aa-c869-42c4a7e812a8@ti.com>
Date:   Mon, 25 Mar 2019 07:35:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190322221654.GG19425@atomide.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tony

On 3/22/19 5:16 PM, Tony Lindgren wrote:
> Hi,
> 
> * Dan Murphy <dmurphy@ti.com> [190321 14:29]:
>> Introduce the Texas Instruments LM3532 White LED driver.
>> The driver supports ALS configurability or manual brightness
>> control.
>>
>> The driver also supports associating LED strings with specific
>> control banks in a group or as individually controlled strings.
> 
> Thanks for getting this driver done. I need help a bit using
> this though.. What's the glue to the drm driver?
> 
> I can control the backlight brightness just fine via /sys, and
> backlight shows up as the trigger in /sys/class/leds/lm3532:backlight,
> but /sys/class/backlight is empty and looks like drm can't find it.
> 
> Do I need to enable some additional driver(s) to get this to work
> with the drm driver?
> 

Can you dump or point to the defconfig?

Dan

> Regards,
> 
> Tony
> 


-- 
------------------
Dan Murphy
