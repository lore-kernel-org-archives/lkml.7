Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6CB6C004C9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 02:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A08120C01
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 02:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Zl3pXLCP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbfEHC0A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 22:26:00 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:41989 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726378AbfEHC0A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 22:26:00 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44zL1c2zDlz9s4Y;
        Wed,  8 May 2019 12:25:56 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1557282357;
        bh=r0sxFfvkcnAM0eOWC+Wx4TYgz1T4ZUYb0tKs08EMrWs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Zl3pXLCPCau8o1BzK/vKkt5g0f3YB7+VkEMQ9gYll9OKx26tUX2MElwyc77MgTvuv
         gwvC0XB8qxYfIEgklYorMpCTTPdo+72ki0AtAZE0fU9DGBLaNvQHZEiO2OsT4pbqim
         ik6FNVBkNdjh3r/UOTgJaTP7f141nAjPjpjwv369ISyA/looJPkTzmr+RcYqh9WoEY
         IkGd8JVJNiB4zmrVvj4UI9Siyc0okmdTGxuLRYFvX2DgOEqcseVHLoIsp0mlQJTmpb
         I9tUwdVOHoYeXJDFT+MkwAJExDK8+uZqfIDtKyABB+4GFyZqENmuJpbxtvVk801nb+
         Nix4jue9IobRg==
Date:   Wed, 8 May 2019 12:25:55 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, Jens Axboe <axboe@kernel.dk>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Weiping Zhang <zhangweiping@didiglobal.com>,
        Kimberly Brown <kimbrownkd@gmail.com>
Subject: Re: linux-next: manual merge of the driver-core tree with the block
 tree
Message-ID: <20190508122555.5a19caea@canb.auug.org.au>
In-Reply-To: <20190429152400.281524b7@canb.auug.org.au>
References: <20190429152400.281524b7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/sG1p5DfB8xej.FWcOlfTBd1"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/sG1p5DfB8xej.FWcOlfTBd1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 29 Apr 2019 15:24:00 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the driver-core tree got a conflict in:
>=20
>   block/blk-sysfs.c
>=20
> between commit:
>=20
>   4d25339e32a1 ("block: don't show io_timeout if driver has no timeout ha=
ndler")
>=20
> from the block tree and commit:
>=20
>   800f5aa1e7e1 ("block: Replace all ktype default_attrs with groups")
>=20
> from the driver-core tree.
>=20
> I fixed it up (the former stopped using the default_attrs field, so I
> effectively reverted the latter changes to this file) and can carry the
> fix as necessary. This is now fixed as far as linux-next is concerned,
> but any non trivial conflicts should be mentioned to your upstream
> maintainer when your tree is submitted for merging.  You may also want
> to consider cooperating with the maintainer of the conflicting tree to
> minimise any particularly complex conflicts.

This is now a conflict between the block tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/sG1p5DfB8xej.FWcOlfTBd1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzSPjMACgkQAVBC80lX
0GwAEAf/SjDtNontGW8LP5x1OAJL84WrzeYNaYdts/lHIN/ghgAORAkAAH2mwzIY
4I8ap8JLMAtJojTqCHYpumc3Yh8czWrVJtFTbH04DXogOmFumiT4SM3AmrsaW2Fw
e9i5a6fgto+C6Pk6HtJq0aetxYDWPdB/8XWjouBC8AdWHNNFyLYUzq5vG99FfxI8
F/dgWy4HlrFxpXhP4Mw3H4NhtWchoR7RslVc+l+WMuT3lp5GtwGwFfpQCeaRKDuk
WcILyLcXPV5UWTjV444E8OMz0JyQ+r6Es6hzJz83L460+79KxdV0DzZMLuBh3Azq
Gtyu0mhw1sxViglZ6RqTWX+g6PvSQw==
=PMNA
-----END PGP SIGNATURE-----

--Sig_/sG1p5DfB8xej.FWcOlfTBd1--
