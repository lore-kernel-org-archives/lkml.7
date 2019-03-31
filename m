Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30EC8C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 12:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED1302086C
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 12:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="AfgGhTAL";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="e8/wTbFV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731178AbfCaMrS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 08:47:18 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35080 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726863AbfCaMrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 08:47:18 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id F05DF60E5C; Sun, 31 Mar 2019 12:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554036436;
        bh=k07YlLWrrbDMmotbcn5x1g24mgaRbWK/SBLghNfg1mg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=AfgGhTALvSfBWiEpNXYpxwISPIPUWoOt2nPNWEuDM0nM4P9TtAJPdeki6glZPkcHY
         VLUS5tSvah7VlMI6upv+GzslWFRGjS1ajUVXtTfGwMN68rLpQwVyfacCTYjF3dNNGU
         G8jihNtmHR3auP7XewnXvCoNqJT9DU7ovLgNBVYE=
Received: from [10.79.164.251] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2D78160710;
        Sun, 31 Mar 2019 12:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554036429;
        bh=k07YlLWrrbDMmotbcn5x1g24mgaRbWK/SBLghNfg1mg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=e8/wTbFVX7G5r2/ausPRxdC2J7epQESwRVoSxpF6jlZ+lO+NE4PWN1KuDJyLXNJih
         OEAgQuywxUHRwdg3POrTcfpucaans4nBywztTP9+EyfF2vhENbqP6dnS5GcZ9dGxa4
         Azo6D/emecxDUV6PPpI8RJ/8EA1wrdC0PG4CO0f4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2D78160710
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH 2/7] irqchip/alpine-msi: Update driver license to use SPDX
To:     Hanna Hawa <hhhawa@amazon.com>, tsahee@annapurnalabs.com,
        antoine.tenart@bootlin.com, linux@armlinux.org.uk,
        catalin.marinas@arm.com, will.deacon@arm.com, rjw@rjwysocki.net,
        lenb@kernel.org, tglx@linutronix.de, jason@lakedaemon.net,
        marc.zyngier@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, barakw@amazon.com,
        vaerov@amazon.com, linux-kernel@vger.kernel.org,
        hanochu@amazon.com, linux-acpi@vger.kernel.org, zeev@amazon.com,
        dwmw@amazon.co.uk, jonnyc@amazon.com, ronenk@amazon.com,
        talel@amazon.com, alisaidi@amazon.com
References: <1554035655-11352-1-git-send-email-hhhawa@amazon.com>
 <1554035655-11352-3-git-send-email-hhhawa@amazon.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <c99273a0-f85a-9fd1-84d4-d5062385a94f@codeaurora.org>
Date:   Sun, 31 Mar 2019 18:16:46 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1554035655-11352-3-git-send-email-hhhawa@amazon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/31/2019 6:04 PM, Hanna Hawa wrote:
> Update driver license to be in-line with Linux conventions.
>
> Signed-off-by: Hanna Hawa <hhhawa@amazon.com>

> ---
>   drivers/irqchip/irq-alpine-msi.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/irqchip/irq-alpine-msi.c b/drivers/irqchip/irq-alpine-msi.c
> index ae2fca7..ec6a606 100644
> --- a/drivers/irqchip/irq-alpine-msi.c
> +++ b/drivers/irqchip/irq-alpine-msi.c
> @@ -1,13 +1,10 @@
> +// SPDX-License-Identifier: GPL-2.0


Please fix this as per.
https://lkml.org/lkml/2019/2/13/570


cheers,
Mukesh

>   /*
>    * Annapurna Labs MSIX support services
>    *
>    * Copyright (C) 2016, Amazon.com, Inc. or its affiliates. All Rights Reserved.
>    *
>    * Antoine Tenart <antoine.tenart@free-electrons.com>
> - *
> - * This file is licensed under the terms of the GNU General Public
> - * License version 2. This program is licensed "as is" without any
> - * warranty of any kind, whether express or implied.
>    */
>   
>   #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
