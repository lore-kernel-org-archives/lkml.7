Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B91A4C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 11:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 873DB22CEC
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 11:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566561084;
	bh=gZ1OAdl/FGFFkG/ZAMQY2iqDkoQ/OUIjQTL2Q9nMCZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Os8A7l/09DZ58CAjllEMJVRBbQJU5xeY1hRbhx0qwS6PHRnBXLJM0DCsSD/zcIbZG
	 IjjBTXp+7hpo0rn1zoXktW//AiIFFa3ILWtl9Es4GxnfWLCDBzP+1NsdXhra5aBicB
	 GCI9rJlZvOWFBB0qytbr2GCwFlRDvCsNeO18WDrw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393146AbfHWLvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 07:51:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:47012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732231AbfHWLvX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 07:51:23 -0400
Received: from localhost (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 589F521848;
        Fri, 23 Aug 2019 11:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566561081;
        bh=gZ1OAdl/FGFFkG/ZAMQY2iqDkoQ/OUIjQTL2Q9nMCZI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qUX6dxAr+Ck008LADXrYu3bm/WDq3Mn3GAyJx6jet+W98akkFUlXl91SAKG2X7K2u
         /JpTShgQVrddhaMEp9RgrtV9jCt/3XNjX2rjz/cMBxUBXJQvxKO3AfULcpIgI+y0uU
         tlrCP2E7Ic0qkX+0rGUUCslWmMr5jtVkzC/Kk3pI=
Date:   Fri, 23 Aug 2019 13:51:19 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: allwinner: orange-pi-3: Enable WiFi
Message-ID: <20190823115119.lsfvabrwqpijkr2k@flea>
References: <20190823094228.6540-1-megous@megous.com>
 <20190823100807.22heh2gahi7owo4e@flea>
 <CAGb2v65mDt8t2sceTzKvYP6XVHJgikXyYMc+xWxZFkTJ+LZ1fg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ssnkgdje7jzcgsqx"
Content-Disposition: inline
In-Reply-To: <CAGb2v65mDt8t2sceTzKvYP6XVHJgikXyYMc+xWxZFkTJ+LZ1fg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ssnkgdje7jzcgsqx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 23, 2019 at 06:10:30PM +0800, Chen-Yu Tsai wrote:
> On Fri, Aug 23, 2019 at 6:08 PM Maxime Ripard <mripard@kernel.org> wrote:
> >
> > Hi,
> >
> > On Fri, Aug 23, 2019 at 11:42:28AM +0200, megous@megous.com wrote:
> > > From: Ondrej Jirman <megous@megous.com>
> > >
> > > Orange Pi 3 has AP6256 WiFi/BT module. WiFi part of the module is called
> > > bcm43356 and can be used with the brcmfmac driver. The module is powered by
> > > the two always on regulators (not AXP805).
> > >
> > > WiFi uses a PG port with 1.8V voltage level signals. SoC needs to be
> > > configured so that it sets up an 1.8V input bias on this port. This is done
> > > by the pio driver by reading the vcc-pg-supply voltage.
> > >
> > > You'll need a fw_bcm43456c5_ag.bin firmware file and nvram.txt
> > > configuration that can be found in the Xulongs's repository for H6:
> > >
> > > https://github.com/orangepi-xunlong/OrangePiH6_external/tree/master/ap6256
> > >
> > > Mainline brcmfmac driver expects the firmware and nvram at the following
> > > paths relative to the firmware directory:
> > >
> > >   brcm/brcmfmac43456-sdio.bin
> > >   brcm/brcmfmac43456-sdio.txt
> > >
> > > Signed-off-by: Ondrej Jirman <megous@megous.com>
> > > ---
> > >
> > > Since RTC patches for H6 were merged, this can now go in too, if it looks ok.
> > >
> > > Other patches for this WiFi chip support were merged in previous cycles,
> > > so this just needs enabling in DTS now.
> > >
> > > Sorry for the links in the commit log, but this information is useful,
> > > even if the link itself goes bad. Any pointer what to google for
> > > (file names, tree name) is great for anyone searching in the future.
> >
> > I understand, but this should (also?) be in the wiki. Please add it
> > there too.
> >
> > > Please take a look.
> > >
> > > Thank you,
> > >       Ondrej
> > >
> > >  .../dts/allwinner/sun50i-h6-orangepi-3.dts    | 48 +++++++++++++++++++
> > >  1 file changed, 48 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
> > > index eda9d5f640b9..49d954369087 100644
> > > --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
> > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
> > > @@ -56,6 +56,34 @@
> > >               regulator-max-microvolt = <5000000>;
> > >               regulator-always-on;
> > >       };
> > > +
> > > +     reg_vcc33_wifi: vcc33-wifi {
> > > +             /* Always on 3.3V regulator for WiFi and BT */
> > > +             compatible = "regulator-fixed";
> > > +             regulator-name = "vcc33-wifi";
> > > +             regulator-min-microvolt = <3300000>;
> > > +             regulator-max-microvolt = <3300000>;
> > > +             regulator-always-on;
> > > +             vin-supply = <&reg_vcc5v>;
> > > +     };
> > > +
> > > +     reg_vcc_wifi_io: vcc-wifi-io {
> > > +             /* Always on 1.8V/300mA regulator for WiFi and BT IO */
> > > +             compatible = "regulator-fixed";
> > > +             regulator-name = "vcc-wifi-io";
> > > +             regulator-min-microvolt = <1800000>;
> > > +             regulator-max-microvolt = <1800000>;
> > > +             regulator-always-on;
> > > +             vin-supply = <&reg_vcc33_wifi>;
> > > +     };
> > > +
> > > +     wifi_pwrseq: wifi_pwrseq {
>
> IIRC we shouldn't use underscores in node names. Maxime can you fix that up?

Done, thanks!
Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--ssnkgdje7jzcgsqx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXV/TNwAKCRDj7w1vZxhR
xVrNAQCa1MgrCyh7oN19ZsZE9syJ4qiyl3P8YsI1dtR48YhAWgD/QaSQYVBFbqmM
cWqnn8wDHbjoMqrBbhbYTmLG4+iStA4=
=GDJL
-----END PGP SIGNATURE-----

--ssnkgdje7jzcgsqx--
