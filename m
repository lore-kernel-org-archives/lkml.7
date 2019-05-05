Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C69C004C9
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 21:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7C262054F
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 21:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="hBPEOQSO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbfEEVXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 17:23:50 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:33267 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726636AbfEEVXt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 17:23:49 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44xzPt1tD4z9s5c;
        Mon,  6 May 2019 07:23:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1557091426;
        bh=YA/FcEGzJdyHad6E/Sm0uJk7a32AdcrEnIvIoxm8LMQ=;
        h=Date:From:To:Cc:Subject:From;
        b=hBPEOQSOO28rV9xpDmcnRfMMoj8naqJ1axba+f15/qlpqSFCmx/3OGY7aaiIcCEHH
         vX81kbxBgembkki2rOfN6caeDA09pRFzTfHNqpB2NMFKASIm0rheBW7ZmdnMTf1I8R
         4wWZRgRRgIrlwdxrhryWAMr+ubGlwxRwsaybNdYOrC/GnZBGGQ93y1Ar6i56OYn/U+
         vqZvtB4/Ec1NALk9YZmp8q6L4oLC+rLyXLxCxT0QwQKJ8vdItbdOuEKU4698piXK0v
         796wPdi73LcGdcHmSyEY8PlhvaqVU3mYg81dei93F7rPJGgATTrhnN4sDJheH3CwiK
         eymxjlbyPwuIg==
Date:   Mon, 6 May 2019 07:23:34 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Ahern <dsahern@gmail.com>
Subject: linux-next: Fixes tag needs some work in the net tree
Message-ID: <20190506072334.5eeb8858@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/iIoaWuLbT45b0W=22c.g9UB"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/iIoaWuLbT45b0W=22c.g9UB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  64c6f4bbca74 ("neighbor: Reset gc_entries counter if new entry is release=
d before insert")

Fixes tag

  Fixes: 58956317c8d ("neighbor: Improve garbage collection")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/iIoaWuLbT45b0W=22c.g9UB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzPVFYACgkQAVBC80lX
0GzgSQf/c6OvVDblN1/YNpJhV/j2sx2hjoI5gDJX3J2y1AR+2+BPmP/SDRL3ZJmM
8ukm5AsBNqrIeYWlM9sSzjOoQd8DSvyviJcvXJRdGU8aHothh+5LYNcgYGY4/D9J
JU0czzAObzpo7I5+/Wlse7k1qwqWHTLJLc7QbUbMihagc++flkjUP1XO+eOeT7qo
QSHTveRrhX+E0nF6WLanSEVsMeofWf+ANI44cy9GyI68/ElhTT4Pk6G0rgEPtnp3
E2Ct31QNroLOdwVHevUmYTBEW0zP0bRjCALxIi4MJvSlp8FmEgO6QEAhmzImDtW0
706zq/XALUR8RVfwZJq7AFf5HU9ofg==
=QLd4
-----END PGP SIGNATURE-----

--Sig_/iIoaWuLbT45b0W=22c.g9UB--
