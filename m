Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17BCDC43215
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 14:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC508215A5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 14:20:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfK2OUg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 09:20:36 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:44877 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbfK2OUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 09:20:36 -0500
Received: from mail-qt1-f171.google.com ([209.85.160.171]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MKKpV-1iMjin0mhb-00Ln5s; Fri, 29 Nov 2019 15:20:34 +0100
Received: by mail-qt1-f171.google.com with SMTP id g1so23258830qtj.6;
        Fri, 29 Nov 2019 06:20:33 -0800 (PST)
X-Gm-Message-State: APjAAAVeIxuyG3arKOOpff/wBt4fufMFQaJR36pToBgDvGlcl+PwWGR6
        rIs6xxFXDF8RKMfxOyD6nq053DuH42W0tWhoApw=
X-Google-Smtp-Source: APXvYqzuj1g3/GU3W0Lff3sjm4Lv42/6ORZFJ6s5TNnb+zf08goAKPnWFeOteSaiZYTfp9N207PDOibr4xIs9S0H9Os=
X-Received: by 2002:ac8:27ab:: with SMTP id w40mr923393qtw.18.1575037232961;
 Fri, 29 Nov 2019 06:20:32 -0800 (PST)
MIME-Version: 1.0
References: <20191120144109.25321-1-alexandre.torgue@st.com> <20191120144109.25321-6-alexandre.torgue@st.com>
In-Reply-To: <20191120144109.25321-6-alexandre.torgue@st.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 29 Nov 2019 15:20:17 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2Bg9KwfEqEE3_NUHxVv=svFGuj--Tnq-w-xFg63cfqAA@mail.gmail.com>
Message-ID: <CAK8P3a2Bg9KwfEqEE3_NUHxVv=svFGuj--Tnq-w-xFg63cfqAA@mail.gmail.com>
Subject: Re: [PATCH 5/6] ARM: dts: stm32: Adapt STM32MP157 DK boards to stm32
 DT diversity
To:     Alexandre Torgue <alexandre.torgue@st.com>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:NLvHyL+xPM210KGzaFmfQUilyszQKsVCq0rRB+YIq5LrCHU9WQA
 pCT8E4l4MQ/OP9uxya3h4OyXD3F2m4ULoMvsAPtrHxeaq4W8eyGhKa49jzX2J0zlOzPvny7
 iT/eu9rIsz2LCduZww9Hwfk40A1A/QBR8aX0Wr8WbmwBWRncps/TtWXuUOwY/yUc3FKwCu0
 7Ja2/21WE2cdd1J5ymQVA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MYtAM4pt8kk=:yKpuwmxdfDAm+eV3XXctxq
 j8ugWM++Q5TJbQ4ax+2qKJ+OSnBV7Rk6XuEUBWlZy+H/8f28LCqsGfMZVdBiCwTfb3qMowl7e
 EOifNHddK6UzKpWhnYNHvyyuWxfFfeW1Ur+5D/hpDSLwMR1D+k4IRzKKa90aaEBg1wJwEnG4x
 gZYjGzeI8dVwcvtNLu/mlw9EVqJJT8adqGt60ma5IeroGxTFbOqPls4LyXxoAQWhVFSywp5Ai
 PUl6FbqRHBdORgGLxYbLdYgw8fkd+19S4hpERiD2tK11oHHG5MC3/HU/19nIA4znb/n+jql7n
 mdRfuGJd3eBcQOcq29Y0qxornamU0DSlC9xnAxLtB0xdONUL61RkqC5nv8+IQJFWpLS6jVAej
 7eG981M4KS7dhm0gi9PyUr01loIewX5bdrht5iFAdRBaiBqeYC+8si0Rx1ovX+W/Hhi47Pi2G
 LtscDhoWDCDFIl4peisvyS2mLqYFFsUDEBUo8BZSr/e9+peOvSZ9agffe+S9jWzzDgZxYvaGB
 O5dwcNo9XHOZGHvFdm5MDTux3qUEfmnckS9Ag3JleRnGpqmowDJlOrhOCMWPfBrhkyDxooWXr
 Ac8HTHy59a7lAjhi6Vmf6wJkmbhxpRpJVwA0OOtUH4lfgw8PhVi++PZ3SPuRCAyhNYLYDfzo0
 xiVPf3ezMVdsl3mqfsFYcThhUt2KgiuT89FvKyMCVhKx21sagKkTaXwKoIG2g5T7TBYe/MaAN
 RR/dqlEfr2K4+Jg9inmEhWx4AsZbS+UQdK3PfUBo5HpcgzgBPBMZbtHQDF32myxkw8aih5zVB
 W/BsqbH9YCzAXtot2oLpZ5NjrFbW9UeZA+EnH4S/h4JBrz3KfDZP6KoJndmbxhpl4nguNAP7s
 4/Qh0uYpEbvdCpwlqWkQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 3:41 PM Alexandre Torgue
<alexandre.torgue@st.com> wrote:
>
> To handle STM32MP15 SOCs diversity, some updates have to been done.
> This commit mainly adapt dk1 board to include the correct package and the
> correct SOC version. A new file has been created to factorize common parts.
>
> Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>
>
> diff --git a/arch/arm/boot/dts/stm32mp157a-dk1.dts b/arch/arm/boot/dts/stm32mp157a-dk1.dts
> index 3f869bd67082..1292ac3b6890 100644
> --- a/arch/arm/boot/dts/stm32mp157a-dk1.dts
> +++ b/arch/arm/boot/dts/stm32mp157a-dk1.dts
>         model = "STMicroelectronics STM32MP157A-DK1 Discovery Board";
>         compatible = "st,stm32mp157a-dk1", "st,stm32mp157";
> -
> -       aliases {
> -               ethernet0 = &ethernet0;
> -               serial0 = &uart4;
> -       };
> -
> -       chosen {
> -               stdout-path = "serial0:115200n8";
> -       };
> -

As a rule, I would leave aliases and chosen nodes in the .dts file and not
move them into a shared .dtsi, since they tend to be board specific.

(even if that may not be the case in this particular file)

      Arnd
