Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D9A9C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 13:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4381820854
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 13:34:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729137AbfCONeV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 09:34:21 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:60147 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727705AbfCONeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 09:34:21 -0400
X-Originating-IP: 185.94.189.187
Received: from localhost (unknown [185.94.189.187])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 7644B60006;
        Fri, 15 Mar 2019 13:34:15 +0000 (UTC)
Date:   Fri, 15 Mar 2019 14:34:14 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Chen-Yu Tsai <wens@csie.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@googlegroups.com, linux-amarula@amarulasolutions.com
Subject: Re: [PATCH 4/6] dt-bindings: display: bridge: Add ICN6211 MIPI-DSI
 to RGB convertor bridge
Message-ID: <20190315133414.5zwc5qtrivrbrzow@flea>
References: <20190315130825.9005-1-jagan@amarulasolutions.com>
 <20190315130825.9005-5-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ju6ym54ol55b4fyp"
Content-Disposition: inline
In-Reply-To: <20190315130825.9005-5-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ju6ym54ol55b4fyp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2019 at 06:38:23PM +0530, Jagan Teki wrote:
> ICN6211 is MIPI-DSI/RGB converter bridge from chipone.
> It has a flexible configuration of MIPI DSI signal input
> and produce RGB565, RGB666, RGB888 output format.
>=20
> Add dt-bingings for it.
>=20
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  .../display/bridge/chipone,icn6211.txt        | 36 +++++++++++++++++++
>  1 file changed, 36 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/chip=
one,icn6211.txt
>=20
> diff --git a/Documentation/devicetree/bindings/display/bridge/chipone,icn=
6211.txt b/Documentation/devicetree/bindings/display/bridge/chipone,icn6211=
=2Etxt
> new file mode 100644
> index 000000000000..7f13efd7ee7f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/chipone,icn6211.txt
> @@ -0,0 +1,36 @@
> +Chipone ICN6211 MIPI-DSI to RGB Convertor Bridge
> +
> +ICN6211 is MIPI-DSI/RGB converter bridge from chipone.
> +It has a flexible configuration of MIPI DSI signal input
> +and produce RGB565, RGB666, RGB888 output format.
> +
> +Required properties for RGB:
> +- compatible: must be "chipone,icn6211" and one of:
> +  * "bananapi,icn6211"

Why is that compatible needed?

> +- reg: the virtual channel number of a DSI peripheral
> +- reset-gpios: a GPIO phandle for the reset pin
> +
> +The device node can contain following 'port' child nodes,
> +according to the OF graph bindings defined in [1]:
> +  0: DSI Input, not required, if the bridge is DSI controlled
> +  1: RGB Output, mandatory

Your example doesn't have that input port

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--ju6ym54ol55b4fyp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXIup1gAKCRDj7w1vZxhR
xZxKAQDnfSaDiaZESJJHJ1oX0BmcqZXLmY4m6JHNcDhXqUZZ2AEAiPziF6Gby8Tf
uKTb2+tCIof19wZJWdLzoTUc8LQTDwE=
=K68j
-----END PGP SIGNATURE-----

--ju6ym54ol55b4fyp--
