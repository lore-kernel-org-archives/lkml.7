Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CC3C010B4
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 10:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 043732190F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 10:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730805AbfKEK6N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 05:58:13 -0500
Received: from verein.lst.de ([213.95.11.211]:44725 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726867AbfKEK6M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 05:58:12 -0500
Received: by verein.lst.de (Postfix, from userid 2005)
        id 820FA68B05; Tue,  5 Nov 2019 11:58:08 +0100 (CET)
Date:   Tue, 5 Nov 2019 11:58:08 +0100
From:   Torsten Duwe <duwe@lst.de>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Sean Paul <seanpaul@chromium.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Harald Geyer <harald@ccbib.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 6/7] dt-bindings: Add ANX6345 DP/eDP transmitter
 binding
Message-ID: <20191105105808.GA27999@lst.de>
References: <20191104110400.F319F68BE1@verein.lst.de> <20191104110613.C3BA468C4E@verein.lst.de> <20191105104342.GD3876@gilmour.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191105104342.GD3876@gilmour.lan>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05, 2019 at 11:43:42AM +0100, Maxime Ripard wrote:
> 
> On Tue, Oct 29, 2019 at 01:16:57PM +0100, Torsten Duwe wrote:
> > The anx6345 is an ultra-low power DisplayPort/eDP transmitter designed
> > for portable devices.
> >
> > Add a binding document for it.
> >
> > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Torsten Duwe <duwe@suse.de>
> > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> Applied, thanks

Re-thanks!

> (still, there's one comment below that can be addressed in a
> subsequent patch).
> 
> > +
> > +  ports:
> > +    type: object
> > +
> > +    properties:
> > +      port@0:
> > +        type: object
> > +        description: |
> > +          Video port for LVTTL input
> > +
> > +      port@1:
> > +        type: object
> > +        description: |
> > +          Video port for eDP output (panel or connector).
> > +          May be omitted if EDID works reliably.
> > +
> > +    required:
> > +      - port@0
> 
> You should have something like:
> 
> ports:
>   type: object
>   additionalProperties: false
> 
> as well...

Yes, and it also struck me that I forgot at least about the hotplug-gpio.
It's unused on the Teres and the Pinebook, but in theory it's a valid
property, which can't be added any more now.

	Torsten

