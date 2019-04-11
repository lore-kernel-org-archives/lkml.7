Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3334EC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 22:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF1A12084D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 22:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555020262;
	bh=Baud+mROE27sGxu+HnEvlJOosHX081fISOF2ddZpslM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=FKTNuOfpgJTREkbRyGr8703uUV/b+23tCqIOJEUUK4VFIEhAUSVesXjIQOgLFMbm/
	 b/PsURY1cWIvuoRbOQSl1gnwN8CTredeNx5dJf3wJRrrSsMXIQwCj1YcwgzEbTuJ3r
	 0ViRhUkzNYL8GmUluVPt/o9ZY/Gv5LjLHUlKYwNw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbfDKWEU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 18:04:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:53666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726661AbfDKWET (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 18:04:19 -0400
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A33C20818;
        Thu, 11 Apr 2019 22:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555020258;
        bh=Baud+mROE27sGxu+HnEvlJOosHX081fISOF2ddZpslM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wNoXV5xByIyJGn+mzlR49Z+lvyOiP1rNQMcQV2DBVmjyonAzAw57mjYrX9/vF9MLn
         MH6lV38szOztU9vMwZ/hsDgTq6OABHoRWJeKatGI6sJirU/zQKBJ+rIf2BQndRLw9c
         1EOE0F8fuCD0c/Iiorz1ua65HbmPuIVm7R+TyMb4=
Received: by mail-wm1-f43.google.com with SMTP id c1so8635526wml.4;
        Thu, 11 Apr 2019 15:04:18 -0700 (PDT)
X-Gm-Message-State: APjAAAX10zCHdmpFsRnUzWr5cwfNyb5L4Z7Po1qQfKxPkqJ1ljuAciVR
        PA2u1qYv0SgXSFOTmMAN2wVmq1svXkY/kaiSejg=
X-Google-Smtp-Source: APXvYqyhcQMrfJ1mqot+nv+F+wiK4yASimLiBVFPqIYcuSLNxEKAVXp9jIA7sOFGOAbaf+aKd3xtIwJtkKErcxsA/ZQ=
X-Received: by 2002:a1c:a010:: with SMTP id j16mr8120608wme.40.1555020257068;
 Thu, 11 Apr 2019 15:04:17 -0700 (PDT)
MIME-Version: 1.0
References: <1554975138-801-1-git-send-email-light.hsieh@mediatek.com>
In-Reply-To: <1554975138-801-1-git-send-email-light.hsieh@mediatek.com>
From:   Sean Wang <sean.wang@kernel.org>
Date:   Thu, 11 Apr 2019 15:04:05 -0700
X-Gmail-Original-Message-ID: <CAGp9LzpExWGCHtiggQmPtCwBD6o4JUmGSGfm7VostCq+EK2egw@mail.gmail.com>
Message-ID: <CAGp9LzpExWGCHtiggQmPtCwBD6o4JUmGSGfm7VostCq+EK2egw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: Add kernel config PINCTRL_MTK_V2
To:     Light Hsieh <light.hsieh@mediatek.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, wsd_upstream@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Light

On Thu, Apr 11, 2019 at 2:32 AM Light Hsieh <light.hsieh@mediatek.com> wrote:
>
> Since no single Mediatek chip use code for PINCTRL_MTK and code for
> PINCTRL_MTK_MOORE/PINCTRL_MTK_PARIS simultaneously, it is better to use
> different config to determine if related code will be built or not on
> building non-generic kernel.
>
> Add kernel config PINCTRL_MTK_V2 selected by either PINCTRL_MTK_MOORE
> or PINCTRL_MTK_PARIS.
> Use PINCTRL_MTK and PINCTRL_MTK_V2 to control building of
> drivers/pinctrl/medaitek/.
> Remove selection of EINT_MTK from PINCTRL_MTK since code for EINT_MTK is
> only related to PINCTRL_MTK_MOORE/PINCTRL_MTK_PARIS, i.e. PINCTL_MTK_V2.
>

PINCTRL_MTK also depends on EINT_MTK such as the symbol
mtk_eint_do_init, it is a common library for the two kinds of the
pinctrl core.

> ---
>  drivers/pinctrl/Makefile         |  3 ++-
>  drivers/pinctrl/mediatek/Kconfig | 15 ++++++++++++---
>  2 files changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
> index 712184b..fcee0e0 100644
> --- a/drivers/pinctrl/Makefile
> +++ b/drivers/pinctrl/Makefile
> @@ -65,6 +65,7 @@ obj-$(CONFIG_PINCTRL_SUNXI)   += sunxi/
>  obj-y                          += ti/
>  obj-$(CONFIG_PINCTRL_UNIPHIER) += uniphier/
>  obj-$(CONFIG_ARCH_VT8500)      += vt8500/
> -obj-y                          += mediatek/
> +obj-$(CONFIG_PINCTRL_MTK)      += mediatek/
> +obj-$(CONFIG_PINCTRL_MTK_V2)   += mediatek/

I would think it is good if deciding V1 or not should be done inside
the vendor directory and the change also would cause COMPILE_TEST not
be applied to

>  obj-$(CONFIG_PINCTRL_ZX)       += zte/
>  obj-y                          += cirrus/
> diff --git a/drivers/pinctrl/mediatek/Kconfig b/drivers/pinctrl/mediatek/Kconfig
> index a005cbc..5e26462 100644
> --- a/drivers/pinctrl/mediatek/Kconfig
> +++ b/drivers/pinctrl/mediatek/Kconfig
> @@ -2,10 +2,15 @@ menu "MediaTek pinctrl drivers"
>         depends on ARCH_MEDIATEK || COMPILE_TEST
>
>  config EINT_MTK
> -       bool "MediaTek External Interrupt Support"
> -       depends on PINCTRL_MTK || PINCTRL_MTK_MOORE || PINCTRL_MTK_PARIS || COMPILE_TEST
> +       bool "MediaTek External Interrupt driver that is based on PINCTRL_MTK_V2"
> +       depends on PINCTRL_MTK_MOORE || PINCTRL_MTK_PARIS || COMPILE_TEST
>         select GPIOLIB
>         select IRQ_DOMAIN
> +       help
> +         Say yes here to enable support for MediaTek External Interrupt
> +         (EINT) driver based on PINCTRL_MTK version 2.
> +         This driver is combined with MediaTek Pinctrl driver version 2
> +         so PINCTRL_MTK_V2 shall be set first.
>
>  config PINCTRL_MTK
>         bool
> @@ -13,9 +18,11 @@ config PINCTRL_MTK
>         select PINMUX
>         select GENERIC_PINCONF
>         select GPIOLIB
> -       select EINT_MTK
>         select OF_GPIO
>
> +config PINCTRL_MTK_V2
> +       bool "MediaTek Pinctrl Support V2"
> +
>  config PINCTRL_MTK_MOORE
>         bool
>         depends on OF
> @@ -24,6 +31,7 @@ config PINCTRL_MTK_MOORE
>         select GENERIC_PINMUX_FUNCTIONS
>         select GPIOLIB
>         select OF_GPIO
> +       select PINCTRL_MTK_V2
>
>  config PINCTRL_MTK_PARIS
>         bool
> @@ -33,6 +41,7 @@ config PINCTRL_MTK_PARIS
>         select GPIOLIB
>         select EINT_MTK
>         select OF_GPIO
> +       select PINCTRL_MTK_V2
>
>  # For ARMv7 SoCs
>  config PINCTRL_MT2701
> --
> 1.8.1.1.dirty
>
