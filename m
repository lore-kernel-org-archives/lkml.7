Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF4F4C606CF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 00:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96BEE216C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 00:00:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="hLB1Giqx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfGIAA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 20:00:29 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:43515 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725864AbfGIAA3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 20:00:29 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45jMs55xbdz9s7T;
        Tue,  9 Jul 2019 10:00:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562630425;
        bh=yyzMQCBCn3yaEOD2kcmP6H5Z6bh2H40HEbnNjULnlvE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hLB1Giqxja4eNPTe/uAE4LNO+cLqMuKx/Ul7gZTdXclygo96/TPrnmzuo6qfr98Lh
         vYQIyC2Ny0vfSN3sdiO9535sW7FafewJKHjMP4YZIZQrX3oHnwai+RDxjDDdMhUQxe
         WujF/bYwk81eCZDHtqE0GcE1o5dpZO0V+eU6qvn42wmkQY1VMz6f5/iBntOOrtqeEa
         MRKWk2VQokmk6b38o3KIG7iYC+GBo+ChGhx5EIx1+hB9iVgy+qNQG5b4Oz8aIx+X5+
         +mYm+Fb0Fern2NZYI0xtmPp+/kD/tJTQ6kG2wTeRnpkROxujMpEqOtufx7+jw379X5
         kNsgLu8FV6l7Q==
Date:   Tue, 9 Jul 2019 10:00:25 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: linux-next: manual merge of the cgroup tree with the block tree
Message-ID: <20190709100025.1e829b58@canb.auug.org.au>
In-Reply-To: <20190624175238.5ce3db2f@canb.auug.org.au>
References: <20190624175238.5ce3db2f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/y=BKtFaB=r0.yXpiKMaitef"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/y=BKtFaB=r0.yXpiKMaitef
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 24 Jun 2019 17:52:38 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the cgroup tree got a conflict in:
>=20
>   Documentation/block/bfq-iosched.txt
>=20
> between commit:
>=20
>   8060c47ba853 ("block: rename CONFIG_DEBUG_BLK_CGROUP to CONFIG_BFQ_CGRO=
UP_DEBUG")
>=20
> from the block tree and commit:
>=20
>   99c8b231ae6c ("docs: cgroup-v1: convert docs to ReST and rename to *.rs=
t")
>=20
> from the cgroup tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> --=20
> Cheers,
> Stephen Rothwell
>=20
> diff --cc Documentation/block/bfq-iosched.txt
> index f02163fabf80,b2265cf6c9c3..000000000000
> --- a/Documentation/block/bfq-iosched.txt
> +++ b/Documentation/block/bfq-iosched.txt
> @@@ -537,10 -537,10 +537,10 @@@ or io.bfq.weight
>  =20
>   As for cgroups-v1 (blkio controller), the exact set of stat files
>   created, and kept up-to-date by bfq, depends on whether
>  -CONFIG_DEBUG_BLK_CGROUP is set. If it is set, then bfq creates all
>  +CONFIG_BFQ_CGROUP_DEBUG is set. If it is set, then bfq creates all
>   the stat files documented in
> - Documentation/cgroup-v1/blkio-controller.txt. If, instead,
> + Documentation/cgroup-v1/blkio-controller.rst. If, instead,
>  -CONFIG_DEBUG_BLK_CGROUP is not set, then bfq creates only the files
>  +CONFIG_BFQ_CGROUP_DEBUG is not set, then bfq creates only the files
>   blkio.bfq.io_service_bytes
>   blkio.bfq.io_service_bytes_recursive
>   blkio.bfq.io_serviced

I am still getting this conflict (the commit ids may have changed).
Just a reminder in case you think Linus may need to know.

--=20
Cheers,
Stephen Rothwell

--Sig_/y=BKtFaB=r0.yXpiKMaitef
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0j2RkACgkQAVBC80lX
0GzxCQf/VhREDuKvx52lI5t6TIkydOHtMKOwPPKsoYRs5ZxuPMpff8CH2ok2oj/Q
3uVih94gNvp6UwHGXA+4H+9ja9NMVS6JpoiIlnSN2k9U2+pLPF0xw+HV+rs/N/bk
6emV3BRtZIxs0AqH4GcmkUsfo0pKWE3XT+8lLkObLWyTuO3Le6rMLQSTPTABk/vx
Lg7Ujn8ngeL1i2WkzJY9TLoLY79easg4aPVvps0CMFurqrVtXA1cCSGduTDSiMjr
yAvz8KJrefoVFP7QhAAE0F3Kk27BGlShzmCjfkJdh6icWsjLZQj6J+8mcESVplOr
s1dZAav0D7fR/yhNnhpAMmCEuPqlUA==
=BDFC
-----END PGP SIGNATURE-----

--Sig_/y=BKtFaB=r0.yXpiKMaitef--
