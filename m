Return-Path: <SRS0=ztpy=2L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C96D9C2D0D2
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 16:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9096B21927
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 16:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576944129;
	bh=9Pvao+jXX0PCNDC7N1F3k9oHnH1BnDFD/aI52kgxil8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AXBqNhoEHkqn6XAOY3Dh8cDsQ06EtEHTmYMRL66l2A6a1Oioq63LMdOaIKleADRMg
	 PX/qooah5YmKtiNOADzjb7Ll+i8myrF8+CCMbhL2tcW3sShZ/Q2h9fuzGjghNxVpBk
	 IyJOEKLflyjvkiSj26jmAfB0swhMmFak0Jh2Q+GQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfLUQCI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Dec 2019 11:02:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:40832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726107AbfLUQCI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Dec 2019 11:02:08 -0500
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0AE42072B;
        Sat, 21 Dec 2019 16:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576944126;
        bh=9Pvao+jXX0PCNDC7N1F3k9oHnH1BnDFD/aI52kgxil8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qSSL64IGSgg1gGqNQWkYp0zn6HAB8AervjDy2k1DqBZyJ1I/L7b8g4+sOhv01HQSR
         9L5Vff2aLXleaIQzahSUu6hHRwAKRzo/LY98TUKK1nz4zAmDHByHwTz8MWyA2d8ywW
         tIEv1JULX5cMRsn4vWtR54GeX2M0ctCcbiwxWQ64=
Date:   Sat, 21 Dec 2019 17:02:03 +0100
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
        devicetree <devicetree@vger.kernel.org>,
        linux-amarula <linux-amarula@amarulasolutions.com>
Subject: Re: [PATCH v13 4/7] drm/sun4i: dsi: Handle bus clock via
 regmap_mmio_attach_clk
Message-ID: <20191221160203.sokdonzswd6as4ed@gilmour.lan>
References: <20191218191017.2895-1-jagan@amarulasolutions.com>
 <20191218191017.2895-5-jagan@amarulasolutions.com>
 <20191218220536.vwww45yctm5ye3vg@gilmour.lan>
 <CAMty3ZDgnn0LyGVYmzQhTtg7JdiqH_cW_dZ=o2SA1NSF=i2ufg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="t7kehamjyxpiwads"
