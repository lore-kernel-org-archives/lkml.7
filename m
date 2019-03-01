Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E10C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 13:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 139B320851
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 13:35:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387757AbfCANfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 08:35:04 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:60693 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727418AbfCANfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 08:35:04 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 6BEFC801D1; Fri,  1 Mar 2019 14:34:54 +0100 (CET)
Date:   Fri, 1 Mar 2019 14:34:56 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Sven Van Asbroeck <thesven73@gmail.com>, svendev@arcx.com,
        robh+dt@kernel.org, linus.walleij@linaro.org, lee.jones@linaro.org,
        mark.rutland@arm.com, treding@nvidia.com, david@lechnology.com,
        noralf@tronnes.org, johan@kernel.org, monstr@monstr.eu,
        michal.vokac@ysoft.com, arnd@arndb.de, john.garry@huawei.com,
        geert+renesas@glider.be, robin.murphy@arm.com,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        stuyoder@gmail.com, maxime.ripard@bootlin.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/6] fieldbus_dev: add Fieldbus Device subsystem.
Message-ID: <20190301133456.GA7456@amd>
References: <20190122152109.30488-1-TheSven73@googlemail.com>
 <20190122152109.30488-2-TheSven73@googlemail.com>
 <20190122165658.GH26416@windriver.com>
 <2f4406b5-9970-211e-beef-a8b6ad60b99e@suse.de>
 <20190122185246.GA922@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline
In-Reply-To: <20190122185246.GA922@kroah.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > >=20
> > >> +
> > >> +MODULE_AUTHOR("Sven Van Asbroeck <TheSven73@googlemail.com>");
> > >> +MODULE_AUTHOR("Jonathan Stiles <jonathans@arcx.com>");
> > >> +MODULE_DESCRIPTION("Fieldbus Device Driver Core");
> > >> +MODULE_LICENSE("GPL v2");
> >=20
> > Sven, as this code appears to be all by ArcX people, any chance you can
> > make it just GPL (SPDX GPL-2.0-or-later)? Only reason to have it v2-only
>=20
> SPDX "GPL-2.0+" please.
>=20
> > would be if this code was derived from v2-only code that can't be
> > relicensed anymore.
>=20
> Are you _sure_ you want v2+?  I ask as I am forced to :)

And I find it pretty nasty. You are trying to push people away from
GPL V2+, which is not cool. Who is forcing you and why is that okay
thing to do? :-(.

									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--gKMricLos+KVdGMg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlx5NQAACgkQMOfwapXb+vJYfACeKnAur6M/y7B2T0Guu/GOrlNi
Pj8An1l+JZnIujHIKv1GxgdSLhQU4DA2
=y+dV
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--
