Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD488C06511
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 21:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C8AA21882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 21:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="rDOmQVwl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbfGCVgA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 17:36:00 -0400
Received: from ozlabs.org ([203.11.71.1]:57851 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726821AbfGCVgA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 17:36:00 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45fDtj5jF5z9s4V;
        Thu,  4 Jul 2019 07:35:57 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562189757;
        bh=gaBAshq7g2CAcmEA00uzMl3h+Mf9XAVfkh9upGhr/V0=;
        h=Date:From:To:Cc:Subject:From;
        b=rDOmQVwlABF7Jqt2UjhchmUbsP8E0gefJT9DqX11pwLNuFzCagSom2uatNIf8lDR+
         OLBCxTSh+g2+w/ZQEuxo+Xhs1A8vwfOQt2SMYGF8VlafTjzXNvlvNOWx6MB4Ha4jtO
         pT5VwKWQkNeiDHPx+yWNy1kJD+n4udRqNQF+g+d+SeuaRUZ+qCtYbFXUgBbvBGaviL
         4BHYBTlizJD8RW5Mpv/JfEIOA+CmHpeFt41fHMoi8xhdWoFJHnOq2XJbga3v7S9KuD
         ynXouXukCwiLczyeINMIWM5pUSuuvMJ5qxHGGUBn1aGul4xJekycOTAVUXzRUr6kMn
         suFqytQsfvalQ==
Date:   Thu, 4 Jul 2019 07:35:56 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the dma-mapping tree
Message-ID: <20190704073556.11865317@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/9pptVeHwnWnZUOG_IkMXl4/"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/9pptVeHwnWnZUOG_IkMXl4/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  f80b90f8caba ("MIPS: only select ARCH_HAS_UNCACHED_SEGMENT for non-cohere=
nt platforms")

Fixes tag

  Fixes: 2e96e04d25 ("MIPS: use the generic uncached segment support in dma=
-direct")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/9pptVeHwnWnZUOG_IkMXl4/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0dH7wACgkQAVBC80lX
0GyvJgf+PhEttclwbWOAsdsN7P+FBifnDuZ4GO2E45M52ZDH/c6iEnUlYupl2Iak
VuKcGU3X9nil26/dRdA9RE1mWcRSO+5q9brfZps6VeOxu8XzUuT9tJSjXN3StctN
q0UAwYBogMvAGFLCh8umTTknTYYiLqNoEbZX/atUQaHE0gnRviR3fsaTjUdmZ3ht
zR1XLXibePc2fWl+9S6lL4MpWzcKCqRiG3HZUBuD0Kgm+Wls1VUWEWQr/6RZCtjL
I9lo9R3hFlVxa0NhwnSFGy/f2O5crNzWltI7qlnv+rmnCsqIrql+HDCle1VFWuzF
RlkWRTk2xWqzHyt5ktB7sZirhNgLcA==
=P5zz
-----END PGP SIGNATURE-----

--Sig_/9pptVeHwnWnZUOG_IkMXl4/--
