Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F269C606D3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 23:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46CF2216C4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 23:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="cEXyOvl/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbfGHXRu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 19:17:50 -0400
Received: from ozlabs.org ([203.11.71.1]:46593 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbfGHXRt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 19:17:49 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45jLvv56mTz9sML;
        Tue,  9 Jul 2019 09:17:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562627867;
        bh=WtCalfDt8m92LU1IS6tuPSj/O7ALiiMZLZk+kov266Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cEXyOvl/4M21Hd868tcdAV+tBgRsw1HkurnP4uB6tv/BrgaI4lxufR6Fk17q8wZgB
         SbAY9CUibNYlwvBPKFA8bMZ4ydNzTVndlFTFZOBpMGcimOu2eto2/iHnYhBU7khzQF
         n+xexsbE9Eneq4bjh9+0xHRoWx5gIKdVh5ePCZFqaBa5s1n+E9jO8fd46gj73poTSv
         dyBWjseKK1ftA7PLzoAN8YSaZYwuzJBhfnJSkIyI88jgXPDLgOja/Aw0ZCcqvkSf8g
         P6BgDxWJJDHcYKAXyJyztf4xrPdtvas06uBTip4/fKrmJzrQiTWRHh+e0gNmYjW2FW
         DVQiRXeohdyWw==
Date:   Tue, 9 Jul 2019 09:17:47 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christian Brauner <christian@brauner.io>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: Re: linux-next: manual merge of the pidfd tree with Linus' tree
Message-ID: <20190709091747.29a2e71b@canb.auug.org.au>
In-Reply-To: <20190606154034.7d8ba5d9@canb.auug.org.au>
References: <20190606154034.7d8ba5d9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/64XGlB9TNf1OnFfzZW37iDQ"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/64XGlB9TNf1OnFfzZW37iDQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 6 Jun 2019 15:40:34 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Today's linux-next merge of the pidfd tree got a conflict in:
>=20
>   tools/testing/selftests/pidfd/pidfd_test.c
>=20
> between commit:
>=20
>   1fcd0eb356ad ("tests: fix pidfd-test compilation")
>=20
> from Linus' tree and commit:
>=20
>   233ad92edbea ("pidfd: add polling selftests")
>=20
> from the pidfd tree.
>=20
> I fixed it up (I just used the latter) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

I am still getting this conflict (the commit ids may have changed).
Just a reminder in case you think Linus may need to know.

--=20
Cheers,
Stephen Rothwell

--Sig_/64XGlB9TNf1OnFfzZW37iDQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0jzxsACgkQAVBC80lX
0Gwf5Af/fzvUM1z843FD6Mf4RpGJgS08KccRcoh6OToPg8nBudaXEyV7Rgy4hxMO
3GFaCifpZkpdQ+m9xMbHexa8O8wOf9oZay9n1nHzpwwQwZERn3zumfccnpK1v3Mm
Yyfhe29VRH2Z/g5vLprQjZA4V3g2Y8o44KA+kRtFt0kooNkc+no1kIKWWVVdbdIV
gElyhxRKxHW0quzViRmlhm14ILtyv2fgitsGB7LQNEKZuF3n0YTE3xyMw1mwnZIl
vk7Zpw64CLEPqa8id1YDKix51lAW6mEBCSnRy233cHiROkcc9ldb0I8iTKiniyZb
s18f4RF32ZTVPCJ1F+XB1ZTdLo1iLw==
=FZFe
-----END PGP SIGNATURE-----

--Sig_/64XGlB9TNf1OnFfzZW37iDQ--
