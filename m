Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E47C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 18:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B72620644
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 18:02:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbfETSCV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 14:02:21 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:58711 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbfETSCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 14:02:21 -0400
Received: from [2a01:598:8989:90c3:fc90:b8ff:fed0:1fb6] (helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hSmc4-00078F-Rs; Mon, 20 May 2019 20:02:17 +0200
Date:   Mon, 20 May 2019 20:02:10 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Neil Armstrong <narmstrong@baylibre.com>
cc:     jason@lakedaemon.net, marc.zyngier@arm.com,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] irqchip: irq-meson-gpio: update with SPDX Licence
 identifier
In-Reply-To: <20190520140310.29635-1-narmstrong@baylibre.com>
Message-ID: <alpine.DEB.2.21.1905202001270.1635@nanos.tec.linutronix.de>
References: <20190520140310.29635-1-narmstrong@baylibre.com>
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

On Mon, 20 May 2019, Neil Armstrong wrote:

> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/irqchip/irq-meson-gpio.c | 15 +--------------
>  1 file changed, 1 insertion(+), 14 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-meson-gpio.c b/drivers/irqchip/irq-meson-gpio.c
> index 7b531fd075b8..d83244ea0959 100644
> --- a/drivers/irqchip/irq-meson-gpio.c
> +++ b/drivers/irqchip/irq-meson-gpio.c
> @@ -1,22 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0+

+ ????

>  /*
>   * Copyright (c) 2015 Endless Mobile, Inc.
>   * Author: Carlo Caione <carlo@endlessm.com>
>   * Copyright (c) 2016 BayLibre, SAS.
>   * Author: Jerome Brunet <jbrunet@baylibre.com>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of version 2 of the GNU General Public License as
> - * published by the Free Software Foundation.

I really can't spot a 'or any later version' text here ....

> - * This program is distributed in the hope that it will be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, see <http://www.gnu.org/licenses/>.
> - * The full GNU General Public License is included in this distribution
> - * in the file called COPYING.
>   */
>  
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> -- 
> 2.21.0
> 
> 
