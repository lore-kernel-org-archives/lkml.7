Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35237C74A41
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 03:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0898C2084B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 03:12:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="McsBnG9z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbfGKDMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 23:12:37 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:28631 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbfGKDMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 23:12:36 -0400
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x6B3COO8015344
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 12:12:25 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x6B3COO8015344
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1562814745;
        bh=bYunx1kcIHZGck01o8geflbRxYXWHGYyK1ZznzJtm3M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=McsBnG9zkvnvz6bIAkfQ7sdBJ6uFXW+YzdiRoIXWzsCCUR5Kl3WaPni0Rd0eFO1mJ
         ZC+0Aw+c12ltg0ms5mY2YZROAexakwSITPinhTOgU964B7EhEiWrVQVowJH5po39W7
         Vk8pej9OfTfm4HkjKZxt0ZyaN7CJ2ujtUj1J4YoIhCV3LmJNRCkW6Rmh/oGzX09EBL
         J/x4LsA4gX/L5vnalMoE4C+/ejcM6jxHkuUStBKP/pGCZ6J1ZSgkHlqiIk+g5PqQAL
         u4wC5ev4Sof5T5P/Af76As4yegA8WNnfO343zzB3rd37VIOLA5Wtk24GaMmgNWSnPQ
         tANC2510pB2bQ==
X-Nifty-SrcIP: [209.85.222.43]
Received: by mail-ua1-f43.google.com with SMTP id c4so1754739uad.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 20:12:25 -0700 (PDT)
X-Gm-Message-State: APjAAAURkqceLQCWfVoe7RGpLLDKIFgP/obFrCjJvyh0MKbIw6GxCqv/
        v9ylGNGyOQXnymmFA98Pie497rVSyM+XpOR6Cd8=
X-Google-Smtp-Source: APXvYqwiLJ4hWuVL8sVPnorgY996BnkP1X/FMoK33NSeF4ex50i5Xh7WDVQXRMt31mL2wW/6aQKJG7l29s2ddfgsDhQ=
X-Received: by 2002:ab0:5ea6:: with SMTP id y38mr840230uag.40.1562814744318;
 Wed, 10 Jul 2019 20:12:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190711030713.4447-1-yamada.masahiro@socionext.com>
In-Reply-To: <20190711030713.4447-1-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 11 Jul 2019 12:11:48 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQZ3zyLV_6CfkhOFUDJm1mwUoq+xoOXUWCzu1HL7HK7bA@mail.gmail.com>
Message-ID: <CAK7LNAQZ3zyLV_6CfkhOFUDJm1mwUoq+xoOXUWCzu1HL7HK7bA@mail.gmail.com>
Subject: Re: [PATCH] ARM: fix O= building with CONFIG_FPE_FASTFPE
To:     arm-soc <arm@kernel.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd, Olof,

Please ignore this.

I wanted to put this patch into Russell's patch tracker,
but just sent it to a wrong ML.


Masahiro Yamada

On Thu, Jul 11, 2019 at 12:08 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> To use Fastfpe, a user is supposed to enable CONFIG_FPE_FASTFPE
> and put downstream source files into arch/arm/fastfpe/.
>
> It is not working for O= build because $(wildcard arch/arm/fastfpe)
> checks if it exists in $(objtree), not in $(srctree).
>
> Add the $(srctree)/ prefix to fix it.
>
> While I was here, I slightly refactored the code.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
> KernelVersion: 5.2
>
>  arch/arm/Makefile | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index f863c6935d0e..792f7fa16a24 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -271,14 +271,9 @@ endif
>
>  export TEXT_OFFSET GZFLAGS MMUEXT
>
> -# Do we have FASTFPE?
> -FASTFPE                :=arch/arm/fastfpe
> -ifeq ($(FASTFPE),$(wildcard $(FASTFPE)))
> -FASTFPE_OBJ    :=$(FASTFPE)/
> -endif
> -
>  core-$(CONFIG_FPE_NWFPE)       += arch/arm/nwfpe/
> -core-$(CONFIG_FPE_FASTFPE)     += $(FASTFPE_OBJ)
> +# Put arch/arm/fastfpe/ to use this.
> +core-$(CONFIG_FPE_FASTFPE)     += $(patsubst $(srctree)/%,%,$(wildcard $(srctree)/arch/arm/fastfpe/))
>  core-$(CONFIG_VFP)             += arch/arm/vfp/
>  core-$(CONFIG_XEN)             += arch/arm/xen/
>  core-$(CONFIG_KVM_ARM_HOST)    += arch/arm/kvm/
> --
> 2.17.1
>


-- 
Best Regards
Masahiro Yamada
