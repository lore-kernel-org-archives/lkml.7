Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96216C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66E3520693
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:44:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729648AbfDPOoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 10:44:16 -0400
Received: from muru.com ([72.249.23.125]:46280 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725796AbfDPOoP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 10:44:15 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 1CF4F8081;
        Tue, 16 Apr 2019 14:44:30 +0000 (UTC)
Date:   Tue, 16 Apr 2019 07:44:12 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>, linux-omap@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: OMAP1: ams-delta: fix early boot crash when LED
 support is disabled
Message-ID: <20190416144412.GF2839@atomide.com>
References: <20190415233732.3612-1-aaro.koskinen@iki.fi>
 <20190416071420.GA14538@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416071420.GA14538@amd>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [190416 07:14]:
> On Tue 2019-04-16 02:37:32, Aaro Koskinen wrote:
> > When we boot with the LED support (CONFIG_NEW_LEDS) disabled,
> > gpio_led_register_device() will return a NULL pointer and we try
> > to dereference it. Fix by checking also for a NULL pointer.
> > 
> > Fixes: 19a2668a8ae3 ("ARM: OMAP1: ams-delta: Provide GPIO lookup table for LED device")
> > Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> 
> Acked-by: Pavel Machek <pavel@ucw.cz>

Applying into omap-for-v5.1/fixes thanks.

Tony

