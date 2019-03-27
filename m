Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C98C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 12:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11D682087C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 12:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DVMFSJBV";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cabff1F5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbfC0MKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 08:10:06 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34706 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728130AbfC0MKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 08:10:06 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9271460A44; Wed, 27 Mar 2019 12:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553688605;
        bh=vCgm2ltOG4VsipYUubYSD9mUgVSHzO+NevXUcGqvJl4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=DVMFSJBVSZ4rNyitSFmF6K0dIwOPpAMR67UJdA/j7XX86MbSKLUEH6OiPbM19usIK
         Fq0Q/0LX81P7IPQZm1GSE6g1mRllOtl5sxDQJNjbZPA9+z9qGm2Xcah+izufLJbOqp
         nrlS0pTahe8tbU1GZooIwue46mgChp56+WCGWZA8=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8E12760A44;
        Wed, 27 Mar 2019 12:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553688604;
        bh=vCgm2ltOG4VsipYUubYSD9mUgVSHzO+NevXUcGqvJl4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=cabff1F5ARImtfN7dV6ojIUU1hYpf81IFX+C80Ib5Zw6tACWalFJb7PnOhZRURupk
         TlwbsUV1ZquSy8sHH9Ongo9Oq6OU7tlFfGz6VPc5wu5NTfDvi80T5ETWKoRNKl2BkX
         eW9q5uMKX3ZvegRGiIWTmD/y0ryV1TvXqUU9ASRA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8E12760A44
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] sh:mach-dreamcast/irq.c : Remove duplicate header
To:     jagdsh.linux@gmail.com, ysato@users.sourceforge.jp,
        dalias@libc.org, akpm@linux-foundation.org,
        horms+renesas@verge.net.au, kuninori.morimoto.gx@renesas.com
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1553288536-14470-1-git-send-email-jagdsh.linux@gmail.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <91dc8844-f660-b3e6-a38e-94abc1a5b4db@codeaurora.org>
Date:   Wed, 27 Mar 2019 17:39:57 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <1553288536-14470-1-git-send-email-jagdsh.linux@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/23/2019 2:32 AM, jagdsh.linux@gmail.com wrote:
> From: Jagadeesh Pagadala <jagdsh.linux@gmail.com>
>
> Remove duplicate header which is included twice.
>
> Signed-off-by: Jagadeesh Pagadala <jagdsh.linux@gmail.com>

Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>


> ---
>   arch/sh/boards/mach-dreamcast/irq.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/arch/sh/boards/mach-dreamcast/irq.c b/arch/sh/boards/mach-dreamcast/irq.c
> index a929f76..cc06e4c 100644
> --- a/arch/sh/boards/mach-dreamcast/irq.c
> +++ b/arch/sh/boards/mach-dreamcast/irq.c
> @@ -10,7 +10,6 @@
>    */
>   #include <linux/irq.h>
>   #include <linux/io.h>
> -#include <linux/irq.h>
>   #include <linux/export.h>
>   #include <linux/err.h>
>   #include <mach/sysasic.h>
