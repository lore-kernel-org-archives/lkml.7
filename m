Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A75C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 16:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5C5A20679
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 16:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="KjlVZXJe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731975AbfFTQDO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 12:03:14 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:17483 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbfFTQDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 12:03:13 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d0bae400001>; Thu, 20 Jun 2019 09:03:12 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 20 Jun 2019 09:03:13 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 20 Jun 2019 09:03:13 -0700
Received: from [10.21.132.143] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 20 Jun
 2019 16:03:11 +0000
Subject: Re: [PATCH] irqchip/gic-pm: remove PM_CLK dependency
To:     Sameer Pujar <spujar@nvidia.com>, <thierry.reding@gmail.com>,
        <marc.zyngier@arm.com>, <jason@lakedaemon.net>,
        <tglx@linutronix.de>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1561046268-16329-1-git-send-email-spujar@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <e96e6d33-697c-8997-1049-e9011ea6b6be@nvidia.com>
Date:   Thu, 20 Jun 2019 17:03:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1561046268-16329-1-git-send-email-spujar@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1561046592; bh=oNZv6FgR4uMOZ8dIQM+iG/Av2bKfypurQ0IubDusyKE=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=KjlVZXJeXsopCflcrI8/kAqOvjv0+tulWNk8um4GktECbRgXSj0Ks2LZTrlZMPzdj
         Z4wdpLlUo3NozbKbJa0qCUrFzU9phEn20P/KzUmppMejgqFdZxu7scbJ9qRn5N+jbO
         n9ajL+4htXtyBg6Dvc3fPAKAc11B18Kdy3k41zl9CW8TNUk2QRZ9k05EWNnyxwn6th
         6C18AtuUcOVzUqt24lk8MQAEzwOEfu+kHTNp8YZqSiXXRmP3Ia2N7/dN2XDh/YB4Dp
         nFSOpjX3yRwmc+pCaiwqE/sQWnLFMCjR/Ms+64C8f0fRak8+r+yKhUjkgAmJoiXZlz
         XGBfZm2tIWM1A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 20/06/2019 16:57, Sameer Pujar wrote:
> gic-pm driver does not use pm-clk interface now and hence the dependency
> is removed from Kconfig.
> 
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> ---
>  drivers/irqchip/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> index 2d3b5a2..6346d6f 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -15,7 +15,6 @@ config ARM_GIC_PM
>  	bool
>  	depends on PM
>  	select ARM_GIC
> -	select PM_CLK
>  
>  config ARM_GIC_MAX_NR
>  	int
> 

Thanks. We should probably populate the 'Fixes:' tag for this to show
which commit this fixes. Otherwise ...

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
