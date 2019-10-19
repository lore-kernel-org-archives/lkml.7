Return-Path: <SRS0=/uHP=YM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0AABCA9EAB
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 12:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3CF320869
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 12:09:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbfJSMJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Oct 2019 08:09:47 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:40641 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbfJSMJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Oct 2019 08:09:47 -0400
X-Originating-IP: 86.202.229.42
Received: from localhost (lfbn-lyo-1-146-42.w86-202.abo.wanadoo.fr [86.202.229.42])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 79C991BF208;
        Sat, 19 Oct 2019 12:09:41 +0000 (UTC)
Date:   Sat, 19 Oct 2019 14:09:41 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Julia Lawall <Julia.Lawall@lip6.fr>,
        Himanshu Jha <himanshujha199640@gmail.com>,
        kernel-janitors@vger.kernel.org,
        Coccinelle <cocci@systeme.lip6.fr>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>
Subject: Re: [PATCH] coccinelle: api/devm_platform_ioremap_resource: remove
 useless script
Message-ID: <20191019120941.GL3125@piout.net>
References: <20191017142237.9734-1-alexandre.belloni@bootlin.com>
 <81269cd6-e26d-b8aa-cf17-3a2285851564@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81269cd6-e26d-b8aa-cf17-3a2285851564@web.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/10/2019 11:00:47+0200, Markus Elfring wrote:
> > While it is useful for new drivers to use devm_platform_ioremap_resource,
> 
> This is nice.
> 
> 
> > this script is currently used to spam maintainers,
> 
> This view is unfortunate.
> 
> Do we stumble on a target conflict again?
> 
> 
> > often updating very old drivers.
> 
> This can also happen.
> 
> 
> > The net benefit is the removal of 2 lines of code in the driver
> 
> Additional effects can be reconsidered, can't they?
> 

What are the additional effects? What is the end goal of converting all
the existing drivers to devm_platform_ioremap_resource? The existing
code is currently always correct and it is difficult to see how this
would lead to any bug avoidance in the long term.

> > but the review load for the maintainers is huge.
> 
> Does collateral evolution trigger a remarkable amount of changes occasionally?
> 

This is not an evolution, it is unnecessary churn. Those patches have no
benefit and eat up very valuable reviewer time.

> 
> How will such feedback influence the development and integration of
> further scripts for the semantic patch language (Coccinelle software)?
> 

There are a few other scripts that have no added value when applied to
existing code, like ptr_ret.cocci.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
