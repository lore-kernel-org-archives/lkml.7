Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A585CC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 09:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75747214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 09:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="GN3J2pCL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388594AbfDRJiV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 05:38:21 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:33632 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388573AbfDRJiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 05:38:19 -0400
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id x3I9cG2n026629
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 18:38:16 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x3I9cG2n026629
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1555580296;
        bh=GTFLr/yv4m+misXeTbfQQWewW4rVKkItbUyqCNH3DD8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GN3J2pCL9vP0LdciLxrK+tWNydS6LKYpon1/ERVV4U0Cm41vJuum/wno8gfG72iac
         TEPJrmoMggLWjHfKMzaLxLHTbyhuyW6KSENG+KnCHxX7Z1kbyIo66YnLvATpDCXbNh
         W6tiBhEUIpCaqIZRZACFttoVN7DpJYHiFMAgtVxbliV7bzxTdJTwR5gsNadCXYHLKX
         +22cUAsck8u2X03VGcExzAiSEsUzPwO5oRjcG4MOLURYvlTVAWeU6HKHFXvDgEAJlA
         0efEFnu7qkIO5BEQB5ZzghL8xy5v9ASvJZLT/dmW7RdmA2quCNMv5uPrDfjQIWLzM2
         kUh5LG6tITEHQ==
X-Nifty-SrcIP: [209.85.217.45]
Received: by mail-vs1-f45.google.com with SMTP id f22so810086vso.7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 02:38:16 -0700 (PDT)
X-Gm-Message-State: APjAAAVD4Ns9tkSTWnreojWQi/UTB3UZOHoJCN32I3t55Wss2ynaj01P
        acqU8xfjoej92VxynMY0iRMSq/htENSPe10Esjc=
X-Google-Smtp-Source: APXvYqz1+cAQZKI+DL5M+6gjMAXU/G2TIudcLex9GrfdAop5+Jepp6mXRzDNRQ+GQ7sid+DC7nXSpVuxZBq85jpy+uo=
X-Received: by 2002:a67:7a43:: with SMTP id v64mr49140580vsc.54.1555580295546;
 Thu, 18 Apr 2019 02:38:15 -0700 (PDT)
MIME-Version: 1.0
References: <1554280545-11318-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1554280545-11318-1-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 18 Apr 2019 18:37:39 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR6B=O3h3ec6hm-+O=Y+-ZAj97qQoF4kUfw8Z-NU+5NDQ@mail.gmail.com>
Message-ID: <CAK7LNAR6B=O3h3ec6hm-+O=Y+-ZAj97qQoF4kUfw8Z-NU+5NDQ@mail.gmail.com>
Subject: Re: [PATCH] nds32: add vmlinux.lds and vdso.so to .gitignore
To:     Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greentime,

On Wed, Apr 3, 2019 at 5:39 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> These are build artifacts, which should be ignored by git.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Ping ?

>
>  arch/nds32/kernel/.gitignore      | 1 +
>  arch/nds32/kernel/vdso/.gitignore | 1 +
>  2 files changed, 2 insertions(+)
>  create mode 100644 arch/nds32/kernel/.gitignore
>  create mode 100644 arch/nds32/kernel/vdso/.gitignore
>
> diff --git a/arch/nds32/kernel/.gitignore b/arch/nds32/kernel/.gitignore
> new file mode 100644
> index 0000000..c5f676c
> --- /dev/null
> +++ b/arch/nds32/kernel/.gitignore
> @@ -0,0 +1 @@
> +vmlinux.lds
> diff --git a/arch/nds32/kernel/vdso/.gitignore b/arch/nds32/kernel/vdso/.gitignore
> new file mode 100644
> index 0000000..f8b69d8
> --- /dev/null
> +++ b/arch/nds32/kernel/vdso/.gitignore
> @@ -0,0 +1 @@
> +vdso.lds
> --
> 2.7.4
>


-- 
Best Regards
Masahiro Yamada
