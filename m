Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C2D3C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 10:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03D5621775
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 10:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574937187;
	bh=XkkZY50Ku/fTTkcm9Gj5G8wbLDZLo31fHLtFpoOVYCw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vcGdTi5WZMVQ9au0a3zArdex0buBMpyJDF9DdrK7Wjz47E/wB3G4i5sA8294OY8Ed
	 vHLvG///hlw2puQK6WCig0/8gUU9t6yuuxfCLcqB87g69Qp0UHaJnUtzumeNESuWtm
	 Tg/ilPLu/UsPBqPFtjUz8rYbUzt0j8T/mczeflSk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbfK1KdG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 05:33:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:46782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726191AbfK1KdF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 05:33:05 -0500
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A8F821774;
        Thu, 28 Nov 2019 10:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574937185;
        bh=XkkZY50Ku/fTTkcm9Gj5G8wbLDZLo31fHLtFpoOVYCw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=13OFpcdb2oyl0G7fXdFH5DZQWxrcTEN4M4cMy0d8sc/zcZH7aOvPlsOmKKejf7uSK
         GxuhBUi83tUboyJjztTNa5pya+hTY07JhVN3nZ2DhT4kl6XVhttuXcXguqPZEavXYM
         eiHgzMrc1GjyRG/8pmyOhbMzQnQv6JU6eeqVScEM=
Date:   Thu, 28 Nov 2019 11:33:01 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Stefan Mavrodiev <stefan@olimex.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH 1/1] arm64: dts: allwinner: a64: olinuxino: Add VCC-PG
 supply
Message-ID: <20191128103301.vjpkvjscy45ycgwg@gilmour.lan>
References: <20191126110508.15264-1-stefan@olimex.com>
 <20191126162721.qi7scp3vadxn7k2i@gilmour.lan>
 <0c1d7377-7064-f509-ffc5-bd1e8f2fbaa8@olimex.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="stx4a5zlstsyhhjb"
Content-Disposition: inline
In-Reply-To: <0c1d7377-7064-f509-ffc5-bd1e8f2fbaa8@olimex.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--stx4a5zlstsyhhjb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Stefan,

On Wed, Nov 27, 2019 at 09:07:40AM +0200, Stefan Mavrodiev wrote:
> On 11/26/19 6:27 PM, Maxime Ripard wrote:
> > Hi Stefan,
> >
> > On Tue, Nov 26, 2019 at 01:05:08PM +0200, Stefan Mavrodiev wrote:
> > > On A64-OLinuXino boards, PG9 is used for USB1 enable/disable. The
> > > port is supplied by DLDO4, which is disabled by default. The patch
> > > adds the regulator as vcc-pg, which is later used by the pinctrl.
> > >
> > > Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>
> > > ---
> > >   arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts | 4 ++++
> > >   1 file changed, 4 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
> > > index 01a9a52edae4..c9d8c9c4ef20 100644
> > > --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
> > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
> > > @@ -163,6 +163,10 @@
> > >   	status = "okay";
> > >   };
> > >
> > > +&pio {
> > > +	vcc-pg-supply=<&reg_dldo4>;
> > The equal sign should have spaces around it.
> >
> > Also, can you please list all the bank supplies while you're at it?
>
> Sure. Should the supplies defined as regulators names be added also to the
> pio node?
> For example reg_aldo1 is named "vcc-pe".

As far as I can tell, the A64 has regulators for PC, PD, PE, PG and
PL, so you should list those (PL being under r_pio)

> Also, since the commit message will be different for better representation
> of the changes, should I send the next
> patch as v2 or as a new one?

Either way works for me as long as the commit message matches the changes.

Thanks!
Maxime

--stx4a5zlstsyhhjb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXd+iXQAKCRDj7w1vZxhR
xcehAP963qGMNNtuK9UziU1syhhW7rH4N5zmtnS3s2iN4Mp0JwD/d4k4t/rtURBA
Lpwkgow4mIPRk/bmMRu8JfSG0GizbQY=
=1Rzz
-----END PGP SIGNATURE-----

--stx4a5zlstsyhhjb--
