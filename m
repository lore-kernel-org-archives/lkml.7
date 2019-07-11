Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63DF1C742A4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 21:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30810208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 21:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="jbkXSzSR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbfGKVhI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 17:37:08 -0400
Received: from ozlabs.org ([203.11.71.1]:50315 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726199AbfGKVhH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 17:37:07 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45l8XK0yt8z9sMQ;
        Fri, 12 Jul 2019 07:37:05 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562881025;
        bh=lfLTT/KATA/r3uNfpQEyJnuc1pEDrlNuUNIolu/dtzQ=;
        h=Date:From:To:Cc:Subject:From;
        b=jbkXSzSRpAPCj+d0kXPtV4inMWnB0YWEEHRmIkVNIccF6VkSo7iGOVvZgyFS4gPJR
         sm4+6XzPuBDRq/VLrTnuTliWPgA9H0K/5r3PoxnpKkDYSiFNUU+K1iB9hvKfkqsxPH
         ijEtglFn3E8c15aAWV4JKcgJyC1zGBkOZB/WTJyRhlqSJyP0WmkO/qs+ZOxNqSWufM
         /wCwS/lGVmoH/cH+qrq/llCuqPrT0Pm80kvuu6uwB4597eiNL7+LukcY4PRg6Kd6mS
         +bIHGVR8bJtBJMqRJfl4+hzeIJ5U5lc+SOQfSYftx2ucKQ+NvwhetKVYYaKViM5pVP
         2Z90bV7s0JYxg==
Date:   Fri, 12 Jul 2019 07:37:03 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nayna Jain <nayna@linux.ibm.com>
Subject: linux-next: Fixes tag needs some work in the tpmdd tree
Message-ID: <20190712073703.6b6f7667@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/CUNmiBZjkePE7iQi0W5w8.r"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/CUNmiBZjkePE7iQi0W5w8.r
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  0ce9bf1a55c9 ("tpm: tpm_ibm_vtpm: Fix unallocated banks")

Fixes tag

  Fixes: 879b589210a9 ("tpm: retrieve digest size of unknown algorithms with

has these problem(s):

  - Subject has leading but no trailing parentheses
  - Subject has leading but no trailing quotes

Please do not split Fixes tags over more than one line.

--=20
Cheers,
Stephen Rothwell

--Sig_/CUNmiBZjkePE7iQi0W5w8.r
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0nq/8ACgkQAVBC80lX
0GxyUwgAjYSy9qM6m4ZxVvPOdDbNqvYSkv+oRUteCMvn4boobeBu1wj96xDmu/bE
XLNAxeZfDKOgKBHOX+EmltW55P1QS9gDTkv0ruUlQnfXJwZbGT4k131s58usCXVB
Kuv6yNAHC0Cd9CFegi8cZ2e6TVYK0nGAPx71YfiMpPsMJxUxwFhblVfj+9K/ALFX
OL4TweQReYe8z6rKT/F1dPkW7J8ODkL6tf6gZ+8cGmhgO0n+XxvKew6xn0aufB1r
V2jmtnAOW+Y4cIl4C8psD9G7BBo0p+z+kUru8U2Fx6gEAA7KuLwOq/a6YajPSHUx
yU1tE+ppRLOG0TVWElR9RbELVD0nLA==
=zbKg
-----END PGP SIGNATURE-----

--Sig_/CUNmiBZjkePE7iQi0W5w8.r--
