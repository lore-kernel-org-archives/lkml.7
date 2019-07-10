Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A92C73C65
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 00:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4CB82081C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 00:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="fCNHUNv4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbfGJAKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 20:10:52 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:52847 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726218AbfGJAKw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 20:10:52 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45k02Z0CPWz9sNT;
        Wed, 10 Jul 2019 10:10:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562717448;
        bh=aje3qxoBM4jR9gwrtVjQf9LBOywN3qK6W7j1K/1yo9c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fCNHUNv4edxOH+Ki7HKSJdAGtKGxrN46iHZF7epuZiOjwjRqi9Wlitv+PjKlduM+o
         DGGVyltY27H3u8zqF6CGlaj8a61+8nDAPggRitsRQJFhxrtCS2udaJzJhf6SK6n9GX
         2gjNChvuh+xkuj+GfwlIZ7q1KHvgVYScRbKhXdp3ni+x3RQNKpEziCJzKWrsHuAT4r
         ZO4gXFzRjpmIZ9g7ok+3vt662GO3vUBBu5JU6mE43Xkwy7PK8EFxL3Vi2Em7E/6p6t
         zKdYxrchekTCt72QvV+QhnxdlGTximppIYULuo+qhbQHT1XV0vXcAzgngx8ffXUkA3
         YiMpnqmTJeLLg==
Date:   Wed, 10 Jul 2019 10:10:44 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jonathan Corbet <corbet@lwn.net>, Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        "Tobin C. Harding" <tobin@kernel.org>
Subject: Re: linux-next: manual merge of the jc_docs tree with the vfs tree
Message-ID: <20190710101044.499cc273@canb.auug.org.au>
In-Reply-To: <20190708115032.098e7302@canb.auug.org.au>
References: <20190708115032.098e7302@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_//I+qp68hEYYgPmC+gUo4Fad"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_//I+qp68hEYYgPmC+gUo4Fad
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 8 Jul 2019 11:50:32 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Today's linux-next merge of the jc_docs tree got a conflict in:
>=20
>   Documentation/filesystems/vfs.txt
>=20
> between commit:
>=20
>   51eae7431ded ("vfs: Kill mount_single()")
>=20
> from the vfs tree and commit:
>=20
>   af96c1e304f7 ("docs: filesystems: vfs: Convert vfs.txt to RST")
>=20
> from the jc_docs tree.
>=20
> I fixed it up (I removed the file and added the following merge fix patch)
> and can carry the fix as necessary. This is now fixed as far as linux-next
> is concerned, but any non trivial conflicts should be mentioned to your
> upstream maintainer when your tree is submitted for merging.  You may
> also want to consider cooperating with the maintainer of the conflicting
> tree to minimise any particularly complex conflicts.
>=20
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Mon, 8 Jul 2019 11:48:39 +1000
> Subject: [PATCH] docs: filesystems: vfs: update for "vfs: Kill mount_sing=
le()"
>=20
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  Documentation/filesystems/vfs.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystem=
s/vfs.rst
> index 0f85ab21c2ca..a65ee69f02d1 100644
> --- a/Documentation/filesystems/vfs.rst
> +++ b/Documentation/filesystems/vfs.rst
> @@ -195,8 +195,8 @@ and provides a fill_super() callback instead.  The ge=
neric variants are:
>  ``mount_nodev``
>  	mount a filesystem that is not backed by a device
> =20
> -``mount_single``
> -	mount a filesystem which shares the instance between all mounts
> +``vfs_get_super``
> +	mount a filesystem with one of a number of superblock sharing options.
> =20
>  A fill_super() callback implementation has the following arguments:
> =20

This is now a conflict between the vfs tree and linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_//I+qp68hEYYgPmC+gUo4Fad
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0lLQQACgkQAVBC80lX
0GxOSgf/YMPy8wShKR5k3kS71Ruc6tAV59+80c+PS5Je/cZbYLhAtsaTLb8nN+jQ
GqIrGKcj6D3WWexMIRtHRYRL+FggVBpfHQNmBfo4oFjXzPKTdghgGCBfNGImd0/e
SY1YNfrbzMaWRvFx8UUcG9rfjoYJxyvvNb923zoO81laVSyfZjPyxfF4MqfjcY2P
IK9zoTw20Ud+/RPNZVy9n8kVd9vSnLeqVxInNRxoWtxvMtXeTN4JKT9jTQiknfd2
9Vq0z2grumb/Owim56JMbgSOlbg9ZZ/kN8xY/cuWc+ItDivrgs7ncVH2KNJAinHG
eFHuR//E7fyJFje36D+YwklFfONAgA==
=CC12
-----END PGP SIGNATURE-----

--Sig_//I+qp68hEYYgPmC+gUo4Fad--
