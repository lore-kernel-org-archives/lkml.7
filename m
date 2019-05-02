Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C9AC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 10:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 295AC2085A
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 10:31:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="jFgyXTcT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbfEBKb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 06:31:28 -0400
Received: from ozlabs.org ([203.11.71.1]:41749 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726231AbfEBKb1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 06:31:27 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44vs4X6vJ5z9s7T;
        Thu,  2 May 2019 20:31:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1556793085;
        bh=fxoVg9h+kRuZKsyuxazSaU9XgWhIb3j3CtzDT2q+fYM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jFgyXTcTelyM32fDtDJlCMpwis2o2mi8tQl3WWjGnkyq+pcpy8yoRmOUZ0km3gSCe
         cFwoJ83E/PlyJtU2daz+XrKF5hXgQE4J72xGnGVgQdj3TesZhRSMMeHnnLwRYhQOKs
         LDBmCqdsgNbqM7+AJobaWGqLgrDLdcSommy8fIavV/fEfg2EYDk/HqZc9e8yn6AmUc
         nPwP8nFptyviW8VblGZ3K54pcbg2nR7PF8Y9fdIfmuW0yclo+f/tIfpo7EtiCbiJTv
         WG78yekx+nz+8/ojDDp+6sAY9iYnwVwA8P05I6jh6A9pOPdLRLU2C2ssbg7d594W85
         uNS2lWEWW6Eew==
Date:   Thu, 2 May 2019 20:31:23 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the vfs tree
Message-ID: <20190502203123.15af8e1e@canb.auug.org.au>
In-Reply-To: <20190502202515.22f72e48@canb.auug.org.au>
References: <20190502202515.22f72e48@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/uqFtcdIHMF7hK9QC3FSlJXR"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/uqFtcdIHMF7hK9QC3FSlJXR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 2 May 2019 20:25:15 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> In commit
>=20
>   4e9036042fed ("ufs: fix braino in ufs_get_inode_gid() for solaris UFS f=
lavour")
>=20
> Fixes tag
>=20
>   Fixes: 252e211e90ce
>=20
> has these problem(s):
>=20
>   - missing subject
>=20
> Did you mean
>=20
> Fixes: 252e211e90ce ("Add in SunOS 4.1.x compatible mode for UFS")

Actually this is in the vfs-fixes tree.
--=20
Cheers,
Stephen Rothwell

--Sig_/uqFtcdIHMF7hK9QC3FSlJXR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzKxvsACgkQAVBC80lX
0Gw4pQf/S1rYC9JOWuKL1xsllPvJDeMBdrqlfcYbAua4/SLRocIsy8p6jG5Qe/y9
ZCdK2Fvi1oKK8cAm+X0sA0GcRVa+ykNIiWu2sOlM5dBAC0S06YJzo5FEcMBYrFgr
overjwpNuH8r+lJQ9xSHUYLxYI2YrQqC87UnT5ShE3naaG9tWh/1fKtIO940NqKR
NZqBUXj/ycJLcCZU+XTyDPgI4XSAkrs0hiMYh14h+0dVwaMPWaErxT+H1/FMuxK3
u3I/AgbMm3UqBtBawNmrtJST5IQfWepW0ZpkS8JwRukXgF9Dw9v0+EVAaJeOdPWy
V9KKGHZG93MaQ2wex+bm+n7W6mOmHQ==
=aGHT
-----END PGP SIGNATURE-----

--Sig_/uqFtcdIHMF7hK9QC3FSlJXR--
