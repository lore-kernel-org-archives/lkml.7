Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D9E5C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 03:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98F812173C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 03:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="TKWexmbV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730683AbfHHDrj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 23:47:39 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:62265 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728245AbfHHDrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 23:47:39 -0400
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x783lMak005227
        for <linux-kernel@vger.kernel.org>; Thu, 8 Aug 2019 12:47:23 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x783lMak005227
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1565236043;
        bh=q28Bo9vCgsI+jRcEtoYoy5Wjvc2wgnXBjfB+eEtpFPI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TKWexmbVPXCT2f13W60WA25p/UVL0XwLYzHBJUqvJb5kNce3ceBWdtYDswIYeFCK4
         ZdCFnDxNQCr748cOprOvmQSWpcSfqqHiXrXp7lJHefGH+ZkegNOhrlto+rk498ZNdV
         8U/KKe9sU4STMpIRK4GRtAdwJzHnDHfAbLggwn0QTLreKo7cOi49lT2nIgYysOB8gY
         KEWgH1xN3ZZL0xMNtLtgdJgVVF2hrfVOTUoC49RjHIWRcb1xcNZAWZHH+7ugKYGFcl
         JMFEeVRIv4IPrEKcpevheT+V4gor68pPO+ZVc2ZfFNq79os7fzqApajyxmddQVE5G1
         0uePgLpuolYCQ==
X-Nifty-SrcIP: [209.85.222.50]
Received: by mail-ua1-f50.google.com with SMTP id 34so35896668uar.8
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 20:47:23 -0700 (PDT)
X-Gm-Message-State: APjAAAVvewNnKl9zrtlAKufEcunYlrX9kyYN6T7LDto3eyizMwK5a2UB
        xsuBq1BWcg+Es72ihgsVmNo47EiH4FcMBG7/A28=
X-Google-Smtp-Source: APXvYqzrcNodRysuZRxPFETEc1KCl0M3ijFunxjJQaas/A+Ey4jJuYQmZAeC6yzBKY6FDFbBUXBYNemB+QUECsZQzPM=
X-Received: by 2002:a9f:2265:: with SMTP id 92mr8205475uad.121.1565236042287;
 Wed, 07 Aug 2019 20:47:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190731190309.19909-1-rikard.falkeborn@gmail.com> <20190801230358.4193-1-rikard.falkeborn@gmail.com>
In-Reply-To: <20190801230358.4193-1-rikard.falkeborn@gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 8 Aug 2019 12:46:45 +0900
X-Gmail-Original-Message-ID: <CAK7LNASA1CszgXAvH78qnLOr11Po97s090rGujnNQ=zTHaSDDA@mail.gmail.com>
Message-ID: <CAK7LNASA1CszgXAvH78qnLOr11Po97s090rGujnNQ=zTHaSDDA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] linux/bits.h: Clarify macro argument names
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Joe Perches <joe@perches.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 2, 2019 at 8:04 AM Rikard Falkeborn
<rikard.falkeborn@gmail.com> wrote:
>
> Be a little more verbose to improve readability.
>
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>

BTW, I do not understand what the improvement is.
I tend to regard this as a noise commit.


> ---
> Changes in v2:
>   - This patch is new in v2
>
>  include/linux/bits.h | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/include/linux/bits.h b/include/linux/bits.h
> index 669d69441a62..d4466aa42a9c 100644
> --- a/include/linux/bits.h
> +++ b/include/linux/bits.h
> @@ -14,16 +14,16 @@
>  #define BITS_PER_BYTE          8
>
>  /*
> - * Create a contiguous bitmask starting at bit position @l and ending at
> - * position @h. For example
> + * Create a contiguous bitmask starting at bit position @low and ending at
> + * position @high. For example
>   * GENMASK_ULL(39, 21) gives us the 64bit vector 0x000000ffffe00000.
>   */
> -#define GENMASK(h, l) \
> -       (((~UL(0)) - (UL(1) << (l)) + 1) & \
> -        (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
> +#define GENMASK(high, low) \
> +       (((~UL(0)) - (UL(1) << (low)) + 1) & \
> +        (~UL(0) >> (BITS_PER_LONG - 1 - (high))))
>
> -#define GENMASK_ULL(h, l) \
> -       (((~ULL(0)) - (ULL(1) << (l)) + 1) & \
> -        (~ULL(0) >> (BITS_PER_LONG_LONG - 1 - (h))))
> +#define GENMASK_ULL(high, low) \
> +       (((~ULL(0)) - (ULL(1) << (low)) + 1) & \
> +        (~ULL(0) >> (BITS_PER_LONG_LONG - 1 - (high))))
>
>  #endif /* __LINUX_BITS_H */
> --
> 2.22.0
>


-- 
Best Regards
Masahiro Yamada
