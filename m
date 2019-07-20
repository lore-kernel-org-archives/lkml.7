Return-Path: <SRS0=8q5G=VR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A035C7618F
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 03:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC8752082A
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 03:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="rFultG+R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390502AbfGTDRZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 23:17:25 -0400
Received: from ozlabs.org ([203.11.71.1]:40717 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728970AbfGTDRY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 23:17:24 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45rCjF5zkRz9sNF;
        Sat, 20 Jul 2019 13:17:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1563592642;
        bh=dIWlKJVTn+8E/8g9SA1pwAK9H4gFLZqBuBaa3R9B6p4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rFultG+Rl6cZFhyHskI2Qge+pTcPKxU4VMPfvIESMqb/yWSlFMeUuQmANbKoIJEJd
         rMGGL8DTWehZFS1YARJKUB1fyBj+nE1UZj9tNZJMTxLry01P34dGaxeWO+hlSei2Pi
         v6j0QW8KgDxz5J60LGkZjM62CfdjB2XeYEFwTg6QuL3p6QmOx7dO4bl3u4c0mxx/bi
         W8NydIopIup/H/oL3bbEi4SlF5ZdWfhf4nIBepF0U+YjoQI15nRNEb0O37N86w8JTh
         v+HH+6cN+06bKEk+/1fTG5H7LxpXeGeqZ04kYTbCjpl/JxHioE5mObDZwObiEucilS
         qFqhvjqiDA4Fw==
Date:   Sat, 20 Jul 2019 13:17:19 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Joe Perches <joe@perches.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] checkpatch: Improve SPDX license checking
Message-ID: <20190720131719.6eb1855c@canb.auug.org.au>
In-Reply-To: <a91f850658e6d2ba206639e214ee47a0dcd90f38.camel@perches.com>
References: <f7dc9727795db3802809a24162abe0b67e14123b.1563575364.git.joe@perches.com>
        <f08eb62458407a145cfedf959d1091af151cd665.1563575364.git.joe@perches.com>
        <20190720122203.7baf841a@canb.auug.org.au>
        <a91f850658e6d2ba206639e214ee47a0dcd90f38.camel@perches.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/GL_PGayyjzXhFUn+aM4jA5a";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/GL_PGayyjzXhFUn+aM4jA5a
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Joe,

On Fri, 19 Jul 2019 20:09:19 -0700 Joe Perches <joe@perches.com> wrote:
>
> On Sat, 2019-07-20 at 12:22 +1000, Stephen Rothwell wrote:
> > Hi Joe,
> >=20
> > On Fri, 19 Jul 2019 15:31:33 -0700 Joe Perches <joe@perches.com> wrote:=
 =20
> > > Use perl's m@<match>@ match and not /<match>/ comparisons to avoid
> > > an error using c90's // comment style.
> > >=20
> > > Miscellanea:
> > >=20
> > > o Use normal tab indentation and alignment
> > >=20
> > > Link: http://lkml.kernel.org/r/5e4a8fa7901148fbcd77ab391e6dd0e6bf9577=
7f.camel@perches.com
> > >=20
> > > Signed-off-by: Joe Perches <joe@perches.com>
> > > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au> =20
> >=20
> > Again, don't include other's (non author's) SOB lines. =20
>=20
> Nope.
> You _already_ signed-off this patch.
> I'm simply reproducing it.

My SOB line is *only* there because I am publishing that patch in
linux-next.  When Andrew sends that patch to Linus, my SOB should not
be there (since I will no longer be in the handling path).  My SOB does
not say anything about the correctness or otherwise of the patch.

Equally, if you sent that patch to Linus, Andrew's SOB should
(probably) not be there.

--=20
Cheers,
Stephen Rothwell

--Sig_/GL_PGayyjzXhFUn+aM4jA5a
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0yh78ACgkQAVBC80lX
0GyO8wf+MQ+OFdMqSCBtSsOkIviLjvhZVB2o1Q/G4zUKQYSdB3iMCcpic8kYFeVn
LtYFZ5YND/e8SuJbiqflafkWPy8E1mHBcDOjSFevU43/8LpsTDPtCRM7oFG0iAPc
NN0ATcM6yNiQlmQBO7wOHZqg3JL9UL3d8WG4W6UyJxCN8pT2vvdHpwAAu31JF+UA
+84xPA9AYBnNgBCQQBLP6rAhDxIDNJL22zLWgjd1Doo71CZMiZXWlwlR++Cb0tar
MFJzo9co66xJsOE9C74UPgSvAY3PSzftb/tp4frfRLuvhuiUa5PsobNf4AH3t9g7
JMZTLEzIzP0RnNjn3dZJokTBMPM89Q==
=DS7m
-----END PGP SIGNATURE-----

--Sig_/GL_PGayyjzXhFUn+aM4jA5a--
