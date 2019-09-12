Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB3CC5ACAE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 09:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCF3020663
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 09:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730654AbfILJT0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 05:19:26 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41648 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbfILJTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 05:19:25 -0400
Received: by mail-qt1-f194.google.com with SMTP id j10so28697605qtp.8;
        Thu, 12 Sep 2019 02:19:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/EEX7046EyQX+dgnwukMDo53SMY+ASxsTkaNPVYvx58=;
        b=d+O1VCDiZySCvjzB2T5Er4BP12Fj6frpssSpmypcO8piHS0Bu9JjqB45SjGI2L2QMo
         vVTR102HV2tWJfn4fytIrjHgEYGpViMGgtql/OOOHNLBmt/9OxNgrPU5tEUAhG72QJLc
         grWGv3Z3y/Qf85RTZA/CURJhXwst0z0NtcnG+kIBbaIHjRvZw6tnGbL8D8Yg4rCU5mvg
         rTFUU3D2yvP3UZ43RKPi/Puwt+9AMaCVHer84mTXqdJ60TdLs/zcnz3lPOILtbCRhfJV
         ZsIhlLDSeMz9aWCcGyB+ke481IRRT5gLAfdjmMmao4EFvWMiP61cwFJ4WE1TF7InB3Ao
         Zj3A==
X-Gm-Message-State: APjAAAWLBZ/Q3EG4HI9OjSQt9PnS79bcbjC3BIwiPARH/npX/MQ7F1J9
        SWRmYdI0AsrnzlV+DYsqzDnQQtEPDTSVgeWjTUA=
X-Google-Smtp-Source: APXvYqxc9h25eFxwD6FF26I9C2UvbFHea+FAz5jrXWYXKHKodElhIHAuiEDujG9bSdmHQyIXfwwVsVbgEgxQPoPvjYY=
X-Received: by 2002:a0c:e0c4:: with SMTP id x4mr25828053qvk.176.1568279964901;
 Thu, 12 Sep 2019 02:19:24 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1568239378.git.amit.kucheria@linaro.org> <79755cb29b8c23709e346b5dd290481a36627648.1568239378.git.amit.kucheria@linaro.org>
In-Reply-To: <79755cb29b8c23709e346b5dd290481a36627648.1568239378.git.amit.kucheria@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 12 Sep 2019 11:19:09 +0200
Message-ID: <CAK8P3a1K-Cj53RBAvXiGoeqJsymLmH0A3i-b-cE9tZ9PhwO0XQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] arm64: Kconfig: Fix EXYNOS driver dependencies
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        arm-soc <arm@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Sebastian Reichel <sre@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Will Deacon <will@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 12, 2019 at 12:19 AM Amit Kucheria <amit.kucheria@linaro.org> wrote:

> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index 9b2790d3f18a..bdf164a7a7c5 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -194,6 +194,7 @@ config COMMON_CLK_ASPEED
>
>  config COMMON_CLK_S2MPS11
>         tristate "Clock driver for S2MPS1X/S5M8767 MFD"
> +       depends on ARCH_EXYNOS
>         depends on MFD_SEC_CORE || COMPILE_TEST
>         ---help---
>           This driver supports S2MPS11/S2MPS14/S5M8767 crystal oscillator

This breaks compile-testing on non-ARM targets.

> diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
> index b57093d7c01f..a4c4f01343fd 100644
> --- a/drivers/regulator/Kconfig
> +++ b/drivers/regulator/Kconfig
> @@ -797,6 +797,7 @@ config REGULATOR_S2MPA01
>
>  config REGULATOR_S2MPS11
>         tristate "Samsung S2MPS11/13/14/15/S2MPU02 voltage regulator"
> +       depends on ARCH_EXYNOS
>         depends on MFD_SEC_CORE
>         help
>          This driver supports a Samsung S2MPS11/13/14/15/S2MPU02 voltage

Same here. What you could do instead is add

        depends on ARCH_EXYNOS || COMPILE_TEST

to MFD_SEC_CORE, this would then propagate to these
two drivers as well.

      Arnd
