Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F96C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 14:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ACB6206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 14:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbfG2OXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 10:23:04 -0400
Received: from verein.lst.de ([213.95.11.211]:40322 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726327AbfG2OXE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 10:23:04 -0400
Received: by verein.lst.de (Postfix, from userid 2005)
        id E55C468AEF; Mon, 29 Jul 2019 16:22:58 +0200 (CEST)
Date:   Mon, 29 Jul 2019 16:22:58 +0200
From:   Torsten Duwe <duwe@lst.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Mark Rutland <mark.rutland@arm.com>,
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
Subject: Re: [PATCH v3 6a/7] dt-bindings: Add ANX6345 DP/eDP transmitter
 binding
Message-ID: <20190729142258.GB7946@lst.de>
References: <20190722150414.9F97668B20@verein.lst.de> <20190725151829.DC20968B02@verein.lst.de> <20190726163601.o32bxqew5xavjgyi@flea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190726163601.o32bxqew5xavjgyi@flea>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 06:36:01PM +0200, Maxime Ripard wrote:
> > +
> > +  dvdd12-supply:
> > +    maxItems: 1
> > +    description: Regulator for 1.2V digital core power.
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +
> > +  dvdd25-supply:
> > +    maxItems: 1
> > +    description: Regulator for 2.5V digital core power.
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> 
> There's no need to specify the type here, all the properties ending in
> -supply are already checked for that type

Ok, thanks for the hint.

> > +  ports:
> > +    type: object
> > +    minItems: 1
> > +    maxItems: 2
> > +    description: |
> > +      Video port 0 for LVTTL input,
> > +      Video port 1 for eDP output (panel or connector)
> > +      using the DT bindings defined in
> > +      Documentation/devicetree/bindings/media/video-interfaces.txt
> 
> You should probably describe the port@0 and port@1 nodes here as
> well. It would allow you to express that the port 0 is mandatory and
> the port 1 optional, which got dropped in the conversion.

I would have liked to, but have not discovered yet a comprehensive source
of information about recommended syntax and semantics of the YAML schemes.

Is there some central reference for these types of issues? I mean not the
"here is a git repo with the meta-schemes" but sort of a cookbook?

	Torsten


