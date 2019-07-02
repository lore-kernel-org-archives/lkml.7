Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D60C06511
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 01:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 818602063F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 01:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ReFG2P10"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbfGCBcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 21:32:03 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:45385 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727080AbfGCBcD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 21:32:03 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45ddJ64Dbsz9s8m;
        Wed,  3 Jul 2019 07:52:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562104343;
        bh=iz+DEBqG0Ak15mqNtsewgqIEpCR+HvTunT9ODpMud1k=;
        h=Date:From:To:Cc:Subject:From;
        b=ReFG2P10ddn+fbE6jJLHbLqUausdY/1C6s/B7b9Yc/Oxvy6oW7G4ft8piAlWitOLG
         zVnTrOeT4aOYRgWsJSOlcDwMhwJdwwWyD/734+B3TkXtufQOLYsvCpB4gWlDarCRp7
         rs9pW2nYjCODZj5IyG83TGHJ7qW/KC6VdPhmpflM7oqNo9Q2bxaM7tRPo86FD+QxCg
         f4DbD0ZjsaT2ZZt6ftGPh+nJer3Dl7xqt/TawanWDO4QYbRgtc04Pu/BjTckBYkwmV
         DjeWclDlmVfKHXTKHutwWGKj1gSvn+bWxSMvBYKXUpS7Hm/s3now5rfh21xy+Dg+At
         sN3EpVkkvM6Rg==
Date:   Wed, 3 Jul 2019 07:52:21 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: linux-next: Fixes tag needs some work in the staging tree
Message-ID: <20190703075221.4ef65011@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/q+8+93=g14gcNif2rvFbo1O"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/q+8+93=g14gcNif2rvFbo1O
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  597382cbd3c1 ("dt-bindings: iio: adc: stm32: add missing vdda supply")

Fixes tag

  Fixes: 841fcea454fe ("Documentation: dt-bindings: Document STM32 ADC DT

has these problem(s):

  - Subject has leading but no trailing parentheses
  - Subject has leading but no trailing quotes

Please do not split Fixes tags over more than one line.

--=20
Cheers,
Stephen Rothwell

--Sig_/q+8+93=g14gcNif2rvFbo1O
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0b0hUACgkQAVBC80lX
0GyJcAf/d3ztOYrrlT0UJ66tYvsINtFJfc99Na8nOZ8yoO70od42asfd57GNJp+7
iaI714m2AxreySKSdvLvLo8mUjBwfNFv8G1z2AKNF9bgOaymTOUtiQ1NGwEOhsnK
hmldWrAVvjzKx0sOOc2GJYBWnfbnT3o1g6WwWfCD4ptd5jJX5HiqffGC+qQpVUyz
DYpyk1SUopret/r6zD0eB5GaAiMtsf19oC4R0pZE9PnYQGzwke12soqiZb3g06qA
pXAvV305or5Z0pjDnsDVa7TygiIisPPoRb4thyXFOdVI5xkVs0L+qT6vxuQinXgV
CQvRFipuus5dTpjirD+sGrMHMeP9Sg==
=Zpf+
-----END PGP SIGNATURE-----

--Sig_/q+8+93=g14gcNif2rvFbo1O--
