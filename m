Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08899C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 04:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF0DE20661
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 04:18:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfCGESz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 23:18:55 -0500
Received: from mail1.windriver.com ([147.11.146.13]:60365 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfCGESz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 23:18:55 -0500
Received: from ALA-HCB.corp.ad.wrs.com ([147.11.189.41])
        by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id x274I9vV014376
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Wed, 6 Mar 2019 20:18:10 -0800 (PST)
Received: from yow-pgortmak-d1.corp.ad.wrs.com (128.224.56.57) by
 ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server id
 14.3.439.0; Wed, 6 Mar 2019 20:18:09 -0800
Received: by yow-pgortmak-d1.corp.ad.wrs.com (Postfix, from userid 1000)        id
 066622E03DB; Wed,  6 Mar 2019 23:18:08 -0500 (EST)
Date:   Wed, 6 Mar 2019 23:18:08 -0500
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Pavel Machek <pavel@ucw.cz>
CC:     Lee Jones <lee.jones@linaro.org>, <linux-kernel@vger.kernel.org>,
        Alessandro Rubini <rubini@gnudd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Cory Maccarrone <darkstar6262@gmail.com>,
        Davide Ciminaghi <ciminaghi@gnudd.com>,
        Dong Aisheng <dong.aisheng@linaro.org>,
        Graeme Gregory <gg@slimlogic.co.uk>,
        Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
        Haojian Zhuang <haojian.zhuang@marvell.com>,
        Jin Park <jinyoungp@nvidia.com>,
        Jorge Eduardo Candelaria <jedu@slimlogic.co.uk>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@opensource.wolfsonmicro.com>,
        Mattias Nilsson <mattias.i.nilsson@stericsson.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Tony Lindgren <tony@atomide.com>,
        Venu Byravarasu <vbyravarasu@nvidia.com>,
        <linux-omap@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: Re: [PATCH v5 00/18] mfd: demodularization of non-modular drivers
Message-ID: <20190307041808.GK26690@windriver.com>
References: <1547404609-14161-1-git-send-email-paul.gortmaker@windriver.com>
 <20190116132431.GE23399@dell>
 <20190306231003.GD7915@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190306231003.GD7915@amd>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Re: [PATCH v5 00/18] mfd: demodularization of non-modular drivers] On 07/03/2019 (Thu 00:10) Pavel Machek wrote:

> On Wed 2019-01-16 13:24:31, Lee Jones wrote:
> > [...]
> > 
> > > Paul Gortmaker (18):
> > >   mfd: aat2870-core: Make it explicitly non-modular
> > >   mfd: adp5520: Make it explicitly non-modular
> > >   mfd: as3711: Make it explicitly non-modular
> > >   mfd: db8500-prcmu: drop unused MODULE_ tags from non-modular code
> > >   mfd: htc-i2cpld: Make it explicitly non-modular
> > >   mfd: max8925-core: drop unused MODULE_ tags from non-modular code
> > >   mfd: rc5t583: Make it explicitly non-modular
> > >   mfd: sta2x11: drop unused MODULE_ tags from non-modular code
> > >   mfd: syscon: Make it explicitly non-modular
> > >   mfd: tps65090: Make it explicitly non-modular
> > >   mfd: tps65910: Make it explicitly non-modular
> > >   mfd: tps80031: Make it explicitly non-modular
> > >   mfd: wm831x-spi: Make it explicitly non-modular
> > >   mfd: wm831x-i2c: Make it explicitly non-modular
> > >   mfd: wm831x-core: drop unused module infrastructure from non-modular code
> > >   mfd: wm8350-i2c: Make it explicitly non-modular
> > >   mfd: wm8350-core: drop unused module infrastructure from non-modular code
> > >   mfd: wm8400-core: Make it explicitly non-modular
> > > 
> > >  drivers/mfd/aat2870-core.c      | 40 +++-------------------------------------
> > >  drivers/mfd/adp5520.c           | 30 +++++++-----------------------
> > >  drivers/mfd/as3711.c            | 14 --------------
> > >  drivers/mfd/db8500-prcmu.c      | 10 ++++------
> > >  drivers/mfd/htc-i2cpld.c        | 18 +-----------------
> > >  20 files changed, 41 insertions(+), 332 deletions(-)
> > 
> > All applied!
> 
> Is it good idea?

Pavel, I think yes it is good, and I hope you will allow me the chance
to convince you of the same.  It removes dead code, and removes the
chance that people mistakenly believe any of these drivers were
currently possible as modules, when they were really NOT at all modular.

> We want distro kernels on ARM, too, which means people will eventually
> want these as a modules, no?

And at the risk of repeating something I've said a lot already, this
is fine, and I 100% support people converting drivers to being modular,
in the case where there is demand, and where people with the hardware
who are willing to test that the modular use-case actually works.

If people want it to be modular, then this work actually helps.  You
don't have drivers "hiding in the shadows" that pretend to be modules.
Such drivers do not at all help with the "distro kernels" use case.

If a driver author responds and says they intended to make their driver
a module, I 100% support them, and will drop the code removal patch and
also have supported them in making their work tristate.  If the choice
to convert to tristate happens a year or more from now, it is trivial to
reclaim the unused-but-deleted code from git.

But, again as I have said many times -- I can't know every detail of
each driver to know if module/tristate makes any sense, as a use-case or
if even technically possible (such as in DMA/IOMMU or similar low level
core systems).   So the right option is to remove the dead code and not
impact the existing driver behaviour, and make it clear in the process
to the authors and users, that the driver was never modular to begin
with --  and in doing so, give them all a chance to comment and react.

Pavel, I hope this more extended explanation makes sense to you, and
that you simply have not seen me write these same details in the past.

Thanks,
Paul.
--

> 									Pavel
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html


