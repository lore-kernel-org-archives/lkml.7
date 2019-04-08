Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1984DC10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D994E20857
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729214AbfDHVZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 17:25:09 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:54707 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbfDHVZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 17:25:09 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id B0E44804C2; Mon,  8 Apr 2019 23:24:58 +0200 (CEST)
Date:   Mon, 8 Apr 2019 23:25:06 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/boot: This program cannot be run in DOS mode.$
Message-ID: <20190408212506.GA6428@amd>
References: <20190401102434.9805-1-pali.rohar@gmail.com>
 <20190408180422.GA5103@amd>
 <20190408180809.myjp5zaviuibj5uf@pali>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Content-Disposition: inline
In-Reply-To: <20190408180809.myjp5zaviuibj5uf@pali>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2019-04-08 20:08:09, Pali Roh=E1r wrote:
> On Monday 08 April 2019 20:04:22 Pavel Machek wrote:
> > On Mon 2019-04-01 12:24:34, Pali Roh=E1r wrote:
> > > Every EFI binary is in PE format. And we know that PE format needs to=
 have
> > > MZ MS-DOS header as there is written offset to PE header.
> > >=20
> > > Therefore generated bzImage binary with CONFIG_EFI_STUB option is MS-=
DOS
> > > executable binary.
> > >=20
> > > We already know the "requirement" that Windows PE executable started =
in
> > > MS-DOS must print legendary and famous message to computer screen:
> > > "This program cannot be run in DOS mode."
> > >=20
> > > But trying to run that bzImage of Linux kernel with MZ header just ca=
use
> > > freezing whole MS-DOS instead of writing "the correct message" to use=
r.
> > > This is not the compliant behavior of PE executables!
> > >=20
> > > This patch fixes this problem. When Linux kernel compiled with
> > > CONFIG_EFI_STUB is started in MS-DOS then it prints message:
> > >=20
> > >   This program cannot be run in DOS mode.
> > >   To load Linux kernel from DOS mode use LOADLIN.EXE.
> > >=20
> > > So it also helps MS-DOS users how to "correctly" start this bzImage b=
inary
> > > by mentioning LOADLIN.EXE. Note that MS-DOS strings are not null-term=
inated
> > > but rather dollar-terminated.
> > >=20
> > > To have error message unified bugger_off_msg for BIOS boot block code=
 was
> > > changed to:
> > >=20
> > >   This program cannot be run in BIOS mode.
> > >=20
> > > So if you copy generated bzImage directly to boot sector and try to b=
oot it
> > > by BIOS you get this new updated message.
> > >=20
> > > Due to fixed offset of setup header (0x1f1), PE header was moved after
> > > entrytext section. bstext and bsdata sections where is full MZ header=
 and
> > > MS-DOS code is now bigger.
> >=20
> > Hehe, I guess the patch may have been dropped due to april's fools?
>=20
> Yea, it was mean as first April patch :-) I tested it with MS-DOS 7.0
> and DOSBox and it worked.
>=20
> > You may want to retransmit?
>=20
> Do you really think it can be useful? :-)

Dunno. It is quite simple, and quite a nice hack ;-).

								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlyrvDIACgkQMOfwapXb+vL2CgCgssie38RmZMkHXSsFGdisz9rA
WPgAoIg/uufNooMSZw0sMD3TCI9BKgeC
=dg7/
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--
