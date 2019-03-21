Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF5FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 20:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 473B22183E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 20:36:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728930AbfCUUgG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 16:36:06 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:35419 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728769AbfCUUgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 16:36:06 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id EE3D28049F; Thu, 21 Mar 2019 21:35:54 +0100 (CET)
Date:   Thu, 21 Mar 2019 21:36:02 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Hao <peng.hao2@zte.com.cn>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Smarter Kconfig help
Message-ID: <20190321203602.GA971@amd>
References: <20190305173111.t3n6ycktht7kxuhq@shell.armlinux.org.uk>
 <1551865552.9298.24.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
Content-Disposition: inline
In-Reply-To: <1551865552.9298.24.camel@pengutronix.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2019-03-06 10:45:52, Lucas Stach wrote:
> Hi Russell,
>=20
> Am Dienstag, den 05.03.2019, 17:31 +0000 schrieb Russell King - ARM Linux=
 admin:
> > Guys,
> >=20
> > We need to be smarter when writing Kconfig help.=A0=A0I'm just going
> > through updating my build trees with the results of 5.0 development,
> > and a number of the help texts are next to useless.=A0=A0For example,
> >=20
> > PVPANIC - is this something that should be enabled for a host or
> > guest kernel?=A0=A0Answer: you have to read the driver code to find out.
> >=20
> > IMX_IRQSTEER - which i.MX SoCs does this apply to?=A0=A0The help text
> > just says:
> >=20
> > =A0 "Support for the i.MX IRQSTEER interrupt multiplexer/remapper."
> >=20
> > which doesn't say which SoCs this should be enabled for - it turns
> > out that grepping for the driver's DT compatible string, none of
> > the 32-bit ARM cores have support for this, yet we still default
> > it to enabled there.=A0=A0It seems the help text should at the very
> > least tell the user that this is not applicable to i.MX SoCs with
> > 32-bit ARM cores.
> >=20
> > I'm sure there's many other instances of this... I suspect that
> > it's caused by review concentrating mostly on the technical aspects
> > of the code and the Kconfig help text just gets forgotten about.
> >=20
> > Can we at least improve these two options please?
>=20
> While I totally agree that the irqsteer driver should only default Y on
> 64bit i.MX SoCs, I'm not really sure what to do about the Kconfig help
> text.
>=20
> Enumerating SoCs in the Kconfig of a IP block driver is always prone to
> get outdated. Just as the first example I've been able to come up with,
> the MMC_SDHCI_ESDHC_IMX help text says: "This selects the Freescale
> eSDHC/uSDHC controller support=A0found on i.MX25, i.MX35 i.MX5x and
> i.MX6x.", while the same IP block is to be found on i.MX7 and various
> i.MX8.

"This selects the Freescale eSDHC/uSDHC controller support found on
i.MX25, i.MX35 i.MX5x, i.MX6x and later SoCs.".

Really, there are way too many silicon blocks, and you can't expect
Kconfig user to know them all...

Best regards,

									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlyT9bIACgkQMOfwapXb+vJe8ACdHZn1blrVrLLs72fgejcEkPGC
WT0AmQHg8kMD84pL9Jwdjz1Jk13hncw/
=8tyr
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--
