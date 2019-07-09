Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC00C606D3
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 00:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0B152166E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 00:10:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="UQhFZ5rz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbfGIAKi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 20:10:38 -0400
Received: from ozlabs.org ([203.11.71.1]:45489 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbfGIAKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 20:10:38 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45jN4q0QrZz9sMr;
        Tue,  9 Jul 2019 10:10:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562631035;
        bh=gvZokDxuPO9112lKMc9/IhGR491NEFckMVw7WpN/e9Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UQhFZ5rzSMCf6dg1aJo35ef2avabXhjH5WtJYZwFfn9GU28I19L0WDkpPpL/eHdWD
         gozKodYv1TIidrEWG+ySA/5yR670pEvGI8sJGJibNCd4E7xD0xOwcToqXm6o1U94gr
         WqGEhJwEZJPvuq/nXxaHm+H7aIeR4ju0KITwzAkzX0TNJundCNtCg/GWw5lFef68ac
         ajZR7xVCLo+yvAcv2LdNfOYCI7SOpc1JA7jaSKjsOh2gm0gxebHYxhGGLAanoTXuo0
         RdUZIh/qpR+m2kEDolpwIOhbdDJIjpTeSFIGHP2asMM0S/bpQs5+rNMeu8sAXVhUUM
         Gc/2A/vO4FQuw==
Date:   Tue, 9 Jul 2019 10:10:34 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Howells <dhowells@redhat.com>,
        Tyler Hicks <tyhicks@canonical.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: Re: linux-next: manual merge of the keys tree with the ecryptfs
 tree
Message-ID: <20190709101034.0dd2cc1e@canb.auug.org.au>
In-Reply-To: <20190626142838.0f9bb5d6@canb.auug.org.au>
References: <20190626142838.0f9bb5d6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/U6OHKL0QvDPpbDp6EMk/PBI"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/U6OHKL0QvDPpbDp6EMk/PBI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 26 Jun 2019 14:28:38 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>=20
> Today's linux-next merge of the keys tree got a conflict in:
>=20
>   fs/ecryptfs/keystore.c
>=20
> between commit:
>=20
>   29a51df0609c ("ecryptfs: remove unnessesary null check in ecryptfs_keyr=
ing_auth_tok_for_sig")
>=20
> from the ecryptfs tree and commit:
>=20
>   79512db59dc8 ("keys: Replace uid/gid/perm permissions checking with an =
ACL")
>=20
> from the keys tree.
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
> diff --cc fs/ecryptfs/keystore.c
> index 216fbe6a4837,ba382f135918..000000000000
> --- a/fs/ecryptfs/keystore.c
> +++ b/fs/ecryptfs/keystore.c
> @@@ -1611,10 -1610,10 +1611,10 @@@ int ecryptfs_keyring_auth_tok_for_sig(s
>   {
>   	int rc =3D 0;
>  =20
> - 	(*auth_tok_key) =3D request_key(&key_type_user, sig, NULL);
> + 	(*auth_tok_key) =3D request_key(&key_type_user, sig, NULL, NULL);
>  -	if (!(*auth_tok_key) || IS_ERR(*auth_tok_key)) {
>  +	if (IS_ERR(*auth_tok_key)) {
>   		(*auth_tok_key) =3D ecryptfs_get_encrypted_key(sig);
>  -		if (!(*auth_tok_key) || IS_ERR(*auth_tok_key)) {
>  +		if (IS_ERR(*auth_tok_key)) {
>   			printk(KERN_ERR "Could not find key with description: [%s]\n",
>   			      sig);
>   			rc =3D process_request_key_err(PTR_ERR(*auth_tok_key));

I am still getting this conflict (the commit ids may have changed).
Just a reminder in case you think Linus may need to know.

--=20
Cheers,
Stephen Rothwell

--Sig_/U6OHKL0QvDPpbDp6EMk/PBI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0j23oACgkQAVBC80lX
0GxbTwf+MPWWMsT/2NS027UqyMYEGVo5cfAbdIeq2QbwNvC9/nJqI0Ol4y2xgjK+
pPVnfR7WMv8FvN3PCiSuuFIkEPp/LaaIMqzt19v4yGhCIpQFOOIw1OuasqoiDZR6
keeLO9Rcr4NSF4QzYXTYEkpCBuJtgQCGdx1oUsE73x6aqZw/yupwOwmk1ozqUaO9
//avhrlVb0T8Qm2pg7vAAtG0/pCP6/VBWyRBT/2rX16XBJwyX68ZI5crakoXp+/8
GNAkmaf7KlQrw7HiuigyPuKXxeHd2yfgpVQoQGH5hM9vIGLyc010Y8XOw7c7sgLr
3dvwJqx6v+EG5aj/7DWLXd1FJeS4Yg==
=HKiU
-----END PGP SIGNATURE-----

--Sig_/U6OHKL0QvDPpbDp6EMk/PBI--
