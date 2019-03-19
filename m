Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5B3C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 08:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F22720828
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 08:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbfCSIfm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 04:35:42 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:41053 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbfCSIfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 04:35:41 -0400
X-Originating-IP: 90.88.22.102
Received: from localhost (aaubervilliers-681-1-80-102.w90-88.abo.wanadoo.fr [90.88.22.102])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id E243CFF81A;
        Tue, 19 Mar 2019 08:35:36 +0000 (UTC)
Date:   Tue, 19 Mar 2019 09:35:36 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Chen-Yu Tsai <wens@csie.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-amarula@amarulasolutions.com
Subject: Re: [PATCH 4/6] dt-bindings: display: bridge: Add ICN6211 MIPI-DSI
 to RGB convertor bridge
Message-ID: <20190319083536.3ltcphubftwljnkv@flea>
References: <20190315130825.9005-1-jagan@amarulasolutions.com>
 <20190315130825.9005-5-jagan@amarulasolutions.com>
 <20190315133414.5zwc5qtrivrbrzow@flea>
 <CAMty3ZBn=MjB-VxwadkEDaM_==hGu1pzTv2A47cKitv0Vb5VXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xya52razlxraohjj"
Content-Disposition: inline
In-Reply-To: <CAMty3ZBn=MjB-VxwadkEDaM_==hGu1pzTv2A47cKitv0Vb5VXw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xya52razlxraohjj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 18, 2019 at 10:28:10PM +0530, Jagan Teki wrote:
> On Fri, Mar 15, 2019 at 7:04 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> >
> > On Fri, Mar 15, 2019 at 06:38:23PM +0530, Jagan Teki wrote:
> > > ICN6211 is MIPI-DSI/RGB converter bridge from chipone.
> > > It has a flexible configuration of MIPI DSI signal input
> > > and produce RGB565, RGB666, RGB888 output format.
> > >
> > > Add dt-bingings for it.
> > >
> > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > ---
> > >  .../display/bridge/chipone,icn6211.txt        | 36 +++++++++++++++++++
> > >  1 file changed, 36 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/display/bridge/chipone,icn6211.txt
> > >
> > > diff --git a/Documentation/devicetree/bindings/display/bridge/chipone,icn6211.txt b/Documentation/devicetree/bindings/display/bridge/chipone,icn6211.txt
> > > new file mode 100644
> > > index 000000000000..7f13efd7ee7f
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/display/bridge/chipone,icn6211.txt
> > > @@ -0,0 +1,36 @@
> > > +Chipone ICN6211 MIPI-DSI to RGB Convertor Bridge
> > > +
> > > +ICN6211 is MIPI-DSI/RGB converter bridge from chipone.
> > > +It has a flexible configuration of MIPI DSI signal input
> > > +and produce RGB565, RGB666, RGB888 output format.
> > > +
> > > +Required properties for RGB:
> > > +- compatible: must be "chipone,icn6211" and one of:
> > > +  * "bananapi,icn6211"
> >
> > Why is that compatible needed?
>
> chipone,icn6211 - generic compatible bridge controller IC
> bananapi,icn6211 -  compatible for icn6211 bridge using on bananapi panel
>
> I hope this would be proper bindings in terms of controller IC with
> associate device, anything wrong? Infact I used similar reference from
> Ilitek Bananapi panel from here
> Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.txt
>
> This is what I understood based on dt-binding, correct if I'm wrong.

The ILI9881c is an LCD controller, and it has some panel specific
configuration.

Does your bridge have board specific configuration?

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--xya52razlxraohjj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXJCp2AAKCRDj7w1vZxhR
xc0+AP4kBTWhE+HbFLHtDwT2CHATZKqvjT4ZfSVQKVmklha/wAEA2DrQF7uMkPmU
FHT7yxsm8m+SH2s1bvRUbbetRpMSFwU=
=sNtl
-----END PGP SIGNATURE-----

--xya52razlxraohjj--