Content-Disposition: inline
In-Reply-To: <CAMty3ZDgnn0LyGVYmzQhTtg7JdiqH_cW_dZ=o2SA1NSF=i2ufg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--t7kehamjyxpiwads
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Dec 21, 2019 at 05:11:00PM +0530, Jagan Teki wrote:
> On Thu, Dec 19, 2019 at 3:35 AM Maxime Ripard <mripard@kernel.org> wrote:
> >
> > On Thu, Dec 19, 2019 at 12:40:14AM +0530, Jagan Teki wrote:
> > > regmap has special API to enable the controller bus clock while
> > > initializing register space, and current driver is using
> > > devm_regmap_init_mmio_clk which require to specify bus
> > > clk_id argument as "bus"
> > >
> > > But, the usage of clocks are varies between different Allwinner
> > > DSI controllers. Clocking in A33 would need bus and mod clocks
> > > where as A64 would need only bus clock.
> > >
> > > Since A64 support only single bus clock, it is optional to
> > > specify the clock-names on the controller device tree node.
> > > So using NULL on clk_id would get the attached clock.
> > >
> > > To support clk_id as "bus" and "NULL" during clock enablement
> > > between controllers, this patch add generic code to handle
> > > the bus clock using regmap_mmio_attach_clk with associated
> > > regmap APIs.
> > >
> > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > ---
> > > Changes for v13:
> > > - update the changes since has_mod_clk is dropped in previous patch
> > >
> > >  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 45 +++++++++++++++++++++-----
> > >  1 file changed, 37 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > > index 68b88a3dc4c5..de8955fbeb00 100644
> > > --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > > +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > > @@ -1081,6 +1081,7 @@ static const struct component_ops sun6i_dsi_ops = {
> > >  static int sun6i_dsi_probe(struct platform_device *pdev)
> > >  {
> > >       struct device *dev = &pdev->dev;
> > > +     const char *bus_clk_name = NULL;
> > >       struct sun6i_dsi *dsi;
> > >       struct resource *res;
> > >       void __iomem *base;
> > > @@ -1094,6 +1095,10 @@ static int sun6i_dsi_probe(struct platform_device *pdev)
> > >       dsi->host.ops = &sun6i_dsi_host_ops;
> > >       dsi->host.dev = dev;
> > >
> > > +     if (of_device_is_compatible(dev->of_node,
> > > +                                 "allwinner,sun6i-a31-mipi-dsi"))
> > > +             bus_clk_name = "bus";
> > > +
> > >       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > >       base = devm_ioremap_resource(dev, res);
> > >       if (IS_ERR(base)) {
> > > @@ -1107,25 +1112,36 @@ static int sun6i_dsi_probe(struct platform_device *pdev)
> > >               return PTR_ERR(dsi->regulator);
> > >       }
> > >
> > > -     dsi->regs = devm_regmap_init_mmio_clk(dev, "bus", base,
> > > -                                           &sun6i_dsi_regmap_config);
> > > -     if (IS_ERR(dsi->regs)) {
> > > -             dev_err(dev, "Couldn't create the DSI encoder regmap\n");
> > > -             return PTR_ERR(dsi->regs);
> > > -     }
> > > -
> > >       dsi->reset = devm_reset_control_get_shared(dev, NULL);
> > >       if (IS_ERR(dsi->reset)) {
> > >               dev_err(dev, "Couldn't get our reset line\n");
> > >               return PTR_ERR(dsi->reset);
> > >       }
> > >
> > > +     dsi->regs = devm_regmap_init_mmio(dev, base, &sun6i_dsi_regmap_config);
> > > +     if (IS_ERR(dsi->regs)) {
> > > +             dev_err(dev, "Couldn't init regmap\n");
> > > +             return PTR_ERR(dsi->regs);
> > > +     }
> > > +
> > > +     dsi->bus_clk = devm_clk_get(dev, bus_clk_name);
> > > +     if (IS_ERR(dsi->bus_clk)) {
> > > +             dev_err(dev, "Couldn't get the DSI bus clock\n");
> > > +             ret = PTR_ERR(dsi->bus_clk);
> > > +             goto err_regmap;
> > > +     } else {
> > > +             ret = regmap_mmio_attach_clk(dsi->regs, dsi->bus_clk);
> > > +             if (ret)
> > > +                     goto err_bus_clk;
> > > +     }
> > > +
> > >       if (of_device_is_compatible(dev->of_node,
> > >                                   "allwinner,sun6i-a31-mipi-dsi")) {
> > >               dsi->mod_clk = devm_clk_get(dev, "mod");
> > >               if (IS_ERR(dsi->mod_clk)) {
> > >                       dev_err(dev, "Couldn't get the DSI mod clock\n");
> > > -                     return PTR_ERR(dsi->mod_clk);
> > > +                     ret = PTR_ERR(dsi->mod_clk);
> > > +                     goto err_attach_clk;
> > >               }
> > >       }
> > >
> > > @@ -1164,6 +1180,14 @@ static int sun6i_dsi_probe(struct platform_device *pdev)
> > >       pm_runtime_disable(dev);
> > >  err_unprotect_clk:
> > >       clk_rate_exclusive_put(dsi->mod_clk);
> > > +err_attach_clk:
> > > +     if (!IS_ERR(dsi->bus_clk))
> > > +             regmap_mmio_detach_clk(dsi->regs);
> > > +err_bus_clk:
> > > +     if (!IS_ERR(dsi->bus_clk))
> > > +             clk_put(dsi->bus_clk);
> >
> > You still have an unbalanced clk_get / clk_put here
>
> You mean it is not needed right since devm_clk_get has release call
> via devres_alloc?

Yes

--t7kehamjyxpiwads
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXf5B+wAKCRDj7w1vZxhR
xZM9AQCrafDvLwSSlNcQULuicORIzPWMazFjtacua+XGYDocXgD/Q1jWoH3YVfv+
Vg1KN3sfbAmPOOzkStNmyhh1eKgi9wM=
=b8tT
-----END PGP SIGNATURE-----

--t7kehamjyxpiwads--
