Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5215DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 15:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EA612082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 15:21:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SotSgxxx";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fDhIqDvG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730308AbfC0PVs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 11:21:48 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52958 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbfC0PVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 11:21:48 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1C8F760E5F; Wed, 27 Mar 2019 15:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553700107;
        bh=z1XUl/YdfWKaCAXCm3cz33sIg+cRppa0sg3nfQNOcQY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=SotSgxxxnZeMsWcYKCRnuwGkKErP/GfALhVkhPR+zERqRyJ4KoaS9k8dBS3snIv2D
         MOeXnk6QCUizrOnedNuHUrtZ2g7Bi85STIaLGWkjzy1dGjxHqWabEWGH30FGqDcAgH
         MRkWMXV1R7AKLTUfAwmTM+l3MDqINRm8edvFNAZc=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1A50C61196;
        Wed, 27 Mar 2019 15:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553700096;
        bh=z1XUl/YdfWKaCAXCm3cz33sIg+cRppa0sg3nfQNOcQY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=fDhIqDvGExy3bmYQXKxv88YZgRXvNphOkdTPHK75A4aprWn4vqAueoi3J4/k7P8vR
         DVkVoCAKTDJvepng6w9N1bmoJGlUl3F5lq83NZU9YGj9+mIahOfkz867NCm15HZRhh
         xSI6GD1YG+Ifu86ln8mcIb9FF1FkHNgzZ2SY7XA8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1A50C61196
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] arm:mach-sa1100/hackkit.c : Remove duplicate header
To:     jagdsh.linux@gmail.com, linux@armlinux.org.uk, paul.burton@mips.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1553713896-25575-1-git-send-email-jagdsh.linux@gmail.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <9be00769-8d41-1cbe-cce0-d7b740f5e346@codeaurora.org>
Date:   Wed, 27 Mar 2019 20:51:32 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <1553713896-25575-1-git-send-email-jagdsh.linux@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/28/2019 12:41 AM, jagdsh.linux@gmail.com wrote:
> From: Jagadeesh Pagadala <jagdsh.linux@gmail.com>
>
> Remove duplicate header which is included twice.
>
> Signed-off-by: Jagadeesh Pagadala <jagdsh.linux@gmail.com>


Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

-Mukesh

> ---
>   arch/arm/mach-sa1100/hackkit.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/arch/arm/mach-sa1100/hackkit.c b/arch/arm/mach-sa1100/hackkit.c
> index 643d5f2..0016d25 100644
> --- a/arch/arm/mach-sa1100/hackkit.c
> +++ b/arch/arm/mach-sa1100/hackkit.c
> @@ -22,7 +22,6 @@
>   #include <linux/serial_core.h>
>   #include <linux/mtd/mtd.h>
>   #include <linux/mtd/partitions.h>
> -#include <linux/tty.h>
>   #include <linux/gpio.h>
>   #include <linux/leds.h>
>   #include <linux/platform_device.h>
