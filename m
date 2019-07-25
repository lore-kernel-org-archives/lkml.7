Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A61FC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 15:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9CD52238C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 15:53:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728944AbfGYPxc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 11:53:32 -0400
Received: from verein.lst.de ([213.95.11.211]:36523 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728808AbfGYPxc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 11:53:32 -0400
Received: by verein.lst.de (Postfix, from userid 2005)
        id 5BBF368B02; Thu, 25 Jul 2019 17:53:28 +0200 (CEST)
Date:   Thu, 25 Jul 2019 17:53:28 +0200
From:   Torsten Duwe <duwe@lst.de>
To:     Enric Balletbo Serra <eballetbo@gmail.com>
Cc:     Vasily Khoruzhick <anarsoul@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Harald Geyer <harald@ccbib.org>,
        Sean Paul <seanpaul@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        arm-linux <linux-arm-kernel@lists.infradead.org>,
        Icenowy Zheng <icenowy@aosc.io>
Subject: Re: [PATCH v3 5/7] drm/bridge: Add Analogix anx6345 support
Message-ID: <20190725155328.GC4820@lst.de>
References: <20190722151154.8344568BFE@verein.lst.de> <CA+E=qVeSjE1i-ngJWv=GTQDM6HL-VEZWjXH_p_BXy+eP7SvWhg@mail.gmail.com> <CAFqH_50s0J_NEevV9b5o-wq-bw+xGaUZ3WyhVDRZKyM2Yn-iVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqH_50s0J_NEevV9b5o-wq-bw+xGaUZ3WyhVDRZKyM2Yn-iVg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 05:45:15PM +0200, Enric Balletbo Serra wrote:
> Hi,
> 
> Missatge de Vasily Khoruzhick <anarsoul@gmail.com> del dia dl., 22 de
> jul. 2019 a les 20:50:
> >
> > On Mon, Jul 22, 2019 at 8:11 AM Torsten Duwe <duwe@lst.de> wrote:
> > >
> > > +module_i2c_driver(anx6345_driver);
> > > +
> > > +MODULE_DESCRIPTION("ANX6345 eDP Transmitter driver");
> > > +MODULE_AUTHOR("Enric Balletbo i Serra <enric.balletbo@collabora.com>");
> >
> > I believe Icenowy is the author of this driver. If you think otherwise
> > please add Enric to CC and get his Signed-off-by.
> >
> 
> I think that the only reason my name appears here is because is a
> copy/paste from analogix-anx78xx.c (probably this driver took that

Yes, this is the case.
You wrote / authored 500 lines of it, Icenowy about 300.

> file as a reference?). Indeed I am not the author of this driver, so
> Icenowy should be here, not me.

Very well. Thanks for this clear statement!

	Torsten

