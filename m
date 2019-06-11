Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85711C31E46
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 21:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 534D62086D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 21:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="lJFKSnjU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391787AbfFKV3v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 17:29:51 -0400
Received: from ozlabs.org ([203.11.71.1]:46325 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387804AbfFKV3v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 17:29:51 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45Njnl73ddz9s6w;
        Wed, 12 Jun 2019 07:29:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1560288588;
        bh=tj1WwZ7rdEKsUT9uwOStMxcrABMexqXGFXrGRdTjnxI=;
        h=Date:From:To:Cc:Subject:From;
        b=lJFKSnjUtgoYc42G7sa5G5kdsP8yWtJFs+v3E0E4ax66x+0FIFBJfvvJ2Qb8rNU59
         mNz5GORFxVWzh7x3aSbxAQbLKSfVZoG52HMGTZcBZUNGFhJ/2rv8moGhxfWvAqJjNz
         HIU4XRebwracr/VI48m40yy4EfDFUDfVYoQ6bQoS9F5x+GlPbVguLYz+9nKOz4bsy8
         iXnawTsxqQ0GlSZvQxIpXDUmv6/YPpkLuhaNxRKeWkwvdxGnxo7/PF0KWEfc6X96uL
         D6bcb+m20fHXwx9kPI+RvyEXeC5ivWEXUXaAkrLRCOCCwE1vxnkNR8zpRGpGP0KZTc
         u/KbEB1zyKOMQ==
Date:   Wed, 12 Jun 2019 07:29:46 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Volodymyr Babchuk <volodymyr_babchuk@epam.com>
Subject: linux-next: Fixes tag needs some work in the scmi tree
Message-ID: <20190612072946.15403676@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/lhGhTEZ0nnpLPVQgCDBtZid"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/lhGhTEZ0nnpLPVQgCDBtZid
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Sudeep,

In commit

  e322dcbd75e8 ("dt-bindings: arm: fix the document ID for SCMI protocol do=
cumentation")

Fixes tag

  Fixes: fe7be8b297b2 ("dt-bindings: arm: add support for ARM System Control

has these problem(s):

  - Subject has leading but no trailing parentheses
  - Subject has leading but no trailing quotes

Please do not split Fixes tags over more than one line (it is ok for
that to be a long line).

--=20
Cheers,
Stephen Rothwell

--Sig_/lhGhTEZ0nnpLPVQgCDBtZid
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0AHUoACgkQAVBC80lX
0Gzb+Qf/SAWsIn3RJhxT2hzg5GR3bIcBGOEgprhz6TGt0vO5sSzcQ2LAI5xCjJBQ
FZKq2418HGwHW/YkKbi53hEAcaGQXpq0DapaTWZl2LdegVFLy3aZTrZo7olzET4l
MtbAHEIIAMqWAQ3oM9U648neshZytLzL04Qek6O6hYUq0zNlpbeHIkasharddsPA
JNmCvCCmQ4NFCQzMKZmLB62EIBmFChn5AV5+DF/964bA8Y08HPBe512txh1z2cUm
RwrI6Lt+5GadEAc1BkHrjxekRC0m5UlioET40t5hfVTV2qWg0+vKAOkOZDPFjA++
04K/0xtPbKiNW6dJizUsmtX2uG/Qhg==
=Wb3x
-----END PGP SIGNATURE-----

--Sig_/lhGhTEZ0nnpLPVQgCDBtZid--
