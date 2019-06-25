Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29848C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 06:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09CCE20656
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 06:44:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729573AbfFYGoo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 02:44:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40726 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbfFYGon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 02:44:43 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hffBr-0006Jg-Fq; Tue, 25 Jun 2019 08:44:27 +0200
Date:   Tue, 25 Jun 2019 08:44:26 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Paul Cercueil <paul@crapouillou.net>
cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        Mathieu Malaterre <malat@debian.org>, od@zcrc.me,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org, Artur Rojek <contact@artur-rojek.eu>
Subject: Re: [PATCH v13 02/13] doc: Add doc for the Ingenic TCU hardware
In-Reply-To: <20190624225759.18299-3-paul@crapouillou.net>
Message-ID: <alpine.DEB.2.21.1906250840150.32342@nanos.tec.linutronix.de>
References: <20190624225759.18299-1-paul@crapouillou.net> <20190624225759.18299-3-paul@crapouillou.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paul,

On Tue, 25 Jun 2019, Paul Cercueil wrote:

> Add a documentation file about the Timer/Counter Unit (TCU) present in

s/Add a /Add /

> the Ingenic JZ47xx SoCs.
> 
> diff --git a/Documentation/mips/ingenic-tcu.txt b/Documentation/mips/ingenic-tcu.txt
> new file mode 100644
> index 000000000000..1a753805779c
> --- /dev/null
> +++ b/Documentation/mips/ingenic-tcu.txt

There is a massive effort to convert the whole Documentation tree to rst
format. Please do not introduce new txt files.

Also documentation wants a SPDX license identifier.

> +Implementation
> +--------------
> +
> +The functionalities of the TCU hardware are spread across multiple drivers:
> +- boilerplate:      drivers/mfd/ingenic-tcu.c
> +- clocks:           drivers/clk/ingenic/tcu.c
> +- interrupts:       drivers/irqchip/irq-ingenic-tcu.c
> +- timers:           drivers/clocksource/ingenic-timer.c
> +- PWM:              drivers/pwm/pwm-jz4740.c
> +- watchdog:         drivers/watchdog/jz4740_wdt.c
> +- OST:              drivers/clocksource/ingenic-ost.c

Hrm. These file names are going to be stale over time, but I have no better
idea either.

Thanks,

	tglx
