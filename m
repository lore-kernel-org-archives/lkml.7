Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08FE6C48BD6
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 06:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFB02204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 06:53:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727746AbfFYGxa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 02:53:30 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40766 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbfFYGxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 02:53:30 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hffKS-0006Ua-Pm; Tue, 25 Jun 2019 08:53:20 +0200
Date:   Tue, 25 Jun 2019 08:53:19 +0200 (CEST)
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
Subject: Re: [PATCH v13 07/13] clocksource: Add a new timer-ingenic driver
In-Reply-To: <20190624225759.18299-8-paul@crapouillou.net>
Message-ID: <alpine.DEB.2.21.1906250851130.32342@nanos.tec.linutronix.de>
References: <20190624225759.18299-1-paul@crapouillou.net> <20190624225759.18299-8-paul@crapouillou.net>
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

On Tue, 25 Jun 2019, Paul Cercueil wrote:
> +
> +struct ingenic_soc_info {
> +	unsigned int num_channels;
> +};
> +
> +struct ingenic_tcu {
> +	struct regmap *map;
> +	struct clk *timer_clk, *cs_clk;
> +
> +	unsigned int timer_channel, cs_channel;
> +	struct clock_event_device cevt;
> +	struct clocksource cs;
> +	char name[4];
> +
> +	unsigned long pwm_channels_mask;
> +};

As in the irq driver. Aside of that:

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>


