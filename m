Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB95C31E47
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 13:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6139D21743
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 13:24:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439373AbfFLNYb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 09:24:31 -0400
Received: from sauhun.de ([88.99.104.3]:59658 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437469AbfFLNYb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 09:24:31 -0400
Received: from localhost (p5486CACA.dip0.t-ipconnect.de [84.134.202.202])
        by pokefinder.org (Postfix) with ESMTPSA id 93BAB2C54BC;
        Wed, 12 Jun 2019 15:24:29 +0200 (CEST)
Date:   Wed, 12 Jun 2019 15:24:29 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Mauro Carvalho Chehab <mchehab@infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ruslan Babayev <ruslan@babayev.com>,
        Andrew de Quincey <adq_dvb@lidskialf.net>
Subject: Re: linux-next: build warning after merge of the i2c tree
Message-ID: <20190612132429.GA5862@kunai>
References: <20190611102528.44ad5783@canb.auug.org.au>
 <20190612081929.GA1687@kunai>
 <20190612080226.45d2115a@coco.lan>
 <20190612110904.qhuoxyljgoo76yjj@ninjato>
 <20190612084824.16671efa@coco.lan>
 <20190612120439.GB2805@kunai>
 <20190612093229.7f14a1e2@coco.lan>
 <20190612231535.253a8a20@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="k1lZvvs/B4yU6o8G"
Content-Disposition: inline
In-Reply-To: <20190612231535.253a8a20@canb.auug.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2019 at 11:15:35PM +1000, Stephen Rothwell wrote:
> Hi all,
>=20
> On Wed, 12 Jun 2019 09:32:29 -0300 Mauro Carvalho Chehab <mchehab@infrade=
ad.org> wrote:
> >
> > Em Wed, 12 Jun 2019 14:04:39 +0200
> > Wolfram Sang <wsa@the-dreams.de> escreveu:
> >=20
> > > > > OK, so that means I should send my pull request after yours in th=
e next
> > > > > merge window? To avoid the build breakage?   =20
> > > >=20
> > > > Either that or you can apply my patch on your tree before the
> > > > patch that caused the breakage.=20
> > > >=20
> > > > Just let me know what works best for you.   =20
> > >=20
> > > Hmm, the offending patch is already in -next and I don't rebase my tr=
ee.
> > > So, I guess it's the merge window dependency then.
> > >  =20
> > Ok, I'll merge it through my tree then.
>=20
> It should go into the i2c tree (since that is where the *warning* was
> introduced).  It is only a warning and there won't be many patches
> between the patch that introduced the warning and this one that fixes
> it.  This patch could then have a Fixes tag that makes sense i.e. it
> will reference a previous commit.

I can apply the patch to my i2c/for-next branch, but not to my
i2c/for-5.3 branch (which I merge into i2c/for-next). This way, the
warning will go away, but the media patch still goes to Linus via the
media tree. Is that suitable for you?



--k1lZvvs/B4yU6o8G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl0A/QkACgkQFA3kzBSg
KbaiYQ//YbzgHF3IWTPhIpd+28zpYqI5GRF/lATJTmZNgWgNRwtl06+yBpMYJ10r
TMV+Mx+HXAS8BHApNEGr1qTtbE9e8pD3gKdk+2LHYprk/+htApR2hqxJ07UvIX6t
yyB96RqcTD8FuhjIzvETvTml7anIb8CTPzX8KVaLKlHCqy82eeysnHn34TarPc3g
jFlTJlKBeXSGZL7JTLjrbbVQPHo1VOB2juhqKFKxjchJslCbhdd0ESq5A3MgPd+S
pZ4cCeRvHa5cLhm1a/xhF/ER2hcjA3+g7BaxhqGQvAcuM/6ZR2U5wJyUHH9NXS/Z
Jc6arFof/UQjR2B+TPfBPurN1cMdpxixrrrkS40Bo4P7C+AIowbDfm5a0XCp9qCM
rI1RbAAkvD/PPjKmNvwMvMm48BwLudEsrQFHbZM/UwGe8VVF+LGVl5XPS5M8ax+0
vjkY+qb/x+qYbrw1ZQZfvbrQ5r+Sw+tNesx3/SwKlMecfnnQ8dBDqSVQXUHETCAF
1Bw5gLh3ejpb/fosGH1uggY1Pm0kySgyWuK+P9pW26Zb1oMOCNR0/snG5Vhhd2Hx
Yy8jIdxA3MVoLt001ST8EjDPEJwTqXIv+nM2GDSRiD5u5QgIjAlt4bCNspE/EGdq
OBNF49wgc6gI91UzsyFRrhN8yAFLjGlmABDS0F/6u50jNlL6mrU=
=iSgc
-----END PGP SIGNATURE-----

--k1lZvvs/B4yU6o8G--
