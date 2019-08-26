Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF34C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 10:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62D942186A
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 10:16:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="uyvLe2AQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731346AbfHZKQC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 06:16:02 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:45924 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731306AbfHZKP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 06:15:59 -0400
Received: from pendragon.ideasonboard.com (dfj612yhrgyx302h3jwwy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:ce28:277f:58d7:3ca4])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id D4EE731B;
        Mon, 26 Aug 2019 12:15:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1566814557;
        bh=9wZSzYHEKtzlGccYoNBaQM5/r5uiiDKyUx0xfquMNBM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uyvLe2AQoJzdJ3a+hqTNdkz1kiuJHyq90GBzU82SftccR9ETTjypUnKh5WGKh3DPQ
         XJbEq+4MyWenoNDZWKweCjlylTnbe/CfH6HJr0A80djtxztDj2j1L0XXUnpLLmwDn6
         pV+EB/Ug5xi0/r8KUu2H5seKFRPZG3xSg3Lu5fyk=
Date:   Mon, 26 Aug 2019 13:15:50 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Simon Horman <horms@verge.net.au>, Ulrich Hecht <uli@fpond.eu>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Koji Matsuoka <koji.matsuoka.xm@renesas.com>, muroya@ksk.co.jp,
        VenkataRajesh.Kalakodima@in.bosch.com,
        Harsha.ManjulaMallikarjun@in.bosch.com,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v3 01/14] dt-bindings: display: renesas,cmm: Add R-Car
 CMM documentation
Message-ID: <20190826101550.GB5031@pendragon.ideasonboard.com>
References: <20190825135154.11488-1-jacopo+renesas@jmondi.org>
 <20190825135154.11488-2-jacopo+renesas@jmondi.org>
 <CAMuHMdVvjrMXap5CQ-grNYpJfOG6QeN26EW4tR_YE=VFv5ozqw@mail.gmail.com>
 <20190826075943.h7ivwagape3glym5@uno.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190826075943.h7ivwagape3glym5@uno.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacopo,

On Mon, Aug 26, 2019 at 09:59:43AM +0200, Jacopo Mondi wrote:
> On Mon, Aug 26, 2019 at 09:34:41AM +0200, Geert Uytterhoeven wrote:
> > On Sun, Aug 25, 2019 at 3:50 PM Jacopo Mondi <jacopo+renesas@jmondi.org> wrote:
> > > Add device tree bindings documentation for the Renesas R-Car Display
> > > Unit Color Management Module.
> > >
> > > CMM is the image enhancement module available on each R-Car DU video
> > > channel on R-Car Gen2 and Gen3 SoCs (V3H and V3M excluded).
> > >
> > > Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> >
> > Thanks for your patch!
> >
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/display/renesas,cmm.txt
> > > @@ -0,0 +1,33 @@
> > > +* Renesas R-Car Color Management Module (CMM)
> > > +
> > > +Renesas R-Car image enhancement module connected to R-Car DU video channels.
> > > +
> > > +Required properties:
> > > + - compatible: shall be one or more of the following:
> > > +   - "renesas,cmm-r8a7795": for R8A7795 (R-Car H3) compatible CMM.
> > > +   - "renesas,cmm-r8a7796": for R8A7796 (R-Car M3-W) compatible CMM.
> > > +   - "renesas,cmm-r8a77965": for R8A77965 (R-Car M3-N) compatible CMM.
> > > +   - "renesas,cmm-r8a77990": for R8A77990 (R-Car E3) compatible CMM.
> > > +   - "renesas,cmm-r8a77995": for R8A77995 (R-Car D3) compatible CMM.
> >
> > Please use "renesas,<socype->-cmm" instead of "renesas,cmm-<soctype>".
> 
> I actually copied it from the r-car gpio bindings, and I liked
> cmm-<soctype> better. If you prefer I can change it though.
> 
> > > +   - "renesas,rcar-gen3-cmm": for a generic R-Car Gen3 compatible CMM.
> > > +   - "renesas,rcar-gen2-cmm": for a generic R-Car Gen2 compatible CMM.
> > > +
> > > +   When the generic compatible string is specified, the SoC-specific
> > > +   version corresponding to the platform should be listed first.
> > > +
> > > + - reg: the address base and length of the memory area where CMM control
> > > +   registers are mapped to.
> > > +
> > > + - clocks: phandle and clock-specifier pair to the CMM functional clock
> > > +   supplier.
> >
> > Thinking about yaml validation:
> >
> > power-domains?
> > resets?
> 
> They should indeed be documented.

How about converting this binding to yaml alreay ? It should be fairly
simple.

> > > +Example:
> > > +--------
> > > +
> > > +       cmm0: cmm@fea40000 {
> > > +               compatible = "renesas,cmm-r8a7796";
> > > +               reg = <0 0xfea40000 0 0x1000>;
> > > +               power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
> > > +               clocks = <&cpg CPG_MOD 711>;
> > > +               resets = <&cpg 711>;
> > > +       };

-- 
Regards,

Laurent Pinchart
