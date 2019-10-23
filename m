Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F900CA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 12:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E96C214B2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 12:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391646AbfJWMnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 08:43:55 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:34143 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729191AbfJWMnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 08:43:55 -0400
Received: from mail-qt1-f170.google.com ([209.85.160.170]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1Miqvq-1hkv2T3MQ8-00ey7s; Wed, 23 Oct 2019 14:43:54 +0200
Received: by mail-qt1-f170.google.com with SMTP id t20so32002027qtr.10;
        Wed, 23 Oct 2019 05:43:53 -0700 (PDT)
X-Gm-Message-State: APjAAAUsi8K06+gM1liavPuZEqai+ERGQU0ngcAP3QpNZZ1m5c5Iedin
        7t/+FUOJqAjMhw8HjHYDkPBQhOxxuDp/riuFVkA=
X-Google-Smtp-Source: APXvYqwNvhXDrr6AHjcTLNQwmEbDOVOaCUMULb04vjXb82DPGWeMlJtUjbZ9hzvBPBa+1tZw0f1o0rKNFQGqQEfhgWY=
X-Received: by 2002:ac8:6956:: with SMTP id n22mr8785341qtr.7.1571834632511;
 Wed, 23 Oct 2019 05:43:52 -0700 (PDT)
MIME-Version: 1.0
References: <20191010202802.1132272-1-arnd@arndb.de> <20191010203043.1241612-1-arnd@arndb.de>
 <20191010203043.1241612-8-arnd@arndb.de> <20191023105717.GF10630@pi3>
In-Reply-To: <20191023105717.GF10630@pi3>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 23 Oct 2019 14:43:36 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2k0nZCJu-DCC7unMM_rOU7edmBOnb7dTKw_mAsi5sUuA@mail.gmail.com>
Message-ID: <CAK8P3a2k0nZCJu-DCC7unMM_rOU7edmBOnb7dTKw_mAsi5sUuA@mail.gmail.com>
Subject: Re: [PATCH 08/36] ARM: exynos: stop selecting PLAT_SAMSUNG
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Kukjin Kim <kgene@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:L4atwlEocu90YjR8kiseY9DslQMah477JvLfpWOhKR/rmD2Bv6N
 lpxuh4EyXZHErIWkJIPqqttHoJUiUAiJ5cJTFNpOIPhOdz15qWoTsZHvroO38XGLiw52cZ0
 0z72sejYN1kRj3EgrXryKCXN+NhLFdDZL4gc3P8GWAVxlpe6C5YU0UZDeerkajM4PRlG88r
 uQV74O4Pj+RP8Gptliz9A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IW6Av6rs4T0=:VPxx28Gp8EMmMBDCDFDd59
 BTxb7zuxHXwCMGHJqsZFM337k0SBt1J8Vaxl5w9EM43CwFhI2RLsI09MMk1C00/fNdcq1nK7r
 t8069eoiB87XGoIuT+GMGa71uHSOF3PTinoB3lc+g6bebkIVtqlvTt8QOA4wQ55A1PoICaVy0
 oHGQhaK5sbsOUKyBRQzeum2bHuPCaKjjooiCl/BjGQxwncAn4H+GC0uz5K0fZQp0zCLYFn30O
 Qpf3QMWPMUCHUcLtW0DIc6Q6yvoRIZR/P7tX5iW09p5H547tLkqtcA7iDtjzFaBHu8sGsI7kd
 jpVoAMgQTdEMlV5UcMSP4hEeEsi2oIg+N/Jc7s7dBluuVnZXMun8AuJd4nzpgmpqu5Lr9W9ST
 KSUkktbWwhL0V+MJRgSD2LoAiTFHDtl7wHaek05038LGBdxtnvWDNRXmFN7xdy/BjwelDThTS
 mvJhQRQQQIpn4NmjcaucPKnWH7mkvWbRy3pr3bp0pCmaAPBic7aGy2d+SKPErDMfpXP4LiCcT
 Q2oXnnYd05yCEunJH9ILMwtitcUVu4rg6bj/07zaioC2ePeZY2fPdgUixQPwA7B1fLmR6IMMq
 LpIdkiL2BlgykIPpW8SidODeECo0ym96jwjxAHmHyolxGvkzrTi8zjWayeR5gc0kw7g0Ou7qn
 /FRsecRduMpcpJsyFuBqxSOWD2ctn5O0Ul87qvpA4HJIdVKsxmn7ymjkSjiUTnPmJ0vMWhSUM
 rFlTdcU5y1/CbiSt71AHa3DaeM50zXGhiPZGx/9BCdyHdbW4BklPdiY7/ak8jprwLgjnSI261
 EKoFZNchJhmKcm6wPAASuQN0HGm6hEhmw1Qdz8q3423aN8vmltPSReNeC0PMKpvo+wVsmd11P
 eJSaAhz1gF+sGZkNDmhw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 12:57 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On Thu, Oct 10, 2019 at 10:29:52PM +0200, Arnd Bergmann wrote:
> > @@ -1022,7 +1022,7 @@ choice
> >                 by the boot-loader before use.
> >
> >       config DEBUG_S3C_UART2
> > -             depends on PLAT_SAMSUNG
> > +             depends on PLAT_SAMSUNG || ARCH_EXYNOS
> >               select DEBUG_EXYNOS_UART if ARCH_EXYNOS
> >               select DEBUG_S3C24XX_UART if ARCH_S3C24XX
> >               select DEBUG_S3C64XX_UART if ARCH_S3C64XX
> > @@ -1034,7 +1034,7 @@ choice
> >                 by the boot-loader before use.
> >
> >       config DEBUG_S3C_UART3
> > -             depends on PLAT_SAMSUNG && (ARCH_EXYNOS || ARCH_S5PV210)
> > +             depends on ARCH_EXYNOS || ARCH_S5PV210
>
> You need to keep PLAT_SAMSUNG because of additional architectures, so
> follow pattern from DEBUG_S3C_UART2.

Are you sure? I think my version is correct: for UART2, the
"PLAT_SAMSUNG || ARCH_EXYNOS" is equivalent to "s3c24xx || s3c64xx ||
s5pv210 || exynos", which keeps the existing behavior unchanged.

For UART3, the "PLAT_SAMSUNG && ..." is redundant, this is already
limited to "s5pv210 || exynos", which my patch keeps. Changing it to
"PLAT_SAMSUNG || ..." would allow selecting the symbol on s3c24xx
and s3c64xx, which presumably is not valid.

      Arnd
