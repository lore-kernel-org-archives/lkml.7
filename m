Return-Path: <SRS0=Ba5y=Y3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C19DFCA9EBB
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 16:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99425214D9
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 16:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572796880;
	bh=Lpq9fn2fii7gBSLXJ89Ao8eK1QO7fC9NIhZkf0eEtYA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=T+qViEPL1Pl37EKnskMhAZnGLaYsriEAEqJu0BXq47g7Gb1w95w4iXEKzMz9wFFDK
	 TwFGr+OhVMc03VHoIMWKBwMIdLlMa6GaGhEyV02rXNBOAGyip1mpAnflruLsoHsdpW
	 gyyF/KADjFxX54JMA2souJsyhcz9f0Q2WHROWwe0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbfKCQBT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 11:01:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:39186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727523AbfKCQBS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 11:01:18 -0500
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04CCD2084D;
        Sun,  3 Nov 2019 16:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572796877;
        bh=Lpq9fn2fii7gBSLXJ89Ao8eK1QO7fC9NIhZkf0eEtYA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OCwDFQkWKusxtKXsxi91PdS4FMndv/PZ40OLVWxDDGqjae8h/Dw/eR2w/CFWnlCiF
         05LMTf6JN+eJiF+Asn1yAmFM6COsnzFFyJfRcI32IyI//GopKIp2PAbknEArZTo53t
         8EvQSINAYXMGp654yYfuaWc8jOv6b5LkCNJF2Nxs=
Date:   Sun, 3 Nov 2019 17:01:14 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Torsten Duwe <duwe@lst.de>
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
Subject: Re: [PATCH v4 6/7] dt-bindings: Add ANX6345 DP/eDP transmitter
 binding
Message-ID: <20191103160114.GD7001@gilmour>
References: <20191029153815.C631668C4E@verein.lst.de>
 <20191029153953.8EE9B68D04@verein.lst.de>
 <20191031125100.qprbdaaysg3tmhif@hendrix>
 <20191031145224.GA5973@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="O3RTKUHj+75w1tg5"
Content-Disposition: inline
In-Reply-To: <20191031145224.GA5973@lst.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--O3RTKUHj+75w1tg5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 31, 2019 at 03:52:24PM +0100, Torsten Duwe wrote:
> On Thu, Oct 31, 2019 at 01:51:00PM +0100, Maxime Ripard wrote:
> > On Tue, Oct 29, 2019 at 01:16:57PM +0100, Torsten Duwe wrote:
> > > +
> > > +  ports:
> > > +    anyOf:
> > > +      - port@0:
> > > +        description: Video port for LVTTL input
> > > +      - port@1:
> > > +        description: Video port for eDP output (panel or connector).
> > > +                     May be omitted if EDID works reliably.
> > > +    required:
> > > +      - port@0
> >
> > Have you tried to validate those two ports in a DT?
>
> Yes, it validates as expected, like I wrote. Various sources told me that
> json-schema is not always straightforward so I assumed anyOf was OK.
>
> > I'm not quite sure what you wanted to express with that anyOf, but if
> > it was something like port@0 is mandatory, and port@1 is optional, it
> > should be something like this:
> >
> > properties:
> >
> >   ...
> >
> >   ports:
> >     type: object
> >
> >     properties:
> >       port@0:
> >         type: object
> >         description: |
> > 	  Video port for LVTTL input
> >
> >       port@1:
> >         type: object
> >         description: |
> > 	  Video port for eDP output (..)
> >
> >     required:
> >       - port@0
> >
> > This way, you express that both port@0 and port@1 must by nodes, under
> > a node called ports, and port@0 is mandatory.
>
> That validates, too. Looks better, admittedly. I don't have a strong
> opinion here. It's just that Rob wrote in
> <CAL_JsqKAU3WG3L=KP8A8u4vW=q_BQWPN-m_c+ADOwTioJ2-cmg@mail.gmail.com>:
>
> | For this case specifically, we do need to define a common graph
> | schema, but haven't yet. You can assume we do and only really need to
> | capture what Maxime said above.
> (your points back then were port@N descriptions and neccessity for port@0)
>
> Are you sure that "object" is specific enough?

Possibly not, but at least it checks that there's indeed something
called port@0 (and port@1), and that they are both nodes (and not
properties).

We can probably refine this further, but this is good enough at the
moment.

> > You should even push this a bit further by adding
> > additionalProperties: false to prevent a DT from having undocumented
> > properties and children for the main node and ports node.
>
> You mean like
>
> | jsonschema.exceptions.SchemaError: Additional properties are not allowed ('unevaluatedProperties' was unexpected)
> [...]
> | On schema:
> |    {'$id': 'http://devicetree.org/schemas/watchdog/allwinner,sun4i-a10-wdt.yaml#',
> [...]
> |      'unevaluatedProperties': False}
>
> ? ;-)

That would be on the meta-schema, but yes, we want to trigger warnings
on something that isn't described.

>
> But yes, this patch series passes even with additionalProperties: false.
>
> In which form would you like to receive the update?

Please send a new version.

Thanks!
Maxime

--O3RTKUHj+75w1tg5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXb75ygAKCRDj7w1vZxhR
xQ7rAQCZLQcuukaEIuQQut4PC1tgBMKrdJ+kUMMrTujJsMh0KAD/XxEP4qvCHVOh
pyNiY1VTEuJDPf//SnH0gq+kzuonjQ8=
=cdL1
-----END PGP SIGNATURE-----

--O3RTKUHj+75w1tg5--
