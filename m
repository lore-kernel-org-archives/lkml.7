Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 607DBC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 19:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3415021783
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 19:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573586184;
	bh=1IW8UUMmQ1aplMh8cmJEkKKNsjASki0Ab44VZOslaPk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WPHoK5n2pZEgO4nbMqEAIbEsSSxi9rmPTN+4bdrmndRx8J74rgiBh3Z8kvSsg96KN
	 XpE/c64Na443GCQnGt+vIpc1aajuQ8x2gU+VM52B9+w1aqHg/LWGRUcwqgTtT/FgWL
	 mHjLkmsDCQZWeWmN+KjRVXmvAwP8rwP5gWqwW8M0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbfKLTQX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 14:16:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:35922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725997AbfKLTQW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 14:16:22 -0500
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E189D20818;
        Tue, 12 Nov 2019 19:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573586181;
        bh=1IW8UUMmQ1aplMh8cmJEkKKNsjASki0Ab44VZOslaPk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rL470w9j47ztbIN8itCRbCXBV+CYT0FjVIdVe/g+CYnW8SJ7yi+ynGw67CJ03Cpw8
         bQ66XQbLq/LZeMR2BxY9RH4v1Kq7cZUA0MvpkY+Z42A9VldZK/dVOsE6koLlvTlDWm
         IOinDXU7oult1Vdrdk+foCXekQfEG2ybYOTuUEoM=
Date:   Tue, 12 Nov 2019 20:16:18 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     linux-arm-kernel@lists.infradead.org,
        Tian Yunhao <t123yh@outlook.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: Re: [PATCH] clk: sunxi-ng: v3s: Fix incorrect number of hw_clks.
Message-ID: <20191112191618.GC4345@gilmour.lan>
References: <BN8PR08MB57792366D78997180A698AF8897A0@BN8PR08MB5779.namprd08.prod.outlook.com>
 <20191111123936.GM4345@gilmour.lan>
 <1FA73EE3-CED2-4241-839D-51C8C02531F5@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="alCHniwhwUTljuKz"
Content-Disposition: inline
In-Reply-To: <1FA73EE3-CED2-4241-839D-51C8C02531F5@aosc.io>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--alCHniwhwUTljuKz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2019 at 08:59:56PM +0800, Icenowy Zheng wrote:
>
>
> =E4=BA=8E 2019=E5=B9=B411=E6=9C=8811=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=
=888:39:36, Maxime Ripard <mripard@kernel.org> =E5=86=99=E5=88=B0:
> >Hi,
> >
> >Thanks for your patch
> >
> >On Sat, Nov 09, 2019 at 03:19:09PM +0000, Tian Yunhao wrote:
> >> The hws field of sun8i_v3s_hw_clks has only 74
> >> members. However, the number specified by CLK_NUMBER
> >> is 77 (=3D CLK_I2S0 + 1). This leads to runtime segmentation
> >> fault that is not always reproducible.
> >>
> >> This patch adds a protective field [CLK_NUMBER] which ensures
> >> ARRAY_SIZE(.hws) is always greater than .num, thus eliminates
> >> this error.
> >>
> >> Signed-off-by: Yunhao Tian <t123yh@outlook.com>
> >> ---
> >>  drivers/clk/sunxi-ng/ccu-sun8i-v3s.c | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >> diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c
> >b/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c
> >> index 5c779eec454b..de7fce7f32e6 100644
> >> --- a/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c
> >> +++ b/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c
> >> @@ -617,6 +617,7 @@ static struct clk_hw_onecell_data
> >sun8i_v3s_hw_clks =3D {
> >>  		[CLK_AVS]		=3D &avs_clk.common.hw,
> >>  		[CLK_MBUS]		=3D &mbus_clk.common.hw,
> >>  		[CLK_MIPI_CSI]		=3D &mipi_csi_clk.common.hw,
> >> +		[CLK_NUMBER]    =3D NULL,
> >>  	},
> >>  	.num	=3D CLK_NUMBER,
> >>  };
> >> @@ -699,6 +700,7 @@ static struct clk_hw_onecell_data
> >sun8i_v3_hw_clks =3D {
> >>  		[CLK_AVS]		=3D &avs_clk.common.hw,
> >>  		[CLK_MBUS]		=3D &mbus_clk.common.hw,
> >>  		[CLK_MIPI_CSI]		=3D &mipi_csi_clk.common.hw,
> >> +		[CLK_NUMBER]    =3D NULL,
> >>  	},
> >>  	.num	=3D CLK_NUMBER,
> >
> >I'd rather have the number of clocks (.num) being properly set.
>
> However the maximum clock indices number is different on V3s and V3, beca=
use
> on V3s the last clock is missing.
>
> Should we define CLK_NUMBER_V3S here?

That, or we can just reference the last clock, we're not using
CLK_NUMBER anywhere else.

Maxime
--alCHniwhwUTljuKz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXcsFAgAKCRDj7w1vZxhR
xRGMAQCLdf1+S5MiugOG811D1O+TID2K8oHSTiGL0ebwb1WnzQD/RoJSiEPXRiwL
00DWv7QWDbWvFN/sZUAK3pqmsgjjZwA=
=jeP6
-----END PGP SIGNATURE-----

--alCHniwhwUTljuKz--
