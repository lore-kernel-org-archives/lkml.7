Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A6AC606CF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 23:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6983C216C4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 23:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="h10wNm91"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbfGHX6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 19:58:36 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:54577 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725864AbfGHX6g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 19:58:36 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45jMpy1xr5z9s7T;
        Tue,  9 Jul 2019 09:58:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562630314;
        bh=4s1IV4Ys7sn8J+3oC1uHd8nGhuq2hXgqTbykimfLHnI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=h10wNm91aeUBkFlt6cViCnJ9SvpKs36ZYv+FS0UbRvQAUifw6XNUYzt5w31i8fsbB
         iCLe6lU7X4f3RtGtFRxIKoBOBh4VRrq0azQJW5MMfpVmBhYR9dkLRz92FRBHawq6mZ
         /4HzA32cLBlf2YG1KS+EhuUn9qMhmKCOz+mjOK21UgJm7mS2k5lYVJmXfTN4s8tZwz
         KgjunzIPXbVg1Nxp8pFM9KZxN76+3Dsu/2HWpZ0FShhZT6iPDGvBD8+H2cBZKHwqfA
         oANiDoef4N9h3J2ZRskhQlV2NA4Vz1L/v0ttCZV+s8X+/y0E0sd5FtnZ18n43LqCG7
         rJgGW0vjwUVsw==
Date:   Tue, 9 Jul 2019 09:58:33 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Changbin Du <changbin.du@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: linux-next: manual merge of the usb tree with the pci tree
Message-ID: <20190709095833.727ac5e8@canb.auug.org.au>
In-Reply-To: <20190624174729.327f2edf@canb.auug.org.au>
References: <20190624171229.6415ca4f@canb.auug.org.au>
        <20190624073443.GA13830@kroah.com>
        <20190624174729.327f2edf@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/clzN8fStmJKe2nC0o8XjBGR"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/clzN8fStmJKe2nC0o8XjBGR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 24 Jun 2019 17:47:29 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the usb tree got a conflict in:
>=20
>   Documentation/index.rst
>=20
> between commit:
>=20
>   c42eaffa1656 ("Documentation: add Linux PCI to Sphinx TOC tree")
>=20
> from the pci tree and commit:
>=20
>   ecefae6db042 ("docs: usb: rename files to .rst and add them to drivers-=
api")
>=20
> from the usb tree.
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
> diff --cc Documentation/index.rst
> index 239100accbf6,91055adde327..000000000000
> --- a/Documentation/index.rst
> +++ b/Documentation/index.rst
> @@@ -101,7 -101,7 +101,8 @@@ needed)
>      filesystems/index
>      vm/index
>      bpf/index
>  +   PCI/index
> +    usb/index
>      misc-devices/index
>  =20
>   Architecture-specific documentation

I am still getting this conflict (the commit ids may have changed).
Just a reminder in case you think Linus may need to know.

--=20
Cheers,
Stephen Rothwell

--Sig_/clzN8fStmJKe2nC0o8XjBGR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0j2KkACgkQAVBC80lX
0Gwg3ggAjUDEqNFtzet2iMm0kXUhLGTxhrUgcsnKeA7DksuBvdY6jn+nfxnWuuo3
++4th8bhG9gKu/ZWEnnW8kxcRH7ELS6qWjU4LZw49pzU66zX0ZOqOKLu/3BTnmJQ
QNojZA/xtAhI83YkO1r6vDeCfZX3rc71JoNod9iohEpFfDQZnf8zUFh0njBanoFj
kh+NSOXPc22kBgSmAzB/uUhNIIUDex+N28gvEmnnfowwL6MUU4ni7qEW7gjyiy3p
rNPpzyUlPKIjyIM1Wi+54ipMkHqHGw1EVYUAFHBQl/YC3bjJEZirzYwyy6YmjQHD
kr+XxfQ4K2B2ky8a5leW/FJtlhHcxg==
=UjZB
-----END PGP SIGNATURE-----

--Sig_/clzN8fStmJKe2nC0o8XjBGR--
