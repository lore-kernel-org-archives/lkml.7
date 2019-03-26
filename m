Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C46C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 05:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2460220856
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 05:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Ah6UMRyZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731105AbfCZFof (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 01:44:35 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:44685 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfCZFof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 01:44:35 -0400
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x2Q5iIem011046
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 14:44:18 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x2Q5iIem011046
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1553579058;
        bh=nR/eNpk9ULdct8ZbEEi5NGPcIoSRroWTW8aora24J0k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ah6UMRyZXd7bJgKh0IJahesGfi0eOFeRf7/qjpAuIb0hjHsrA+I8Uf4xdyBC5+tWk
         rEbpmKCBJlwoJdgiCBMN9aT2D57ZIcRAvsx4R3MmY5Tn1Ap847d0AiP6oNaCSB+ZZI
         AAGJOIt97KZJhPim30YiawxeRh6D/RF+BF+gDzUcbTfI6E3XLTyrAjN8t1Uov/2Imb
         ylf6SlDak8v1FYGtZi/dV83AsC7VOzPq0cN0y62N5AfDG1gnuOUXyh9HT7QsMEgKea
         PEzuByl9miSmdf9cAYG+I1aPV3yZhev6Q18TOSaxf32XMYuFX1TaiV+FOuYIdGMsgh
         98smeCXYWsgBQ==
X-Nifty-SrcIP: [209.85.217.51]
Received: by mail-vs1-f51.google.com with SMTP id w26so5864547vsk.13
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 22:44:18 -0700 (PDT)
X-Gm-Message-State: APjAAAX6kF+4/ZrCyhXGzsP5jApEXmqKkVtSgoh8Y1+sUVuXr/oSfWUc
        YWSi+Xz4v8rShW3Ye0wbAJcdmj3wdkefTflaPgU=
X-Google-Smtp-Source: APXvYqzRLSP67zY3/e1jWEeV2q0cNEBOWXXS7eYzbvLRIcPvE6vLX/oOiPGL6KUZrGDC4HGnxd4yP7X9+tBG2At0M/I=
X-Received: by 2002:a67:7a43:: with SMTP id v64mr17569262vsc.54.1553579057381;
 Mon, 25 Mar 2019 22:44:17 -0700 (PDT)
MIME-Version: 1.0
References: <1553566409-23873-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1553566409-23873-1-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 26 Mar 2019 14:43:41 +0900
X-Gmail-Original-Message-ID: <CAK7LNASVfNPLUi44jjL9R9bCH19GFTMNsXu4MFXagSK+7A5SCA@mail.gmail.com>
Message-ID: <CAK7LNASVfNPLUi44jjL9R9bCH19GFTMNsXu4MFXagSK+7A5SCA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: fix the file path of uniphier-mdmac.c
To:     Jiri Kosina <trivial@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>, Vinod Koul <vkoul@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 11:15 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> The pattern drivers/dmaengine/uniphier-mdmac.c has no match in the
> source tree.
>
> The correct path is drivers/dma/uniphier-mdmac.c
>
> Reported-by: Joe Perches <joe@perches.com>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---


I take this back.

I sent this to the trivial subsystem, but
looks like Vinod Koul has just fixed it in his tree.



>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3e5a5d2..bfb1557 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2356,7 +2356,7 @@ F:        arch/arm/mm/cache-uniphier.c
>  F:     arch/arm64/boot/dts/socionext/uniphier*
>  F:     drivers/bus/uniphier-system-bus.c
>  F:     drivers/clk/uniphier/
> -F:     drivers/dmaengine/uniphier-mdmac.c
> +F:     drivers/dma/uniphier-mdmac.c
>  F:     drivers/gpio/gpio-uniphier.c
>  F:     drivers/i2c/busses/i2c-uniphier*
>  F:     drivers/irqchip/irq-uniphier-aidet.c
> --
> 2.7.4
>


-- 
Best Regards
Masahiro Yamada
