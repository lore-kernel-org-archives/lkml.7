Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF05BC76194
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 05:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9663A2080C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 05:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="RbIMxa4U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbfG0FKh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 01:10:37 -0400
Received: from ozlabs.org ([203.11.71.1]:56663 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725818AbfG0FKh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 01:10:37 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45wYtf25ZYz9s3l;
        Sat, 27 Jul 2019 15:10:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1564204234;
        bh=7sAqKIZuDSrrgjnGY2T3rvyNbaN1Ey5S0LLp3GBtKY4=;
        h=Date:From:To:Cc:Subject:From;
        b=RbIMxa4UuQNXTca4iOvN2+Pqm3E6bjL0/a7FsmS+SV9YhTShE6810dv72G778S9N9
         bVTrgtCiRuFUF3M3jwjrr00fCnYNLAnzeeKCXhdqgcBOJtZBJqMPhJ8nrHnDUrPyZ4
         b2cu+nGJA7EqgoKjZ/mOEX5PnF59dqQ2KnuO2VEQGoMqF8kwmhBUkK98BSisul94nk
         lvtsZsNHEkiAs1oS8Uiy0L2sCqb2YXGBD1UFe1TFevEHqAsUPJdzdLAk6YjXA/zscr
         anjnuKXj2nROzgbShbqD/SNRK+vwagHFHhml/4wNPJZNYyOhfRAzuD7cpSgaC0vMnZ
         tNqaEYi9KzEsQ==
Date:   Sat, 27 Jul 2019 15:10:32 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>
Subject: linux-next: Fixes tag needs some work in the usb tree
Message-ID: <20190727151032.4eaf3032@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/_Sfn20AuKRKioi7H1EK8W.C";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/_Sfn20AuKRKioi7H1EK8W.C
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  6269e4c76eac ("usb: host: xhci-hub: fix extra endianness conversion")

Fixes tag

  Fixes: 395f540 "xhci: support new USB 3.1 hub request to get extended por=
t status"

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/_Sfn20AuKRKioi7H1EK8W.C
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl073MgACgkQAVBC80lX
0GyZEgf/T+BVbseNdzp0mokl9ve96XSAQDzj1j4NKY5PC9eCYbErmlG+I12z+QX+
CssgOL39BeLPdHcZZSFpDeYfn4qoFpGE1GoNQMi4VK6n15myTjOvWTe1pWoYGkcd
K19s4sRl1hj1Z0Wke8pZfkS0H3ovkgvWi74Hruumu7zeIPjIjDt2sWY4+caiMALR
AibcFkLJ+Wla8ro9mim4lk8Gj1klLEegqmC7OpL7W53WXCqB0L0yy6MRDIp0M1F0
YC+aJ/yE/LGL0/DW4LirZnIfiVmqyBOUf4i32uGZaRPTZuSbbKdUm+pLCjwX5H7a
hLUT0GFwbhUzVyjLIrHi6e1whh/pNA==
=vBwa
-----END PGP SIGNATURE-----

--Sig_/_Sfn20AuKRKioi7H1EK8W.C--
