Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85ADCC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 13:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E0762084D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 13:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387799AbfCANf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 08:35:29 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:60784 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727418AbfCANf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 08:35:29 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 0A84980295; Fri,  1 Mar 2019 14:35:19 +0100 (CET)
Date:   Fri, 1 Mar 2019 14:35:12 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Sven Van Asbroeck <svendev@arcx.com>, robh+dt@kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, mark.rutland@arm.com,
        treding@nvidia.com, David Lechner <david@lechnology.com>,
        noralf@tronnes.org, johan@kernel.org,
        Michal Simek <monstr@monstr.eu>, michal.vokac@ysoft.com,
        Arnd Bergmann <arnd@arndb.de>, john.garry@huawei.com,
        geert+renesas@glider.be, robin.murphy@arm.com,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        Stuart Yoder <stuyoder@gmail.com>, maxime.ripard@bootlin.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 1/6] fieldbus_dev: add Fieldbus Device subsystem.
Message-ID: <20190301133512.GB7456@amd>
References: <20190122152109.30488-1-TheSven73@googlemail.com>
 <20190122152109.30488-2-TheSven73@googlemail.com>
 <20190122165658.GH26416@windriver.com>
 <2f4406b5-9970-211e-beef-a8b6ad60b99e@suse.de>
 <20190122185246.GA922@kroah.com>
 <CAGngYiU2kLqQq5qkcxda9m__VWx62bsC=+ni4HAGMsOAxAtUzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="1LKvkjL3sHcu1TtY"
Content-Disposition: inline
In-Reply-To: <CAGngYiU2kLqQq5qkcxda9m__VWx62bsC=+ni4HAGMsOAxAtUzw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1LKvkjL3sHcu1TtY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2019-01-24 13:07:58, Sven Van Asbroeck wrote:
> On Tue, Jan 22, 2019 at 1:52 PM Greg KH <gregkh@linuxfoundation.org> wrot=
e:
> >
> > SPDX "GPL-2.0+" please.
> >
> > > would be if this code was derived from v2-only code that can't be
> > > relicensed anymore.
> >
> > Are you _sure_ you want v2+?  I ask as I am forced to :)
> >
>=20
> The licencing choice confuses me. Why would I choose a different
> licence to what the Linux kernel itself is provided under?
> If I did pick a different one, what are the tradeoffs between GPLv2 and G=
PLv2+ ?

GPLv2 is buggy as it allows TiVO-ization. GPLv3 fixes that bug, so it
is more sensible choice. Kernel stays v2, but we have drivers that are
dual BSD or v2+, so that they can be used for other projects. One day
we might want to run GNU Hurd or something...

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--1LKvkjL3sHcu1TtY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlx5NRAACgkQMOfwapXb+vL/LQCgm3qKNCexto1i1CodlIBjsa6G
MdAAoLJWD3mqupKUI85Tgy0qwjuxzE4v
=asHh
-----END PGP SIGNATURE-----

--1LKvkjL3sHcu1TtY--
