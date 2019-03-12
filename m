Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF95C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 19:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A364F2087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 19:03:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbfCLTD4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 15:03:56 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:39530 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726815AbfCLTDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 15:03:55 -0400
Received: by mail-vk1-f196.google.com with SMTP id i68so923961vke.6;
        Tue, 12 Mar 2019 12:03:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o1h8G2iyppaSn5rKfpYOUBhQRQuqezP7Kg2IErjp+EA=;
        b=EHGP08rL4yyEBQmnct5qRGCau3m54e/qoobYz6xhmJv9w+l3VI9Z86j7C+lWHGcZaW
         lpAiTQ5LbCFW2i/m7VVtbrWuEXIhEevuRy4Z/Wp9Y2zr9dJofukDnmJym93gCiaoo8w+
         skXv7/QjyNcgRaaJt/z5qlKi66qtV3oVJFcKzkxAGJqSXq/ChvN8zmpUZ38b+SUyieRq
         AMHsXm5+M1AbvT5WQh/Fyqd4KSYU6WvW73t9oImKMhbGYOmFrt4vgIdYsjQmu4KnCzD4
         lgLeaaG97KM9FdSL4oB0A6r2YvGaHl5HWCzrCZbqpHyae4H4unxVa58bYKiZDDJLgO/t
         Ghww==
X-Gm-Message-State: APjAAAVZvl8yLthEbq51SeeBxixHs/9pUdl5iPx7sEV2mm585/BUsloN
        oE7kOI66OP9kHtjqy8T2+ox/EU8K9Cw15LoBtP0=
X-Google-Smtp-Source: APXvYqyG0EpO51Ka5tScRa2tTtFpdAjL0eb073YLi8XoTlB5laUBxhwpiaPFTCz1oiyWaXkJQp0h5wzZSLs0shLzTaQ=
X-Received: by 2002:a1f:95d5:: with SMTP id x204mr20915557vkd.72.1552417433842;
 Tue, 12 Mar 2019 12:03:53 -0700 (PDT)
MIME-Version: 1.0
References: <1552330521-4276-1-git-send-email-info@metux.net> <1552330521-4276-26-git-send-email-info@metux.net>
In-Reply-To: <1552330521-4276-26-git-send-email-info@metux.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 12 Mar 2019 20:03:42 +0100
Message-ID: <CAMuHMdX7HCHJiKYXVMzYrHmjjDy6YbLntZbep_AKsLY3bxpZWA@mail.gmail.com>
Subject: Re: [PATCH 26/42] drivers: gpio: rcar: pendantic formatting
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, hoan@os.amperecomputing.com,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Lyra Zhang <zhang.lyra@gmail.com>, keguang.zhang@gmail.com,
        vz@mleia.com, Matthias Brugger <matthias.bgg@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jun Nie <jun.nie@linaro.org>, Shawn Guo <shawnguo@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-mips@vger.kernel.org,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        "open list:TI ETHERNET SWITCH DRIVER (CPSW)" 
        <linux-omap@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC linux-renesas-soc

On Mon, Mar 11, 2019 at 7:57 PM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:
> a tab sneaked in, where it shouldn't be.
>
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>

With Thierry's comments addressed:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/drivers/gpio/gpio-rcar.c
> +++ b/drivers/gpio/gpio-rcar.c
> @@ -490,7 +490,7 @@ static int gpio_rcar_probe(struct platform_device *pdev)
>         irq_chip->irq_unmask = gpio_rcar_irq_enable;
>         irq_chip->irq_set_type = gpio_rcar_irq_set_type;
>         irq_chip->irq_set_wake = gpio_rcar_irq_set_wake;
> -       irq_chip->flags = IRQCHIP_SET_TYPE_MASKED | IRQCHIP_MASK_ON_SUSPEND;
> +       irq_chip->flags = IRQCHIP_SET_TYPE_MASKED | IRQCHIP_MASK_ON_SUSPEND;
>
>         ret = gpiochip_add_data(gpio_chip, p);
>         if (ret) {

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
