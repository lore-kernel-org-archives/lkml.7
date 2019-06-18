Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2317EC31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 10:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01EEA20873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 10:45:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729503AbfFRKpu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 06:45:50 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:47882 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729098AbfFRKpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 06:45:50 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 17D9E80317; Tue, 18 Jun 2019 12:45:36 +0200 (CEST)
Date:   Tue, 18 Jun 2019 12:45:47 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Joe Perches <joe@perches.com>
Cc:     Shawn Landden <shawn@git.icu>, linux-kernel@vger.kernel.org,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Andy Whitcroft <apw@canonical.com>
Subject: Re: [PATCH] Use fall-through attribute rather than magic comments
Message-ID: <20190618104546.GC4541@amd>
References: <20190316033841.7659-1-shawn@git.icu>
 <20190617155643.GA32544@amd>
 <45e070039e66b1cb1490a78d4805bc73cc09f571.camel@perches.com>
 <20190618073407.GA786@amd>
 <3499a5a2058c246d48f8eb96682ce371833563b2.camel@perches.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="7qSK/uQB79J36Y4o"
Content-Disposition: inline
In-Reply-To: <3499a5a2058c246d48f8eb96682ce371833563b2.camel@perches.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7qSK/uQB79J36Y4o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2019-06-18 02:30:35, Joe Perches wrote:
> On Tue, 2019-06-18 at 09:34 +0200, Pavel Machek wrote:
> > On Mon 2019-06-17 09:25:56, Joe Perches wrote:
> > > On Mon, 2019-06-17 at 17:56 +0200, Pavel Machek wrote:
> > > > Hi!
> > > >=20
> > > > > +/*
> > > > > + *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.htm=
l#index-Wimplicit-fallthrough
> > > > > + *   gcc: https://developers.redhat.com/blog/2017/03/10/wimplici=
t-fallthrough-in-gcc-7/
> > > > > + */
> > > > > +#if __has_attribute(__fallthrough__)
> > > > > +# define __fallthrough                    __attribute__((__fallt=
hrough__))
> > > > > +#else
> > > > > +# define __fallthrough
> > > > > +#endif
> > > >=20
> > > > Is it good idea to add the __'s ? They look kind of ugly.=20
> > >=20
> > > Dunno.
> > >=20
> > > I agree it's kind of ugly, but it should always work.
> > >=20
> > > I think the generic problem is introducing a new unprefixed
> > > reserved identifier.  Underscored identifiers are reserved.
> >=20
> > We are not userland, and we control whole codebase. These rules don't
> > apply.
>=20
> except include/uapi where some static inline switch might
>=20
> > We can use unprefixed identifier and fix up any problems... I don't
> > expect too many.
>=20
> but there aren't any existing uses there.

Agreed, this is not suitable for uapi. Fortunately, inline functions
should not be common in uapi...
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--7qSK/uQB79J36Y4o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl0IwNoACgkQMOfwapXb+vLwXwCeO3Q7pwl3ZFGdslEyc7QEhTuy
10IAoI1MO8mSpaoND5QpRl6WQISS4LRN
=uyh3
-----END PGP SIGNATURE-----

--7qSK/uQB79J36Y4o--
