Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B944DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89C2520830
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:01:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="V6zVTAzk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729691AbfCYQB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 12:01:56 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:52892 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728991AbfCYQBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 12:01:55 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2PG1lUm074837;
        Mon, 25 Mar 2019 11:01:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553529707;
        bh=dLWY9U2Mt/ftET03vad5ptuLfgz7sONrrt+6nTVma7Q=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=V6zVTAzktasYDINk3ZEoEMMJ0bNCASAiCf2p3q/O60qaB8waUBrqgybLjW1jUTC8A
         PprQ7YoyfuEatT2aIbObPmzUtnSXhfzW6vpKNUx+XLok2YbMS8OJzxMDSrDuGab+Qx
         /ZHtR+1SIb2Tk9AFXjnpAFSP9BiKruOl4FJ9A2bc=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2PG1lcv039500
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 25 Mar 2019 11:01:47 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 25
 Mar 2019 11:01:47 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5 via Frontend Transport;
 Mon, 25 Mar 2019 11:01:47 -0500
Received: from [128.247.59.33] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2PG1kii003231;
        Mon, 25 Mar 2019 11:01:46 -0500
Subject: Re: [PATCH 4/4] leds: lm3532: Introduce the lm3532 LED driver
To:     Tony Lindgren <tony@atomide.com>
CC:     <robh+dt@kernel.org>, <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>,
        <lee.jones@linaro.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        Sebastian Reichel <sre@kernel.org>
References: <20190321142838.22985-1-dmurphy@ti.com>
 <20190321142838.22985-4-dmurphy@ti.com> <20190322221654.GG19425@atomide.com>
 <dc24b66c-658e-41aa-c869-42c4a7e812a8@ti.com>
 <20190325145444.GK19425@atomide.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <044f67e7-e196-a5b9-728b-a7c5f283f56f@ti.com>
Date:   Mon, 25 Mar 2019 11:01:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190325145444.GK19425@atomide.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/25/19 9:54 AM, Tony Lindgren wrote:
> * Dan Murphy <dmurphy@ti.com> [190325 12:36]:
>> On 3/22/19 5:16 PM, Tony Lindgren wrote:
>>> I can control the backlight brightness just fine via /sys, and
>>> backlight shows up as the trigger in /sys/class/leds/lm3532:backlight,
>>> but /sys/class/backlight is empty and looks like drm can't find it.
>>>
>>> Do I need to enable some additional driver(s) to get this to work
>>> with the drm driver?
>>>
>>
>> Can you dump or point to the defconfig?
> 
> This is just with the omap2plus_defconfig as in the droid4-pending-v5.0
> test branch below [0]. That branch has Sebastian's drm patches. The
> branch also has the older ti-lmu patches that I reverted for testing
> before applying your new series and enabling it in .config.
> 
> The drm driver (drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c) just
> does:
> 
> backlight = of_parse_phandle(node, "backlight", 0);
> ...
> 
> That should still work the same, right?

Yes it should still work the same.
I did not change the node name.
So the DRM driver should find the node.

Dan

> 
> Regards,
> 
> Tony
> 
> 
> [0] https://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git/log/?h=droid4-pending-v5.0
> 


-- 
------------------
Dan Murphy
