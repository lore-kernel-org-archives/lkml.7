Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A5E4C10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 23:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC7C12082E
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 23:54:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbfDMXyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 19:54:52 -0400
Received: from 178.115.242.59.static.drei.at ([178.115.242.59]:41663 "EHLO
        mail.osadl.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727113AbfDMXyw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 19:54:52 -0400
Received: by mail.osadl.at (Postfix, from userid 1001)
        id 9C89F5C094E; Sun, 14 Apr 2019 01:54:03 +0200 (CEST)
Date:   Sun, 14 Apr 2019 01:54:03 +0200
From:   Nicholas Mc Guire <der.herr@hofr.at>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Nicholas Mc Guire <hofrat@osadl.org>,
        Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] ARM: imx legacy: add an SPDX license identifier
Message-ID: <20190413235403.GB26682@osadl.at>
References: <1555140213-1081-1-git-send-email-hofrat@osadl.org>
 <1555140213-1081-5-git-send-email-hofrat@osadl.org>
 <CAOMZO5DV=fyefeazCE0EEnBQC5_zvBW5JyHdFoZA5ROCxQVTdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMZO5DV=fyefeazCE0EEnBQC5_zvBW5JyHdFoZA5ROCxQVTdQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 13, 2019 at 11:11:05AM -0300, Fabio Estevam wrote:
> On Sat, Apr 13, 2019 at 4:30 AM Nicholas Mc Guire <hofrat@osadl.org> wrote:
> >
> > The header clearly identifies this code as GPL V2 or later - so pop
> > in the SPDX license identifier.
> >
> > Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> > ---
> >  arch/arm/mach-imx/mach-mx27ads.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/arm/mach-imx/mach-mx27ads.c b/arch/arm/mach-imx/mach-mx27ads.c
> > index c83fdd3..3f68972 100644
> > --- a/arch/arm/mach-imx/mach-mx27ads.c
> > +++ b/arch/arm/mach-imx/mach-mx27ads.c
> > @@ -1,3 +1,4 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> 
> As you are adding the SPDX line you could also remove the legal text below.

hmmm - as I'm not the copyright holder I do not think I should
be doing that - it has more information in it that only GPL V2+

thx!
hofrat
