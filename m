Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3522C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4843F2184A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="LJPhTa9O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732377AbfB1Ojr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 09:39:47 -0500
Received: from conssluserg-01.nifty.com ([210.131.2.80]:53982 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730388AbfB1Ojr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 09:39:47 -0500
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id x1SEdhIG014817
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 23:39:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x1SEdhIG014817
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1551364784;
        bh=vqBEZCQiWIroU1NjDU7+o8Bhv78NU69t71qRenVlVJs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LJPhTa9O6GdsRgzeuuSy93W1kaBkSFQil05DpjpcrAh2n/ZAliAfhKTXxuUOzfIFX
         6Zv1oivqSramjbkFlCxn++cpbXYjPm6IuUTDA3roO4oizddSQb3gfDp60RM6PPcavV
         JZWQo3P9U9Z/0Q3DXoKnqWpZfZVe3TZLONOwidqGMLZVhp2SX5o1eLLTi/UrxeHGOS
         JmZ+/tjx9XEpmi+Xr4FqrKdKoaNhceC9rkuXj2+pC6CPM7SwnPgBG7cuwzwR5tNAhP
         MTSdJC//udTFdYXvCbZhcsKq1LJzOw7UXZ814vo+ShPEtbLtdROZcUGbkZn0LCA0Mm
         yWnb3cysmfCoA==
X-Nifty-SrcIP: [209.85.222.46]
Received: by mail-ua1-f46.google.com with SMTP id g1so8199499uae.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 06:39:43 -0800 (PST)
X-Gm-Message-State: AHQUAuYlrFgA40f4Ctn2b87ykrtj9T4x63VVBA35LiIPZ3ym3BiXxbBn
        VTH9MPkxkgvXfPeOvrD731ekItRnSS/6pp8jV2k=
X-Google-Smtp-Source: AHgI3IYfhj+lxZyJq+HxHZQv2W6amH4JTnvaZyfApEsMWIAiS/4gZe+yzDp7yRLfE37ddrNzhErQ4D7eWOK6D43Z0fs=
X-Received: by 2002:a9f:314d:: with SMTP id n13mr5368163uab.6.1551364782745;
 Thu, 28 Feb 2019 06:39:42 -0800 (PST)
MIME-Version: 1.0
References: <1551354739-6648-1-git-send-email-wdjjwb@163.com>
In-Reply-To: <1551354739-6648-1-git-send-email-wdjjwb@163.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 28 Feb 2019 23:39:06 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQbQz=QjBrY5QgAS9iHT_Cmi=Kr9H22UMwnyOeTrDDnsg@mail.gmail.com>
Message-ID: <CAK7LNAQbQz=QjBrY5QgAS9iHT_Cmi=Kr9H22UMwnyOeTrDDnsg@mail.gmail.com>
Subject: Re: [PATCH] include/linux/types.h: use "unsigned int" instead of "unsigned"
To:     WangBo <wdjjwb@163.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>, wang.bo116@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 9:21 PM WangBo <wdjjwb@163.com> wrote:
>
> Use "unsigned int" instead of  "unsigned" ,it make code more clear.
>
> Signed-off-by: WangBo <wang.bo116@zte.com.cn>

Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>



> ---
>  include/linux/types.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/types.h b/include/linux/types.h
> index c2615d6..cc0dbbe 100644
> --- a/include/linux/types.h
> +++ b/include/linux/types.h
> @@ -155,9 +155,9 @@ typedef u64 dma_addr_t;
>  typedef u32 dma_addr_t;
>  #endif
>
> -typedef unsigned __bitwise gfp_t;
> -typedef unsigned __bitwise slab_flags_t;
> -typedef unsigned __bitwise fmode_t;
> +typedef unsigned int __bitwise gfp_t;
> +typedef unsigned int __bitwise slab_flags_t;
> +typedef unsigned int __bitwise fmode_t;
>
>  #ifdef CONFIG_PHYS_ADDR_T_64BIT
>  typedef u64 phys_addr_t;
> --
> 2.7.4
>
>


-- 
Best Regards
Masahiro Yamada
