Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EFA3C606CF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 23:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40B892082A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 23:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="YQl0xJWG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbfGHX4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 19:56:33 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:53313 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725864AbfGHX4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 19:56:32 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45jMmZ4GLZz9s7T;
        Tue,  9 Jul 2019 09:56:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562630190;
        bh=QkU9zxBpIywNVjf2AXjCYb6R+plPvTZQHeVwEodK9ho=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YQl0xJWG7qB7KJq73pCHfdR3lRp4gBgfgMvI01cUkkMmJLzUQMSYFqzmJVvl6loKq
         Q8tCDRcLb4zzHsG+IKoUCxYgBTxIagayBPpWolKyp4396Imc/bdK8SYStfkzb07yRa
         gWYbXWurO3x/x76PDuLjavlrOw9qShMtaXLwCzytoklTMil8eBcP3IYAM5FeYsnwhA
         jS0XCjsKisijuep92RL9df5rieysdri1JOy7ZXDJ7Ap9gkdiklXFVj8qeRSsSo3u5O
         QjVI2n3LUJXc6sziDp6CGBAQzid6QNVfISWjtksaiLuw8JIoqt3GCNIY48KspNxwXi
         BHDvzYgzUq9Fg==
Date:   Tue, 9 Jul 2019 09:56:30 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Rob Herring <robherring2@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: linux-next: manual merge of the devicetree tree with Linus'
 tree
Message-ID: <20190709095630.41ce0fec@canb.auug.org.au>
In-Reply-To: <20190624155124.7bcae936@canb.auug.org.au>
References: <20190624155124.7bcae936@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/VRAspDWHl+wN9R=S.G02K+j"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/VRAspDWHl+wN9R=S.G02K+j
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 24 Jun 2019 15:51:24 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Hi all,
>=20
> Today's linux-next merge of the devicetree tree got conflicts in:
>=20
>   scripts/dtc/Makefile.dtc
>   scripts/dtc/libfdt/Makefile.libfdt
>=20
> between commit:
>=20
>   ec8f24b7faaf ("treewide: Add SPDX license identifier - Makefile/Kconfig=
")
>=20
> from Linus' tree and commit:
>=20
>   12869ecd5eef ("scripts/dtc: Update to upstream version v1.5.0-30-g702c1=
b6c0e73")
>=20
> from the devicetree tree.
>=20
> I fixed it up (I used the latter's SPDX tags as these come from an
> upstream project) and can carry the fix as necessary. This is now fixed
> as far as linux-next is concerned, but any non trivial conflicts should
> be mentioned to your upstream maintainer when your tree is submitted for
> merging.  You may also want to consider cooperating with the maintainer
> of the conflicting tree to minimise any particularly complex conflicts.

I am still getting this conflict (the commit ids may have changed).
Just a reminder in case you think Linus may need to know.

--=20
Cheers,
Stephen Rothwell

--Sig_/VRAspDWHl+wN9R=S.G02K+j
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0j2C4ACgkQAVBC80lX
0Gy+bAf+LbPXlnFN492SuJ47soeEyTvcJq5mbIif0w7trlBOSqmSG5HN1nOncmhn
yCnY/NfgM6dWsGQ3yEW28jkBvvRr2wNEWp6WZYoogXTRF4TUedNWV2fk0oj0OZGj
iPW7Sx4hUtaa241nxHwEq1siyto3KQ+XA9zWfmCeGjCQNNw1zIYK1cm58wq14CqS
PqP9doXyVeE09T4+u7jowv2Kgs1bqHm1j6Y7JGCVj+56/qPvZdL2uEXHfkh3mKyu
P3H/jvx7jkveGTghMM0NDMgoq2ncMogoL1gohZXQ2iFZNd6esxkMs6s+G9bx+6b5
hzIAPwKOIOl4vLOF4vkdeGCmmgQkNA==
=wOY+
-----END PGP SIGNATURE-----

--Sig_/VRAspDWHl+wN9R=S.G02K+j--
