Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7798C4CEC4
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 18:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91C3D21A49
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 18:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568917122;
	bh=TCa764fDVm0BUS6jXDj8jA5f2AYG6d9jG3RP2yK6Qgg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=S2LwK84VaomUWTkH/fkmcyg6H8zaCWtKcmjvSYkqNysUe2oVFm8C+91PnDJchZQZs
	 TyH9YtWdDHH8B+YPhYeF8ox3/ezq/nyYLhZrFcScTtezLmII3v434CLwRgS+zL4Db4
	 eQI/uqQJuc4YRrEFjaMftlaHcp63y47Ftq4BCd/g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732645AbfISSSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 14:18:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:54956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732583AbfISSSl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 14:18:41 -0400
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CEEA21928;
        Thu, 19 Sep 2019 18:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568917119;
        bh=TCa764fDVm0BUS6jXDj8jA5f2AYG6d9jG3RP2yK6Qgg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K8lPzaOs5uyswM5REgjEu/RUFpspu42cKGkuvs/ihehMn4NjIoqOcdyAN505ZZ700
         PWs5ixGmCLcsweiD7ajKJO52oDKH9L5Eq01aWAC9Ey/nF8LA3e2OK3oBU1W6LB7NwD
         N4xHYVc6nA5ef4YDOdpicOZD/WNqJfleo5hkvsKo=
Date:   Thu, 19 Sep 2019 20:18:37 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Jernej Skrabec <jernej.skrabec@siol.net>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: [linux-sunxi] [PATCH] clk: sunxi-ng: h6: Use sigma-delta
 modulation for audio PLL
Message-ID: <20190919181837.yuhmqnojxpoqp35a@gilmour>
References: <20190914135100.327412-1-jernej.skrabec@siol.net>
 <CAGb2v640R7edA3EJvC=aJQZXGcfqot50O3-PFyrYj767pUEYrQ@mail.gmail.com>
 <8129141.yvSaxnLE4m@jernej-laptop>
 <CAGb2v65KQf_OX1sX9+4DAKKMKHP464cCZKjCRsn3LzTKRGLTcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pfkcvjqh5wmcwf4x"
Content-Disposition: inline
In-Reply-To: <CAGb2v65KQf_OX1sX9+4DAKKMKHP464cCZKjCRsn3LzTKRGLTcQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pfkcvjqh5wmcwf4x
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 18, 2019 at 01:46:34PM +0800, Chen-Yu Tsai wrote:
> On Wed, Sep 18, 2019 at 1:21 PM Jernej =C5=A0krabec <jernej.skrabec@siol.=
net> wrote:
> >
> > Dne torek, 17. september 2019 ob 08:54:08 CEST je Chen-Yu Tsai napisal(=
a):
> > > On Sat, Sep 14, 2019 at 9:51 PM Jernej Skrabec <jernej.skrabec@siol.n=
et>
> > wrote:
> > > > Audio devices needs exact clock rates in order to correctly reprodu=
ce
> > > > the sound. Until now, only integer factors were used to configure H6
> > > > audio PLL which resulted in inexact rates. Fix that by adding suppo=
rt
> > > > for fractional factors using sigma-delta modulation look-up table. =
It
> > > > contains values for two most commonly used audio base frequencies.
> > > >
> > > > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > > > ---
> > > >
> > > >  drivers/clk/sunxi-ng/ccu-sun50i-h6.c | 21 +++++++++++++++------
> > > >  1 file changed, 15 insertions(+), 6 deletions(-)
> > > >
> > > > diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
> > > > b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c index d89353a3cdec..ed6338d7=
4474
> > > > 100644
> > > > --- a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
> > > > +++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
> > > > @@ -203,12 +203,21 @@ static struct ccu_nkmp pll_hsic_clk =3D {
> > > >
> > > >   * hardcode it to match with the clock names.
> > > >   */
> > > >
> > > >  #define SUN50I_H6_PLL_AUDIO_REG                0x078
> > > >
> > > > +
> > > > +static struct ccu_sdm_setting pll_audio_sdm_table[] =3D {
> > > > +       { .rate =3D 541900800, .pattern =3D 0xc001288d, .m =3D 1, .=
n =3D 22 },
> > > > +       { .rate =3D 589824000, .pattern =3D 0xc00126e9, .m =3D 1, .=
n =3D 24 },
> > > > +};
> > > > +
> > > >
> > > >  static struct ccu_nm pll_audio_base_clk =3D {
> > > >
> > > >         .enable         =3D BIT(31),
> > > >         .lock           =3D BIT(28),
> > > >         .n              =3D _SUNXI_CCU_MULT_MIN(8, 8, 12),
> > > >         .m              =3D _SUNXI_CCU_DIV(1, 1), /* input divider =
*/
> > > >
> > > > +       .sdm            =3D _SUNXI_CCU_SDM(pll_audio_sdm_table,
> > > > +                                        BIT(24), 0x178, BIT(31)),
> > > >
> > > >         .common         =3D {
> > > >
> > > > +               .features       =3D CCU_FEATURE_SIGMA_DELTA_MOD,
> > > >
> > > >                 .reg            =3D 0x078,
> > > >                 .hw.init        =3D CLK_HW_INIT("pll-audio-base", "=
osc24M",
> > > >
> > > >                                               &ccu_nm_ops,
> > > >
> > > > @@ -753,12 +762,12 @@ static const struct clk_hw *clk_parent_pll_au=
dio[] =3D
> > > > {>
> > > >  };
> > > >
> > > >  /*
> > > >
> > > > - * The divider of pll-audio is fixed to 8 now, as pll-audio-4x has=
 a
> > > > - * fixed post-divider 2.
> > > > + * The divider of pll-audio is fixed to 24 for now, so 24576000 and
> > > > 22579200 + * rates can be set exactly in conjunction with sigma-del=
ta
> > > > modulation.>
> > > >   */
> > > >
> > > >  static CLK_FIXED_FACTOR_HWS(pll_audio_clk, "pll-audio",
> > > >
> > > >                             clk_parent_pll_audio,
> > > >
> > > > -                           8, 1, CLK_SET_RATE_PARENT);
> > > > +                           24, 1, CLK_SET_RATE_PARENT);
> > > >
> > > >  static CLK_FIXED_FACTOR_HWS(pll_audio_2x_clk, "pll-audio-2x",
> > > >
> > > >                             clk_parent_pll_audio,
> > > >                             4, 1, CLK_SET_RATE_PARENT);
> > >
> > > You need to fix the factors for the other two outputs as well, since =
all
> > > three are derived from pll-audio-base.
> >
> > Fix how? pll-audio-2x and pll-audio-4x clocks have fixed divider in reg=
ards to
> > pll-audio-base, while pll-audio has not. Unless you mean changing their=
 name?
>
> Argh... I got it wrong. It looks good actually.
>
> Acked-by: Chen-Yu Tsai <wens@csie.org>

Queued for 5.5, thanks

Maxime

--pfkcvjqh5wmcwf4x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXYPGfQAKCRDj7w1vZxhR
xfhxAQCQlPrCxV4nnEbqZUIhSmWlxP/HXHmMx5Kk4J83e7xUfgEAsQrTGvWtLAcb
3mTnYeJg0Ko41ya+QDycztsT65ffCAA=
=NCZi
-----END PGP SIGNATURE-----

--pfkcvjqh5wmcwf4x--
