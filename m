Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BECDC46497
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 21:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 428E921852
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 21:32:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="kRGOIKCy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbfGDVcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 17:32:05 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:47209 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbfGDVcF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 17:32:05 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45frlj1KZ8z9sLt;
        Fri,  5 Jul 2019 07:32:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562275921;
        bh=5oaYu7F/4zk0qDViaCz52qmMnMkbf2umIAaZcIjMeWI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kRGOIKCyZputHINzi5McT14/9RepJks2la90qFSDiV6VdB8UO++dQXmo1O+GGyhrz
         AHXt7Ec3/MdWYuAbZY/LOYeUVY1rewcw1VcBRro61E/Y8NJ2V5dZ6lY6Lyrdx02Wd+
         R7jiXA16bxtlt/iRZ8je+OAxgtyS+XruBbTvFg2hcL2VEE6w+cLkTFB4gh3a6OPm/0
         af/c2iKgQg13qpmeR2413Y0LwzG71ZFNJUo+QVAIY5U4Zexy5SxYh7hbZS9C8HYcMD
         cj6V+BsNS4v85J1WxfYLzwbqO1iKl0Mp2IyKe/eDKv4pw3X7DL/j6iAzKhkK3pafC3
         vW+xnu/0xujtA==
Date:   Fri, 5 Jul 2019 07:31:58 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jeremy Kerr <jk@ozlabs.org>,
        Alistair Popple <alistair@popple.id.au>,
        Eddie James <eajames@linux.ibm.com>,
        linux-fsi@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] FSI changes for 5.3
Message-ID: <20190705073158.1c8384ed@canb.auug.org.au>
In-Reply-To: <CACPK8XdGC4V5xs5S=JHk=tUayLGHQkF5eH0pvFnyffpDaUuqQQ@mail.gmail.com>
References: <CACPK8XfCpgjAwMeoyhcZqgqtXO=-wtpuB2kwsogvBnd1VzynDg@mail.gmail.com>
        <041ce2ab04d0594accdbf51078906ac116cc0253.camel@kernel.crashing.org>
        <CACPK8XdGC4V5xs5S=JHk=tUayLGHQkF5eH0pvFnyffpDaUuqQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/b85qfGfcfjcxuS0Plctq78P"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/b85qfGfcfjcxuS0Plctq78P
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Joel,

On Thu, 4 Jul 2019 06:03:18 +0000 Joel Stanley <joel@jms.id.au> wrote:
>
> On Wed, 3 Jul 2019 at 05:32, Benjamin Herrenschmidt <benh@kernel.crashing=
.org> wrote:
> >
> > On Wed, 2019-07-03 at 03:39 +0000, Joel Stanley wrote: =20
> > >
> > > We've not had a MAINAINERS entry for drivers/fsi, so this fixes that.=
 It names
> > > Jeremy and I as maintainers, so if it works for you we will send pull=
 requests
> > > to you each cycle. =20
> >
> > Ack. I no longer work for IBM and thus cannot handle that subsystem
> > anymore. =20
>=20
> Stephen, can you swap out ben's fsi tree in linux-next for this one:
>=20
> git://git.kernel.org/pub/scm/linux/kernel/git/joel/fsi.git
>=20
> Branch is 'next'.

There is no "next" branch in that tree, so for now I have used the
master branch.   I have replaced Ben with you and Jeremy as contacts.

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgement of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window.=20

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
        Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and=20
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

--=20
Cheers,
Stephen Rothwell=20
sfr@canb.auug.org.au

--Sig_/b85qfGfcfjcxuS0Plctq78P
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0ecE4ACgkQAVBC80lX
0GwoRAf+Ivit0wjzA9tGpDOHdGP9owK8p3/551ZSKkPG4jdLWdDTegCZ4pQ/6QZ5
Mp00632hOdDexaOuNY9NmSShdgnCmwhoWF76cJ+cRrF2GxSHCq6eXwsKEl2b2yza
o74DMYx5YlE9mgnbIynr7mVkjuLaFlyXYwRpGQgQp1lRBEselouQxuxKgssoHiSZ
tgZYlU4PFeX3XLFfxHfWaM9AnswAn11Jw8bjjQLA/HOrz9mSzrzf1LeJBrUajEQD
N3RU997yIJxyao/V0e8OgPmZ1+FmTrsTG+QQTj8gY9fGEfbZSeCTPrRzIRPDQcKz
fDTOcDGGFHPKnNuHcebsn/WGwDOePQ==
=0um9
-----END PGP SIGNATURE-----

--Sig_/b85qfGfcfjcxuS0Plctq78P--
