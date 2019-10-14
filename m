Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61359ECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 11:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AB1320873
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 11:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571050811;
	bh=ZlGSWdazyQ+VJGnSWXQEMdj9sn2sA7OLQ6nosjRvcVs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Q/x9rBeDga/alpGMiCTnYxurE71crUt85BpfsAqs1OtvG1aJiu764kWpMq/0dIqxz
	 DPapp1mcp/Q/NX+omaHOZi03Ewcojhdvok4+V5vh+PEO+pnhR3OgXjwZ8Yvnj2cyIH
	 NPi2NLa5onkgpulYqSSfq+Jx63xSi5xqwdcR1yTY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731806AbfJNLAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 07:00:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:60764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731676AbfJNLAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 07:00:09 -0400
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61F9C207FF;
        Mon, 14 Oct 2019 11:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571050808;
        bh=ZlGSWdazyQ+VJGnSWXQEMdj9sn2sA7OLQ6nosjRvcVs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ARrkQrHoYCU2xerLQcqUwNA9j7VvNbBzkuJMrer7cqklB+5MhejFy6YoIEB7gUDGM
         6YyDja4j4e5cnKK6dFQ6VOGvaa+354POwCSP8t12y3RLqXS2cfH3RTWsEH6xX/09ob
         oeAR8H4mMIvyHAuu5DkVYaEWkuGPrvuF1n1qy8eU=
Date:   Mon, 14 Oct 2019 13:00:06 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Subject: Re: [PATCH v10 1/6] dt-bindings: sun6i-dsi: Add A64 MIPI-DSI
 compatible
Message-ID: <20191014110006.b324hccd52u7fotw@gilmour>
References: <20191005141913.22020-1-jagan@amarulasolutions.com>
 <20191005141913.22020-2-jagan@amarulasolutions.com>
 <20191007093122.ixrpzvy6ynh6vuir@gilmour>
 <CAMty3ZA1azP3kkJPw6oZudcSQksF6i+STeW=oOh65cfHsj0QrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ictolke544mhfqmp"
Content-Disposition: inline
In-Reply-To: <CAMty3ZA1azP3kkJPw6oZudcSQksF6i+STeW=oOh65cfHsj0QrQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ictolke544mhfqmp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Oct 13, 2019 at 10:32:18PM +0530, Jagan Teki wrote:
> On Mon, Oct 7, 2019 at 3:01 PM Maxime Ripard <mripard@kernel.org> wrote:
> >
> > On Sat, Oct 05, 2019 at 07:49:08PM +0530, Jagan Teki wrote:
> > > The MIPI DSI controller in Allwinner A64 is similar to A33.
> > >
> > > But unlike A33, A64 doesn't have DSI_SCLK gating so it is valid
> > > to with separate compatible for A64 on the same driver.
> > >
> > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > ---
> > >  .../bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml        | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml b/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml
> > > index dafc0980c4fa..cfcc84d38084 100644
> > > --- a/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml
> > > +++ b/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml
> > > @@ -15,7 +15,9 @@ properties:
> > >    "#size-cells": true
> > >
> > >    compatible:
> > > -    const: allwinner,sun6i-a31-mipi-dsi
> > > +    enum:
> > > +      - const: allwinner,sun6i-a31-mipi-dsi
> > > +      - const: allwinner,sun50i-a64-mipi-dsi
> >
> > How did you test this? It will report an error when running the
> > validation
>
> I did follow the v9 comments [1] and forgot to do dt-doc-validate.
> will send the v11 for this patch alone, will that be okay?
>
> [1] https://patchwork.freedesktop.org/patch/307499/

There's some changes to the DTSI to do as well, so please do them,
check that the device trees are validated properly, and send a new
version.

Maxime

--ictolke544mhfqmp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXaRVNgAKCRDj7w1vZxhR
xdlEAP9MkHQgcCclQKzguGiRxdmXCb+BVwkeOWiDgHEs4bDIXgD/eQbRbeTOq1NN
hIPooMFntNFWHosHxRdy9yw7y56jfg0=
=FNyg
-----END PGP SIGNATURE-----

--ictolke544mhfqmp--
