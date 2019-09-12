Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE833C49ED9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 09:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF35520663
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 09:17:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730599AbfILJRd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 05:17:33 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38554 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730386AbfILJRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 05:17:31 -0400
Received: by mail-qt1-f193.google.com with SMTP id j31so1903930qta.5;
        Thu, 12 Sep 2019 02:17:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3v9vNWScPyFQpJOj2uC5NrtlNxn+puyxlyM0L6NxVxI=;
        b=DFv/JSkSm/ASw4AJkKifQYAoWJFeMXObeBn8sY9QUNG/hhjudK0jJKQ9qvoQEecqGc
         KWYfQy+yvkbZPvcJfQlLeGSVP10sbMBL9plVaneFAjbJSHII98yV6ENsgvXwTzdNDZc/
         z1Hbexj7eSxCZvQ53ZHhmSohkRAUms9BS9t1jQCqKTCpOGw2Ng0p0TmNiGqBhs3UoVVu
         GWj/hTUfXaREysSdtwBWvw7MRPWob8HNuLRN75nMcny1oKoy5e/MC2WWgb9cmNNekQSI
         YjPmtVR/sKL0IiC4CsiIn9QGH7M0zw5IM4hIGoBQ3WsK5wxZqF6zhHXJc2CeQgvwp0/n
         siWg==
X-Gm-Message-State: APjAAAVD+S4ClH2PeD0dqlUQbrb3c14rBsb54KvijjW73m0tNKunO4o/
        A9IEHne/Ocnp7Tzlj6ZA+jn9ofD8/5wTv1tgtFp+CHOhr3o=
X-Google-Smtp-Source: APXvYqy+bZ/IsdWGG/lweYHMToFo2NNHZpONP/kd5+jqUDDglfiDRhLYrs6Ayjqcx3vUQ5sGnAv8u0JP9HHxRjVMY+w=
X-Received: by 2002:ac8:6b1a:: with SMTP id w26mr39336977qts.304.1568279850382;
 Thu, 12 Sep 2019 02:17:30 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1568239378.git.amit.kucheria@linaro.org> <8f539b28c25d22b8f515c131cd6b24c309f7ca90.1568239378.git.amit.kucheria@linaro.org>
In-Reply-To: <8f539b28c25d22b8f515c131cd6b24c309f7ca90.1568239378.git.amit.kucheria@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 12 Sep 2019 11:17:14 +0200
Message-ID: <CAK8P3a3u8KhgaqoK0=2CXBs0HMh0fuN-ANvvQtSrWQm0J6xnvw@mail.gmail.com>
Subject: Re: [PATCH 3/4] arm64: Kconfig: Fix VEXPRESS driver dependencies
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
>
> Push various VEXPRESS drivers behind ARCH_VEXPRESS dependency so that it
> doesn't get enabled by default on other platforms.
>
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  drivers/bus/Kconfig           | 2 +-
>  drivers/clk/versatile/Kconfig | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
> index d80e8d70bf10..b2b1beee9953 100644
> --- a/drivers/bus/Kconfig
> +++ b/drivers/bus/Kconfig
> @@ -166,7 +166,7 @@ config UNIPHIER_SYSTEM_BUS
>
>  config VEXPRESS_CONFIG
>         bool "Versatile Express configuration bus"
> -       default y if ARCH_VEXPRESS
> +       depends on ARCH_VEXPRESS
>         depends on ARM || ARM64
>         depends on OF

Removing the 'default y' breaks existing defconfig files,

Adding the 'depends on ARCH_VEXPRESS' unnecessarily limits
compile-testing. I'd rather extend it to other architectures than
limit it to builds that have vexpress enabled.

> diff --git a/drivers/clk/versatile/Kconfig b/drivers/clk/versatile/Kconfig
> index ac766855ba16..826750292c1e 100644
> --- a/drivers/clk/versatile/Kconfig
> +++ b/drivers/clk/versatile/Kconfig
> @@ -5,8 +5,8 @@ config ICST
>  config COMMON_CLK_VERSATILE
>         bool "Clock driver for ARM Reference designs"
>         depends on ARCH_INTEGRATOR || ARCH_REALVIEW || \
> -               ARCH_VERSATILE || ARCH_VEXPRESS || ARM64 || \
> -               COMPILE_TEST
> +               ARCH_VERSATILE || ARCH_VEXPRESS || COMPILE_TEST
> +       depends on ARM64

It's definitely wrong to limit this to 64 bit.

      Arnd
