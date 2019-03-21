Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD23DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 14:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A037218E2
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 14:30:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="maxJHzBf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbfCUOap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 10:30:45 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:43166 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbfCUOap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 10:30:45 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2LEUYSc111619;
        Thu, 21 Mar 2019 09:30:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553178634;
        bh=lmdj9m3Tlqqujkt2bXVsNqnfozvdSnd5oEb1xpg9pyE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=maxJHzBfRpVmynz1kPQpAS3opnwUjAQ7GQLvXarXpt5aKaRwmbbKXP8Vq5j4n8hAD
         jVGfsXauSFFFtzjXUVEemzdR44xdPoEHZefmv+nqVwZyzo0Doy2nz7eVeSKpav1YgC
         7YmZC7mWkGUDfDQejHjIE2/tgXd+ECzNwIcp2DfU=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2LEUYnS012665
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 21 Mar 2019 09:30:34 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 21
 Mar 2019 09:30:34 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5 via Frontend Transport;
 Thu, 21 Mar 2019 09:30:33 -0500
Received: from [172.22.80.91] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2LEUXWW001583;
        Thu, 21 Mar 2019 09:30:33 -0500
Subject: Re: [PATCH 1/4] dt: lm3532: Add lm3532 dt doc and update ti_lmu doc
To:     <robh+dt@kernel.org>, <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>,
        <tony@atomide.com>, <lee.jones@linaro.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>
References: <20190321142838.22985-1-dmurphy@ti.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <8534f562-a7d1-cae5-c944-966f9d4a8089@ti.com>
Date:   Thu, 21 Mar 2019 09:30:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190321142838.22985-1-dmurphy@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All

On 3/21/19 9:28 AM, Dan Murphy wrote:
> Add the lm3532 device tree documentation.
> Remove lm3532 device tree reference from the ti_lmu devicetree
> documentation.
> 
> With the addition of the dedicated lm3532 documentation the device
> can be removed from the ti_lmu.txt.
> 
> The reason for this is that the lm3532 dt documentation now defines
> the ability to control LED output strings against different control
> banks or groups multiple strings to be controlled by a single control
> bank.
> 
> Another addition was for ALS lighting control and configuration.  The
> LM3532 has a feature that can take in the ALS reading from 2 separate
> ALS devices and adjust the brightness on the strings that are configured
> to support this feature.
> 
> Finally the device specific properties were moved to the parent node as these
> properties are not control bank configurable.  These include the runtime ramp
> and the ALS configuration.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
> 
> v5 - Moved ramping range to below property definition, updated keyboard label -
> https://lore.kernel.org/patchwork/patch/1050412/
> 
<snip>

I missed the v5 in $subject

But this patch set is v5

Dan
-- 
------------------
Dan Murphy
