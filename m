Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47640C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 16:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14A2B20675
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 16:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="HgcQru7Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbfCFQDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 11:03:01 -0500
Received: from conssluserg-04.nifty.com ([210.131.2.83]:53931 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726945AbfCFQDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 11:03:00 -0500
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x26G2Zvf025270;
        Thu, 7 Mar 2019 01:02:36 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x26G2Zvf025270
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1551888156;
        bh=ZHtvOZZeNFMSU/z4AjSUUdYaQwQC9fBxIznHwNNaLKk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HgcQru7QmU6UzKYttmYn07io/J1mcEqqZvfbWvklkuBF5cLcW8+zTDpYAoCxQyRPS
         CqaqFpKIPUFs4jSLf+is7K/R7+rx869H4RRqoQYxw/f+cbDbzWqoR7earDJfe6CZj1
         aM/POY6olFkqtkeEpNJAeTppoT8v1VgPl5Iv8/Jz3FR1o6b3M0Ok7+5g8UJRqXUwRS
         LWV3pEv1gBgRWtuDZGG/+oim+AyX4e5nrDQmi7dg6aWFIjVqPja5y5ruTK3XPqu+93
         bQmYEdB0tU8AisWK8n1ZWhA5bY6SmYiqJGzD5CjZfyz6y12N2Idye9SgklxSVff0r/
         nYeoS7Sl07ZaQ==
X-Nifty-SrcIP: [209.85.222.46]
Received: by mail-ua1-f46.google.com with SMTP id s15so9117828uap.6;
        Wed, 06 Mar 2019 08:02:36 -0800 (PST)
X-Gm-Message-State: APjAAAU0WUUyld+k0J/5GdfZGvQmR3FlOKCnEcw2BqekoYFXoaEEbFa5
        yZRYvd6CfKzLXqvVtQbNnvBEjEyHhF7WWiU+Jnk=
X-Google-Smtp-Source: APXvYqzzj6ikTG1vQl5mQWuR0HZ3rpa4yA5Y+O3YVc4QmnhxxYPTKqxXLpKIpdDptoKhHELmt4w/xDV0KR21lDdu8VM=
X-Received: by 2002:ab0:648c:: with SMTP id p12mr4313757uam.93.1551888154846;
 Wed, 06 Mar 2019 08:02:34 -0800 (PST)
MIME-Version: 1.0
References: <20190304125520.17794-1-luc.vanoostenryck@gmail.com>
In-Reply-To: <20190304125520.17794-1-luc.vanoostenryck@gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 7 Mar 2019 01:01:58 +0900
X-Gmail-Original-Message-ID: <CAK7LNARMjdi5PxJ=RD19LKd_DrRpn-TXmy-9mZZcgNiU=hzizQ@mail.gmail.com>
Message-ID: <CAK7LNARMjdi5PxJ=RD19LKd_DrRpn-TXmy-9mZZcgNiU=hzizQ@mail.gmail.com>
Subject: Re: [PATCH] kbuild: use -Werror=implicit-... instead of -Werror-implicit-...
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 4, 2019 at 9:55 PM Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> The flag '-Werror-implicit-function-declaration', present in GCC 2.95,
> stopped to be documented in GCC 4.3, replaced by the more generic
> '-Werror=...' form.
>
> So, use the equivalent '-Werror=implicit-function-declaration' instead.
>
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---

Applied to linux-kbuild.
Thanks.



>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index d5713e7b1e50..253e5ede92e7 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -429,7 +429,7 @@ LINUXINCLUDE    := \
>  KBUILD_AFLAGS   := -D__ASSEMBLY__ -fno-PIE
>  KBUILD_CFLAGS   := -Wall -Wundef -Werror=strict-prototypes -Wno-trigraphs \
>                    -fno-strict-aliasing -fno-common -fshort-wchar -fno-PIE \
> -                  -Werror-implicit-function-declaration -Werror=implicit-int \
> +                  -Werror=implicit-function-declaration -Werror=implicit-int \
>                    -Wno-format-security \
>                    -std=gnu89
>  KBUILD_CPPFLAGS := -D__KERNEL__
> --
> 2.21.0
>


-- 
Best Regards
Masahiro Yamada
