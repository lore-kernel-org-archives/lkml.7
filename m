Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D1BC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 14:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29DB220838
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 14:02:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="WANPQy//"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731569AbfHAOC6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 10:02:58 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:49765 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730581AbfHAOC5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 10:02:57 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45zsSZ4zSHz9sNF;
        Fri,  2 Aug 2019 00:02:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1564668174;
        bh=KaOu0pNHY5+26M59K8KsMYTVi0e6TEXkyEzO16nGB+I=;
        h=Date:From:To:Cc:Subject:From;
        b=WANPQy//ZggJX7/2BPl1/1Cvws4saO5yatNGnbXuHwnUQ2/Q3Ut31vBBMRGN94HVv
         mWoS2GexWWfItkcU33NVuus0N1C13liv+YxCkL3GV3+la7uf+nYYZHh5jkryAqcxx0
         rpilufMcT8p2lh6ADVFrrxgz02OB+84pAdGCqPw9lm8hOJkZmPRopRZIFv80jTUpaD
         ApswPyXOQrdsi39GaD9sQ31btdCDe8F5sd9hCCjJl213Q3Q9qxfDFT6JCkWyhyW93O
         FJG3rEWc1vEQ1cXljcSIjW4gKitPS2PXPdPXyzTFqUU0Vh8hN2L/H0951uOGDM0gYr
         OJ4i/Xsyux6hw==
Date:   Fri, 2 Aug 2019 00:02:52 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJv?= =?UTF-8?B?c8WCYXc=?= 
        <mirq-linux@rere.qmqm.pl>
Subject: linux-next: Fixes tag needs some work in the i2c tree
Message-ID: <20190802000252.74ada349@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/BIDD=rbU1y6V9dnDOxyDujI";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/BIDD=rbU1y6V9dnDOxyDujI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  9c5718e14b81 ("i2c: at91: disable TXRDY interrupt after sending data")

Fixes tag

  Fixes: fac368a0404 ("i2c: at91: add new driver")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/BIDD=rbU1y6V9dnDOxyDujI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl1C8QwACgkQAVBC80lX
0GzpWwf/cQrD/DceF8UpeGm0e4O0tVNdZIyUTec+nBEv5BVy9ADA31ebuNTbl/wy
vYydkBhzHE2pZhtG5o2hdDkqjK8VLj9w8vqwE7leZd9HmDcSSwjPenLmXOX/v34I
otnVUZl4vfJrh0n0CSVfhz6ktpMI4umzjxVuHvwX1wg1P4PefXj8kMO9X1QE5Di6
StJ3DYoJ+AyVpP+nQgLM4wb6HDsDep0hRphbQeZgIiPH2jrLfP6zfQSlLDZFxNP0
KLkgbplkRphvF8pNi4Bv0moDDE1xQ/MNHsPF41fpSdS4ktbt58ACOsqNMU0IAisq
KM4na/UCW+xw+kRJK2mAhBmJy34GPA==
=rIKQ
-----END PGP SIGNATURE-----

--Sig_/BIDD=rbU1y6V9dnDOxyDujI--
