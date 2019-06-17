Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C644C31E58
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 09:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B5732087F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 09:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="YbmA7fSX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbfFQJtE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 05:49:04 -0400
Received: from ozlabs.org ([203.11.71.1]:46445 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726048AbfFQJtD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 05:49:03 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45S5yP0DPLz9sDX;
        Mon, 17 Jun 2019 19:49:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1560764941;
        bh=A3gq5DWaBnsG+nyNgGh44hy1hkBKp2cGfOnCCsFC/Fk=;
        h=Date:From:To:Cc:Subject:From;
        b=YbmA7fSXiGhkk5KU/CztidRKXCVIlhobEQG94+gEmajCLLkMMTQEZoxlitqGIRFDq
         R6sMxjccV4GS9bwqJN8rdA8id2TZTQIvuKdpgwcSONcmOqhFwXaCd7Yg4dvj5+vbOE
         neleRcN0DOOi6kmSXeVIslmQzJ83Kj8qJa938gaPsPFD9Z1M7qun0k5B//dDM53p3T
         RXJKPIkz/ppyt6lshvhW2mPTYv0sh6NtiMmsDrnrjhztGum6DJoMy+ucdjqyaRML9f
         BzaZDFPJ0OzJx3yaUZzSFWJRQT3kkirIPDsFHJgmFc/gyQ9ayXC8lyzvolHyMsNNXq
         I64fslW98VigA==
Date:   Mon, 17 Jun 2019 19:49:00 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steffen Klassert <steffen.klassert@secunet.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Florian Westphal <fw@strlen.de>
Subject: linux-next: Fixes tag needs some work in the ipsec-next tree
Message-ID: <20190617194900.02d13c09@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_//OMI5uG7L7sng0Tdf2Qoq4k"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_//OMI5uG7L7sng0Tdf2Qoq4k
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  1be451d99317 ("xfrm: fix bogus WARN_ON with ipv6")

Fixes tag

  Fixes: 4c203b0454b ("xfrm: remove eth_proto value from xfrm_state_afinfo")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_//OMI5uG7L7sng0Tdf2Qoq4k
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0HYgwACgkQAVBC80lX
0GxVygf/QlOYSK0D+ZEZLH2SoUzAeastCjWRDekFanVDuaxdMBKWOle/q3OxuVI0
dOLhgAZQCD2ZzlzWo9OXkNZK9SBZSTpk3X6X4NWiAgFi4n3GlvxA/JVUug9gtJas
6zx7YBChXmsyTfW15Bf7oZQfIvrLRV58b7LxFG9P1hDks03APPoxiF3ijAwOYTyC
MdBCcTiPxVKNQnu3GOZRjgpGUGOQv4P3bxENG+JZM7E4y5UgXgvRMniMWkhKKODc
jEmkcdsphw94Hc5AZJpVbnzZ+Sx/pglJ9KwzHIlcSAF9BJWYsQkosS2yfSxgQARO
sDVj37ZhlQzKol9b4Er2ihW+I4f1nw==
=o1gT
-----END PGP SIGNATURE-----

--Sig_//OMI5uG7L7sng0Tdf2Qoq4k--
