Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32705C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 07:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AFD120857
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 07:06:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfDIHGy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 03:06:54 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:59203 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfDIHGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 03:06:54 -0400
X-Originating-IP: 90.88.30.125
Received: from xps13 (aaubervilliers-681-1-89-125.w90-88.abo.wanadoo.fr [90.88.30.125])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id C7BA41C0008;
        Tue,  9 Apr 2019 07:06:50 +0000 (UTC)
Date:   Tue, 9 Apr 2019 09:06:43 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Pavel Machek <pavel@ucw.cz>
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
Message-ID: <20190409090643.0d8ce19a@xps13>
In-Reply-To: <20190408215540.GA27929@amd>
References: <20190205110728.11451-1-miquel.raynal@bootlin.com>
        <20190408215540.GA27929@amd>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/MGz6Rqgj/SytUAX/Mnnjcka"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/MGz6Rqgj/SytUAX/Mnnjcka
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

Pavel Machek <pavel@ucw.cz> wrote on Mon, 8 Apr 2019 23:55:41 +0200:

> On Tue 2019-02-05 12:07:28, Miquel Raynal wrote:
> > On one hand, the mv88e6xxx driver has a work queue called in loop
> > which will attempt register accesses after MDIO bus suspension, that
> > entirely freezes the platform during suspend.
> >=20
> > On the other hand, the DSA core is not ready yet to support suspend to
> > RAM operation because so far there is no way to recover reliably the
> > switch configuration.
> >=20
> > To avoid the kernel to freeze when suspending with a switch driven by
> > the mv88e6xxx driver, we choose to prevent the driver suspension and
> > in the same way, the whole platform.
> >=20
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com> =20
>=20
> Could we at least do printk() so that user knows what went wrong?
>=20
> Debugging s2ram is usually not easy :-(.

I suppose you will be told that suspend was refused by a driver
(probably without stating which one though). You may send a patch to add
a trace if you think it is important, as this change as already been
merged.


Thanks,
Miqu=C3=A8l

--Sig_/MGz6Rqgj/SytUAX/Mnnjcka
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE9HuaYnbmDhq/XIDIJWrqGEe9VoQFAlysRIMACgkQJWrqGEe9
VoR4kQf+JvRV2syJ6wW29RnHHoBqEH68B52f61MgCwKY50Mf3TUiB4Gk8DomzTO7
K9BD64MPyNucdKfH5aTPlloHYy3zYEq8nOOWJd9WdXB0787UZDcjR6SkU3KSytTH
lM/N7MKBDhxbiUGDvUOLSIFyKs3GQj1U1IQjHmsv9sywgOnIa4N50NILzROv/ZnA
BNBujVqJ/XBK/fhorUokD4+pePV6NN2o2hmamoZAKy2TrHRoqrDUur9M1xqlRf2w
cTp2Ld7dNsX01uKMNLS2T016uRtjA+/yJSSiLUs6SMnvi+GMdKAfoeMw6yCnLCgy
kBmf7/WgXdYpZkmFmvywIJBE0jw8FQ==
=wn3A
-----END PGP SIGNATURE-----

--Sig_/MGz6Rqgj/SytUAX/Mnnjcka--
