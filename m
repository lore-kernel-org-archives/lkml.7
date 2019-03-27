Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E23AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BB812075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="OgcHDHOP";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VgcX+Pgl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729294AbfC0NtO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 09:49:14 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52450 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbfC0NtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 09:49:14 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5BB63611FD; Wed, 27 Mar 2019 13:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553694553;
        bh=wAuJ3LPdzgl6/dp3KcjfKJdKTj8TuLJ+3k4QrBM30H4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=OgcHDHOPU4S4KOL2DkJmcX7SKJLYDyNTr4l0O7VZ5/LDLiUIe/yZOsEj6ZxglmCgG
         aiI7mXJQo7wRttPcDPC1ZaydVaN1+y8ZMu11uLZG9rWLezEOljJlli3jMbWgyHaE44
         ckJhg80QULBcgCAYs0PW3duwOWDvrM/GWbuMJT1Y=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 777B560A44;
        Wed, 27 Mar 2019 13:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553694552;
        bh=wAuJ3LPdzgl6/dp3KcjfKJdKTj8TuLJ+3k4QrBM30H4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=VgcX+Pglgtaq1R/bzPeg8VM3K2actKfX3BuS3MiF5eG+TomOCqAOOsf4u3jo+mVr4
         EBdiAzA+NMcUFWMDSZhGGVtVXMdkAQ+CmiJVCqsLgnvYJ/OueVW0ilSEXpHtE8Ejah
         lIIFUunDvLaZbYugQ89iasq6JzPqoufSDEt5pxVs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 777B560A44
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] MAINTAINERS: fix the file path of uniphier-mdmac.c
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jiri Kosina <trivial@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>
References: <1553566409-23873-1-git-send-email-yamada.masahiro@socionext.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <e815db05-96ce-74d3-414d-f4e817c2f7b1@codeaurora.org>
Date:   Wed, 27 Mar 2019 19:19:03 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <1553566409-23873-1-git-send-email-yamada.masahiro@socionext.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/26/2019 7:43 AM, Masahiro Yamada wrote:
> The pattern drivers/dmaengine/uniphier-mdmac.c has no match in the
> source tree.
>
> The correct path is drivers/dma/uniphier-mdmac.c
>
> Reported-by: Joe Perches <joe@perches.com>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>


Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

-Mukesh

> ---
>
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3e5a5d2..bfb1557 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2356,7 +2356,7 @@ F:	arch/arm/mm/cache-uniphier.c
>   F:	arch/arm64/boot/dts/socionext/uniphier*
>   F:	drivers/bus/uniphier-system-bus.c
>   F:	drivers/clk/uniphier/
> -F:	drivers/dmaengine/uniphier-mdmac.c
> +F:	drivers/dma/uniphier-mdmac.c
>   F:	drivers/gpio/gpio-uniphier.c
>   F:	drivers/i2c/busses/i2c-uniphier*
>   F:	drivers/irqchip/irq-uniphier-aidet.c
