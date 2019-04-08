Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 624E2C10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3904520880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfDHVzq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 17:55:46 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:57192 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbfDHVzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 17:55:42 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 5498180543; Mon,  8 Apr 2019 23:55:33 +0200 (CEST)
Date:   Mon, 8 Apr 2019 23:55:41 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>
Subject: Re: [PATCH net-next v3] net: dsa: mv88e6xxx: Prevent suspend to RAM
Message-ID: <20190408215540.GA27929@amd>
References: <20190205110728.11451-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
Content-Disposition: inline
In-Reply-To: <20190205110728.11451-1-miquel.raynal@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2019-02-05 12:07:28, Miquel Raynal wrote:
> On one hand, the mv88e6xxx driver has a work queue called in loop
> which will attempt register accesses after MDIO bus suspension, that
> entirely freezes the platform during suspend.
>=20
> On the other hand, the DSA core is not ready yet to support suspend to
> RAM operation because so far there is no way to recover reliably the
> switch configuration.
>=20
> To avoid the kernel to freeze when suspending with a switch driven by
> the mv88e6xxx driver, we choose to prevent the driver suspension and
> in the same way, the whole platform.
>=20
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Could we at least do printk() so that user knows what went wrong?

Debugging s2ram is usually not easy :-(.
								Pavel
=20
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlyrw1wACgkQMOfwapXb+vIcdQCfSb6aq3flcqsLHl/QIbSjL6I9
igoAoLlj9LAlnBVno5vVImksSAYnL7Nz
=q9AG
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--
