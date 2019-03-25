Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5760BC4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 07:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E29B2087F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 07:36:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729855AbfCYHgt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 03:36:49 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37071 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729720AbfCYHgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 03:36:48 -0400
Received: by mail-lf1-f67.google.com with SMTP id u2so5227059lfd.4;
        Mon, 25 Mar 2019 00:36:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3zit+zHMjJqC+5ZLnskoQ4EDwxgMuwgUpGQ5brmYqTA=;
        b=QxDVSudXH5pFgKapa3stq6/mS/DZO1iMntOo6E/+yY+liz81/ObrpWUfEiZCeaJOuw
         lsTAHSPwio0xo97gGjKOQUKTyj7AQe3x+jliK5fJUm8PQiFWTocwladvo1yLK4cW6r6O
         NZbrTLv8wUE3f0cpNfNbA0XYrJos0lcc5soT0PjD9FfXxZ6R0aiy9SkO+8awTExpDbrG
         pgIjd2/MC1bQs0mAzy177JB5DDTcVhA5M6bwcSa89vBXmRKeonZa60RRfhrCf8zXjaBt
         jMX8FLluvfNj7myMDQoj3PpZykmHsxFvWYPkLJExJmQrhdqsAnOnr4m+edfhzgSgbkat
         UzAQ==
X-Gm-Message-State: APjAAAX0D9N+fhO0oFi9HRhzLDqTZkbdM7X8DpRz9xv1NUzsZocukahC
        mSn/6Q4oxwndqxSNtdnt7MY=
X-Google-Smtp-Source: APXvYqzLeiWG6LPSaHeaCX6SI2behk4QpDy0H2rM9A/lBNpaOJ8F16Tezk50DUdC8qa5L2VF97CxJw==
X-Received: by 2002:ac2:5479:: with SMTP id e25mr10449561lfn.121.1553499405088;
        Mon, 25 Mar 2019 00:36:45 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id r24sm1615196ljr.63.2019.03.25.00.36.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 00:36:44 -0700 (PDT)
Date:   Mon, 25 Mar 2019 09:36:41 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     mazziesaccount@gmail.com, Guenter Roeck <linux@roeck-us.net>,
        heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com,
        robh+dt@kernel.org, mark.rutland@arm.com, broonie@kernel.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        sre@kernel.org, lgirdwood@gmail.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, wim@linux-watchdog.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-watchdog@vger.kernel.org, bogdan-petru.chircu-mare@nxp.com
Subject: Re: [PATCH v10 0/9] support ROHM BD70528 PMIC
Message-ID: <20190325073640.GB6208@localhost.localdomain>
References: <cover.1550148989.git.matti.vaittinen@fi.rohmeurope.com>
 <20190228070450.GB3773@localhost.localdomain>
 <20190228081055.GL4118@dell>
 <20190228082248.GC3773@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228082248.GC3773@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello again Lee & all,

On Thu, Feb 28, 2019 at 10:22:48AM +0200, Matti Vaittinen wrote:
> On Thu, Feb 28, 2019 at 08:10:55AM +0000, Lee Jones wrote:
> > On Thu, 28 Feb 2019, Matti Vaittinen wrote:
> > 
> > > Hello Lee and Mark,
> > > 
> > > On Thu, Feb 14, 2019 at 03:02:37PM +0200, Matti Vaittinen wrote:
> > > > Patch series introducing support for ROHM BD70528 PMIC

//snip

> > > 
> > > The MFD part depends on the regmap-irq changes and I think that most
> > > other subsystems want to have the MFD changes in before taking rest of
> > > the driver in their trees. So it will be a while untill all the changes
> > > are in. It would really be nice to have the drive in-tree sooner - hence
> > > I ask if theres a way. (I don't want to push, just ask if it is possible :])
> > 
> > It's possible, so long as there aren't any build-time dependencies
> > between the subsystems.  Immediate acceptance however isn't possible
> > due to the impending merge-window which opens in 3 days.
> 
> Thanks for reply Lee. So merge-window is opening - meaning the 5.1 is
> being baked now(?) 
> 
> Anyays to make it clear - there is build time dependency between MFD and
> regmap-irq changes. MFD part won't compile without the changes in regmap
> tree. And theres no new Kconfig to depend on or other compile time
> checks. So REGMAP changes are required for this MFD portion to compile.

//snip

> Rest of the subsystems (regulator, clk, watchdog, gpio) do all depend on
> MFD - but they should have 'depends on' KConfig to MFD meaning they
> won't be built without MFD.

I see the 5.1-rc1 and 5.1-rc2 are out. Those contain the regmap-irq
changes the BD70528 MFD driver depends on. Would you like me to rebase
the series to some other tree (which tree/branch? I don't see updated
for-mfd-next branch in kernel.org yet) and resend it? Original patch
series was created on top of the regulator tree.

Br,
	Matti Vaittinen

-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
