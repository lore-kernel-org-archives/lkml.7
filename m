Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57054C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 11:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CBAE218DE
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 11:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570103202;
	bh=rZXyTCe8Ve7vHC9DAOD50UwJrWsPWN27OLElnsbF2ak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cqKTyMl9sUiH5k1CtFWQaoAOlG6dO8PaUB1Cn2MyopmTVFsT8FAaXJoFaLYApfpCn
	 V6FYmxL1rSpX5T823Ih/+IjYMWN9D6jHhWDPjdC2e6mWMmqIbT6wvD4QK2qMEfWG2s
	 RVpQQKdLDXwlLWLZfzHXrxsy9gVyrF0cH7snQjEc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730154AbfJCLql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 07:46:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:34634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729823AbfJCLql (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 07:46:41 -0400
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 219D02070B;
        Thu,  3 Oct 2019 11:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570103199;
        bh=rZXyTCe8Ve7vHC9DAOD50UwJrWsPWN27OLElnsbF2ak=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fk9TfOQdKkrfXA+BV72LZAo2ee2u/I18By1yu0xrL3XqvxyZjSzev1gLHO9UUztUu
         6NIe7cp3hszcjq6mMOIgl4++kDKGi7oJEcY1Iy7Fx2FawPbfs9RVn3LDu2TFYf1Ky8
         j0SbtjERUcdTGZg6ppk9VV0F1amb0UDG6Ku7c2RQ=
Date:   Thu, 3 Oct 2019 13:46:37 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Subject: Re: [PATCH v11 5/7] drm/sun4i: sun6i_mipi_dsi: Add VCC-DSI regulator
 support
Message-ID: <20191003114637.qd723p4jviwbns26@gilmour>
References: <20191003064527.15128-1-jagan@amarulasolutions.com>
 <20191003064527.15128-6-jagan@amarulasolutions.com>
 <CAGb2v64RJeHXSDknPvH3RrDLqPzSvR-p2k2vA73Zt1xsOd5TSw@mail.gmail.com>
 <CAMty3ZBmY+wZ4MZD1ipjnfhVy3gBRCqsAXGqF79mo+eaX=L2fA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sioambykdk554e5i"
Content-Disposition: inline
In-Reply-To: <CAMty3ZBmY+wZ4MZD1ipjnfhVy3gBRCqsAXGqF79mo+eaX=L2fA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sioambykdk554e5i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 03, 2019 at 12:31:31PM +0530, Jagan Teki wrote:
> On Thu, Oct 3, 2019 at 12:26 PM Chen-Yu Tsai <wens@csie.org> wrote:
> >
> > On Thu, Oct 3, 2019 at 2:46 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
> > >
> > > Allwinner MIPI DSI controllers are supplied with SoC
> > > DSI power rails via VCC-DSI pin.
> > >
> > > Add support for this supply pin by adding voltage
> > > regulator handling code to MIPI DSI driver.
> > >
> > > Tested-by: Merlijn Wajer <merlijn@wizzup.org>
> > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > ---
> > >  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 14 ++++++++++++++
> > >  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h |  2 ++
> > >  2 files changed, 16 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > > index 446dc56cc44b..fe9a3667f3a1 100644
> > > --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > > +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > > @@ -1110,6 +1110,12 @@ static int sun6i_dsi_probe(struct platform_device *pdev)
> > >                 return PTR_ERR(base);
> > >         }
> > >
> > > +       dsi->regulator = devm_regulator_get(dev, "vcc-dsi");
> > > +       if (IS_ERR(dsi->regulator)) {
> > > +               dev_err(dev, "Couldn't get VCC-DSI supply\n");
> > > +               return PTR_ERR(dsi->regulator);
> > > +       }
> > > +
> > >         dsi->regs = devm_regmap_init_mmio_clk(dev, "bus", base,
> > >                                               &sun6i_dsi_regmap_config);
> > >         if (IS_ERR(dsi->regs)) {
> > > @@ -1183,6 +1189,13 @@ static int sun6i_dsi_remove(struct platform_device *pdev)
> > >  static int __maybe_unused sun6i_dsi_runtime_resume(struct device *dev)
> > >  {
> > >         struct sun6i_dsi *dsi = dev_get_drvdata(dev);
> > > +       int err;
> > > +
> > > +       err = regulator_enable(dsi->regulator);
> > > +       if (err) {
> > > +               dev_err(dsi->dev, "failed to enable VCC-DSI supply: %d\n", err);
> > > +               return err;
> > > +       }
> > >
> > >         reset_control_deassert(dsi->reset);
> > >         clk_prepare_enable(dsi->mod_clk);
> > > @@ -1215,6 +1228,7 @@ static int __maybe_unused sun6i_dsi_runtime_suspend(struct device *dev)
> > >
> > >         clk_disable_unprepare(dsi->mod_clk);
> > >         reset_control_assert(dsi->reset);
> > > +       regulator_disable(dsi->regulator);
> > >
> > >         return 0;
> > >  }
> > > diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
> > > index 5c3ad5be0690..a01d44e9e461 100644
> > > --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
> > > +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
> > > @@ -12,6 +12,7 @@
> > >  #include <drm/drm_connector.h>
> > >  #include <drm/drm_encoder.h>
> > >  #include <drm/drm_mipi_dsi.h>
> > > +#include <linux/regulator/consumer.h>
> >
> > You don't need to include the header file since you are only
> > including a pointer to the struct, and nothing else.
>
> Yes, make sense. I will drop it.
>
> >
> > Otherwise,
> >
> > Reviewed-by: Chen-Yu Tsai <wens@csie.org>
>
> thanks.

I've moved the include to the driver that was lacking it while
applying, thanks!

Maxime

--sioambykdk554e5i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXZXfnQAKCRDj7w1vZxhR
xdo1AP9qbRxlDAMsATrfD1TcpRGv8AL/+bvjh0JOK0bF9TnEsAD/cPQeOM7j0eND
SGuUJnDS/wwejedPPPjCzS3+gawyeQo=
=fbpL
-----END PGP SIGNATURE-----

--sioambykdk554e5i--
