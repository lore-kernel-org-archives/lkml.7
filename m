Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92585C742A5
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 00:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 656452084B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 00:57:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ct/FA1yq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbfGLA5A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 20:57:00 -0400
Received: from ozlabs.org ([203.11.71.1]:52719 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728102AbfGLA5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 20:57:00 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45lDyx4LqNz9sN4;
        Fri, 12 Jul 2019 10:56:57 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562893018;
        bh=R0WvOwdCeRAjTSEmmcT3H8ltBOmtPfkxqbiDyjI65vs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ct/FA1yqEk4bjjkqEpFGdNbmx/91Nq1gOZziVYRTtKjYZ5hll5L+rU0aSp05npZqm
         rY2Lp5v3SLkaqR7hq4fwHHqpgQI8KLoImYhcHyFwwhPhGSToj+EXoutNwYPCqPnj4E
         veD3Rkd6djjFisH8vUgk9T9wlD7pqelN7g+wNs0Hw2jH83XzngObQXSNKd4rXoyI3v
         wcnGbi1IuwtVIlHB15VEafzgmlYj77lIHI6cOuUI/WVmz0PbDK8jvAGSa6z6sB7mNx
         rAF3IDGdRm5vaf99DSFJQ15GqSTYtjwXR4fAApSKvHNlv1DYtx46UdE1K9WU7ENRY+
         gF+lFCh8q9rWA==
Date:   Fri, 12 Jul 2019 10:56:56 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Steven Whitehouse <swhiteho@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Price <anprice@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: Re: linux-next: manual merge of the gfs2 tree with the vfs tree
Message-ID: <20190712105656.04e8ed23@canb.auug.org.au>
In-Reply-To: <20190708134842.1e947318@canb.auug.org.au>
References: <20190708134842.1e947318@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/V0LdOv6ZAuGfS1Z=/9qTNQQ"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/V0LdOv6ZAuGfS1Z=/9qTNQQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 8 Jul 2019 13:48:42 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Today's linux-next merge of the gfs2 tree got a conflict in:
>=20
>   fs/gfs2/super.c
>=20
> between commit:
>=20
>   000c8e591016 ("gfs2: Convert gfs2 to fs_context")
>=20
> from the vfs tree and commit:
>=20
>   5b3a9f348bc5 ("gfs2: kthread and remount improvements")
>=20
> from the gfs2 tree.
>=20
> I fixed it up (I just used the vfs tree version since it removed some of
> the code modified by the latter) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

This is now a conflict between the vfs tree and Linus' tree.
--=20
Cheers,
Stephen Rothwell

--Sig_/V0LdOv6ZAuGfS1Z=/9qTNQQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0n2tgACgkQAVBC80lX
0GyUAQgAo4MANi5ZfGplRz1n0TQtSxDFroBlpVUFa5+SSoRFFaTeOy9aUEII+fXw
SkkQ6Ux6pPL+CD7Yo+9kW2qt2D0ZjQlEXJ/CEhTKeb4e9ihbuoutphyyDF8W3ARD
qvpyw7MAvAhnyo6E0DkI7LP7W2C/Q4teYZe0xrzFMzWm2M1cVd71IjbOOwpn+ZVf
Wonjvrx3+OEKyHwK6fsH6+2viQBtRFgvhowrcPxCI7jjiZGtTolA6pcIE4tdaVO3
QPnRoa4EqtMfs3p+j9eU2hx1aMmU2LqU4afrsPFc/MYbWb7VCNWf/TjWXQiDayjD
JDL+JngwHeJGgcMv4mEPJeEctv2j7w==
=Txrm
-----END PGP SIGNATURE-----

--Sig_/V0LdOv6ZAuGfS1Z=/9qTNQQ--
