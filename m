Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA2BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 06:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38B6C20811
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 06:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ImLqe2Ju";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ImLqe2Ju"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbfC1Gf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 02:35:58 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52486 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfC1Gf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 02:35:57 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B474760779; Thu, 28 Mar 2019 06:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553754956;
        bh=kVDLYTXWe3Fvr5mjs7kKiIr0Z/TvJH4wF+Nqi5RB+fQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ImLqe2JuW13tm+ZJz6q9FhinjXAsgt5pJWmF+MK2rfbCf355s7a5iELlw7H4Uzw6u
         6XGAwRv6IoHY5oOJeRY3l9oP5/UjSpaV8UoIgC49yW3wuJ3Y62DNUdBM4vkylLnHR+
         2BXfIwNRBIabGe2if0P3hxBo6ddY5y3wJTEc3o2A=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 376FC6072E;
        Thu, 28 Mar 2019 06:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553754956;
        bh=kVDLYTXWe3Fvr5mjs7kKiIr0Z/TvJH4wF+Nqi5RB+fQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ImLqe2JuW13tm+ZJz6q9FhinjXAsgt5pJWmF+MK2rfbCf355s7a5iELlw7H4Uzw6u
         6XGAwRv6IoHY5oOJeRY3l9oP5/UjSpaV8UoIgC49yW3wuJ3Y62DNUdBM4vkylLnHR+
         2BXfIwNRBIabGe2if0P3hxBo6ddY5y3wJTEc3o2A=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 376FC6072E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] arch:sparc:kernel/uprobes.c : Remove duplicate header
To:     jagdsh.linux@gmail.com, davem@davemloft.net, paul.burton@mips.com
Cc:     sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1553722125-38957-1-git-send-email-jagdsh.linux@gmail.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <636ab5b9-d0ba-d3df-3c1c-75f4b045c922@codeaurora.org>
Date:   Thu, 28 Mar 2019 12:05:51 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1553722125-38957-1-git-send-email-jagdsh.linux@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/28/2019 2:58 AM, jagdsh.linux@gmail.com wrote:
> From: Jagadeesh Pagadala <jagdsh.linux@gmail.com>
>
> Remove duplicate header which is included twice.
>
> Signed-off-by: Jagadeesh Pagadala <jagdsh.linux@gmail.com>

Looks good to me. but did you tested at least the compilation with these 
patches ?

Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

-Mukesh


> ---
>   arch/sparc/kernel/uprobes.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/arch/sparc/kernel/uprobes.c b/arch/sparc/kernel/uprobes.c
> index d852ae5..c44bf5b 100644
> --- a/arch/sparc/kernel/uprobes.c
> +++ b/arch/sparc/kernel/uprobes.c
> @@ -29,7 +29,6 @@
>   #include <linux/kdebug.h>
>   
>   #include <asm/cacheflush.h>
> -#include <linux/uaccess.h>
>   
>   /* Compute the address of the breakpoint instruction and return it.
>    *
