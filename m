Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA6DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 05:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 243F720811
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 05:59:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="WIBQoi0c";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="R0clnImt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbfC2F7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 01:59:42 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37058 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbfC2F7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 01:59:42 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id CEFFD609CD; Fri, 29 Mar 2019 05:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553839180;
        bh=6Rk+lU0uV/d5zh3fmSuyxykQhEZcjSDqHgUAiDYW83U=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=WIBQoi0cw4NdABBTDL1bN2V7ei6Lxp8BaFtdPF0zONd9+cVFdz2E9FmYKqce4bkp2
         GSZ/54U3NkMwzmmnyNRZkpwNl7PuDjcQQRKFo2sL4hYfRX/eYfQ5DtYyAqsZvX4UhX
         pcq5Pl8tn7vre/a55brEKD8NT4MDfjd2EV1fAbEg=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1572C607C6;
        Fri, 29 Mar 2019 05:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553839179;
        bh=6Rk+lU0uV/d5zh3fmSuyxykQhEZcjSDqHgUAiDYW83U=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=R0clnImtVSnC8cg16lV/sdhbxQU5nQ2pZNUyvKWSJ4tEoo8qXLKtmwGqB+f2hN/Fn
         VkCjlD0mzRT9MHuLVrRZUQGNXaSrL5f1VSkBJWAIrP286g+ONuOkpIMsYFdQ/rFIGb
         vhYiHU0Dg6XbaSLNW0dcWrz5evSOX6tcseTBo4U8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1572C607C6
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH 1/2] kernel.h: use parentheses around argument in
 u64_to_user_ptr()
To:     Jann Horn <jannh@google.com>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Signed-off-by : Qiaowei Ren" <qiaowei.ren@intel.com>
References: <20190328212321.92463-1-jannh@google.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <2d62a025-26f6-0129-98b6-9cc4877afff7@codeaurora.org>
Date:   Fri, 29 Mar 2019 11:29:26 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190328212321.92463-1-jannh@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/29/2019 2:53 AM, Jann Horn wrote:
> Use parentheses around uses of the argument in u64_to_user_ptr() to ensure
> that the cast doesn't apply to part of the argument.
>
> There are existing uses of the macro of the form `u64_to_user_ptr(A + B)`,
> which expands to `(void __user *)(uintptr_t)A + B` (the cast applies to the
> first operand of the addition, the addition is a pointer addition). This
> happens to still work as intended, the semantic difference doesn't cause a
> difference in behavior.
> But I want to use u64_to_user_ptr() with a ternary operator in the
> argument, like so: `u64_to_user_ptr(A ? B : C)`. This currently doesn't
> work as intended.
>
> Fixes: f09174c501f8 ("x86: add user_atomic_cmpxchg_inatomic at uaccess.h")
> Signed-off-by: Jann Horn <jannh@google.com>


Looks good to me.
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

-Mukesh

> ---
> Can we take this patch through the x86 tree with the following one, or
> do we need to get this one through akpm's tree first?
>
>   include/linux/kernel.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index 34a5036debd3..2d14e21c16c0 100644
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -47,8 +47,8 @@
>   
>   #define u64_to_user_ptr(x) (		\
>   {					\
> -	typecheck(u64, x);		\
> -	(void __user *)(uintptr_t)x;	\
> +	typecheck(u64, (x));		\
> +	(void __user *)(uintptr_t)(x);	\
>   }					\
>   )
>   
