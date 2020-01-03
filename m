Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2178C2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 04:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89239227BF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 04:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="w0TbYF5W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgACErg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 23:47:36 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:58874 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgACErg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 23:47:36 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0034lYFM075525;
        Thu, 2 Jan 2020 22:47:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1578026854;
        bh=YZjLSE0T1eqkPxpnffWq4p++uLHQvyUr3z1/GohK9LE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=w0TbYF5WSHPTbeejCAWy1PnTPJYndVM9uqJeFnbcJD/jMX+MZ31qHfVbXVTK30OHI
         3KoehMAPa2ReQ5OlYYbcTFLXpmHQ2nvbQ4KfZFtVouw8oomqM7JNyCN2LUIDUpS/XH
         ZblSh1arcoT8Z36mynS56r1j1mUO7r7CV1kOKAMQ=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0034lYu4058726;
        Thu, 2 Jan 2020 22:47:34 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 2 Jan
 2020 22:47:33 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 2 Jan 2020 22:47:33 -0600
Received: from [10.24.69.20] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0034lV8s027975;
        Thu, 2 Jan 2020 22:47:32 -0600
Subject: Re: [PATCH v4 0/4] Use ARM SMC Calling Convention when OP-TEE is
 available
To:     "Andrew F. Davis" <afd@ti.com>, Tony Lindgren <tony@atomide.com>
CC:     <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200102211943.20480-1-afd@ti.com>
From:   Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <4d45ed64-c3f5-4074-d95a-dd52f355a22b@ti.com>
Date:   Fri, 3 Jan 2020 10:16:39 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20200102211943.20480-1-afd@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/01/20 2:49 AM, Andrew F. Davis wrote:
> Hello all,
> 
> This is the reworked patch turned into a series to allow upstream kernels
> to make use of OP-TEE on the OMAP2+ platform.

FWIW:

Reviewed-by: Lokesh Vutla <lokeshvutla@ti.com>

Thanks and regards,
Lokesh

> 
> Thanks,
> Andrew
> 
> Changes from v1:
>  - Split into logical patches
>  - Check for OP-TEE in DT only once
>  - Check the OP-TEE node is "okay"
> 
> Changes from v2:
>  - Add HS patch using 'optee_available'
> 
> Changes from v3:
>  - Add comments as suggested by Tony and Lokesh
> 
> Andrew F. Davis (4):
>   ARM: OMAP2+: Add omap_secure_init callback hook for secure
>     initialization
>   ARM: OMAP2+: Introduce check for OP-TEE in omap_secure_init()
>   ARM: OMAP2+: Use ARM SMC Calling Convention when OP-TEE is available
>   ARM: OMAP2+: sleep43xx: Call secure suspend/resume handlers
> 
>  arch/arm/mach-omap2/common.h      |  2 +-
>  arch/arm/mach-omap2/io.c          | 11 +++++++
>  arch/arm/mach-omap2/omap-secure.c | 50 +++++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/omap-secure.h | 10 +++++++
>  arch/arm/mach-omap2/omap-smc.S    |  6 ++--
>  arch/arm/mach-omap2/pm33xx-core.c | 24 +++++++++++++++
>  6 files changed, 99 insertions(+), 4 deletions(-)
> 
