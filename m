Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 886E7C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 20:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 425A220818
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 20:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hUfcG7PR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbfDKUxu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 16:53:50 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:47420 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbfDKUxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 16:53:50 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3BKrY7O093094;
        Thu, 11 Apr 2019 15:53:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1555016014;
        bh=dausjAGKJ+uwqX0Iyfw1J3iolFX79hqLKHQZ798Qm0M=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=hUfcG7PRV+XiOjI5Q+0DpP++lc3TTklGYMf3SJf2QLqer9wwll5yk3Sj654V38env
         D6nG0+RBO81m6NgwgfjMorLlyscI6Qy07LpouMrj66RZzukc6UScVX3aYOsDkV61Qd
         jgmgHux9gMJ4WOt2Syhh9yrQvMoHI1utEbQBnVEE=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3BKrYDr117338
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 11 Apr 2019 15:53:34 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 11
 Apr 2019 15:53:34 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 11 Apr 2019 15:53:33 -0500
Received: from [10.250.81.84] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3BKrXfW050283;
        Thu, 11 Apr 2019 15:53:33 -0500
Subject: Re: [PATCH v2 7/7] leds: lp50xx: Add the LP50XX family of the RGB LED
 driver
To:     <robh+dt@kernel.org>, <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>,
        <marek.behun@nic.cz>, <rdunlap@infradead.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>
References: <20190411193848.23140-1-dmurphy@ti.com>
 <20190411193848.23140-8-dmurphy@ti.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <15ab56e5-8497-a287-3d83-a8f94be99235@ti.com>
Date:   Thu, 11 Apr 2019 15:53:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411193848.23140-8-dmurphy@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

On 4/11/19 2:38 PM, Dan Murphy wrote:
> Introduce the LP5036/30/24/18 RGB LED driver.
> The difference in these parts are the number of
> LED outputs where the:
> 
> LP5036 can control 36 LEDs
> LP5030 can control 30 LEDs
> LP5024 can control 24 LEDs
> LP5018 can control 18 LEDs
> 
> The device has the ability to group LED output into control banks
> so that multiple LED banks can be controlled with the same mixing and
> brightness.  Inversely the LEDs can also be controlled independently.
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>  Documentation/leds/leds-lp50xx.txt |  36 ++

This document needs to be removed or updated as it is not correct.

Dan
<snip>
