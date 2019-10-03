Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8BFC4CED1
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 13:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 632CA20700
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 13:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570109436;
	bh=/PbXIGt0UaMtnHakh0maKsJfjC9hWocWlO7+FUASxAs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zU6eeHPj8bV412NYfYwJVqTKPeYf1tJVMjumMRZeoRlWwrHObCPyRM/9WE8RRmTpA
	 Lgh0cWgDFnL+wjmnxNsmtuqd/qWrlLMT9+349LrgvwwwsliQnCx5s/EF1AY/2QEGdg
	 8hbAfH6DmolgJaP3zEUFYSY7Lpz3lxcWVGQ7r7eM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730454AbfJCNaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 09:30:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:48552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729655AbfJCNaf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 09:30:35 -0400
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87D85207FF;
        Thu,  3 Oct 2019 13:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570109434;
        bh=/PbXIGt0UaMtnHakh0maKsJfjC9hWocWlO7+FUASxAs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2QzvAZ+ZKgdOJ80qmd9SOJ5LSwKyk4G/pw5n8Gp/a2xELivFH5ULWHtb4eAgV9ans
         E48i9e22CPdnXQuE2n7GWOtdKqOw4VSGKA0OvZ19/QyJ2q0J6pwyokSdaw/GXyAOMy
         RBSZCDf5+Mji9yipjs10suznOE6Etm80OulAKWYY=
Date:   Thu, 3 Oct 2019 15:30:31 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     linux-arm-kernel@lists.infradead.org,
        Jagan Teki <jagan@amarulasolutions.com>,
        devicetree@vger.kernel.org, David Airlie <airlied@linux.ie>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>, Daniel Vetter <daniel@ffwll.ch>,
        michael@amarulasolutions.com
Subject: Re: [PATCH v11 4/7] dt-bindings: sun6i-dsi: Add VCC-DSI supply
 property
Message-ID: <20191003133031.gowixvfbdaif4sdf@gilmour>
References: <20191003064527.15128-1-jagan@amarulasolutions.com>
 <20191003064527.15128-5-jagan@amarulasolutions.com>
 <20191003114733.56mlar666l76uoyb@gilmour>
 <0086CD40-F161-4B33-8D76-8DCA20E7DB07@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xl6ox63chtxqzxbp"
Content-Disposition: inline
In-Reply-To: <0086CD40-F161-4B33-8D76-8DCA20E7DB07@aosc.io>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xl6ox63chtxqzxbp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 03, 2019 at 09:04:03PM +0800, Icenowy Zheng wrote:
> =E4=BA=8E 2019=E5=B9=B410=E6=9C=883=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=88=
7:47:33, Maxime Ripard <mripard@kernel.org> =E5=86=99=E5=88=B0:
> >On Thu, Oct 03, 2019 at 12:15:24PM +0530, Jagan Teki wrote:
> >> Allwinner MIPI DSI controllers are supplied with SoC DSI
> >> power rails via VCC-DSI pin.
> >>
> >> Some board still work without supplying this but give more
> >> faith on datasheet and hardware schematics and document this
> >> supply property in required property list.
> >>
> >> Reviewed-by: Rob Herring <robh@kernel.org>
> >> Tested-by: Merlijn Wajer <merlijn@wizzup.org>
> >> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> >> ---
> >>  .../bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml         | 3
> >+++
> >>  1 file changed, 3 insertions(+)
> >>
> >> diff --git
> >a/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi=
=2Eyaml
> >b/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi=
=2Eyaml
> >> index 47950fced28d..9d4c25b104f6 100644
> >> ---
> >a/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi=
=2Eyaml
> >> +++
> >b/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi=
=2Eyaml
> >> @@ -36,6 +36,9 @@ properties:
> >>    resets:
> >>      maxItems: 1
> >>
> >> +  vcc-dsi-supply:
> >> +    description: VCC-DSI power supply of the DSI encoder
> >> +
> >
> >The driver treats it as mandatory, so I've added it to the binding, as
> >suggested by the commit log.
>
> No. The regulator_get function will return dummy regulator, rather than
> fail, if the regulator is not specified.

Yes. And this deals nicely with the backward compatibility case. The
regulator is there on all the SoCs, so there's no reason to leave it
out.

Maxime

--xl6ox63chtxqzxbp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXZX39wAKCRDj7w1vZxhR
xfdtAP9iY02ClBdX7PytSYTVv7u9rk5qFxNbRhfligYsza6diwEA+bXtRpDjiCDy
YsfwN2Wm3Vvp2K/WtdvzfKezGk0WpAo=
=iYP9
-----END PGP SIGNATURE-----

--xl6ox63chtxqzxbp--
