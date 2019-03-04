Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 366DDC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 049A12082F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:10:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="SdjuXJpT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbfCDIKB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:10:01 -0500
Received: from ozlabs.org ([203.11.71.1]:41251 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725974AbfCDIKB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:10:01 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44CXkY3M3Qz9s3q;
        Mon,  4 Mar 2019 19:09:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1551686998;
        bh=gJjfm3Lo4xEMt3xb56F/oSJ9C8sfFThkhNw75RuNFjY=;
        h=Date:From:To:Cc:Subject:From;
        b=SdjuXJpTfnNuFRka1Uwj4z/RA5LMcd8T0c3MpUGYpwoK5KH7V2EnAtWnu+P5RsfMZ
         8XUdqMVdWfczOhnNuzRu6Z7woMuUFuTE2uyJQyAIueRAWQdMZKMXyX/8cdfCplwBS3
         s0dSaGhzQtBu30g2pipbJul7wSI6OlP48otoG+xQ9gl+X0a4e1uSRrL2YWI4FC1jiM
         INJC96zPF3HgBZEXKvFc2ehOsUcrnWrP9/mHBVm9YBuFYz1WIckHmlwhULminTU6HJ
         xEP9qEONPKTH9noW4Uene7gTeolLzdBDH9KrgUBPF8BFPxQcpAydYl8dg+j41MZo7N
         +XlJ7kXhWKxYQ==
Date:   Mon, 4 Mar 2019 19:09:53 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mario Kleiner <mario.kleiner.de@gmail.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: linux-next: Fixes tag needs some work in the drm tree
Message-ID: <20190304190953.342ec64e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/2G1qVqAboWVRSB1Qz.zxaT_"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/2G1qVqAboWVRSB1Qz.zxaT_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  289aabbf7bc8 ("drm/amd/display: Use vrr friendly pageflip throttling in D=
C.")

Fixes tag

  Fixes: bb47de736661 ("drm/amdgpu: Set FreeSync state using drm VRR

has these problem(s):

  - Please don't split Fixes tags over more than one line

--=20
Cheers,
Stephen Rothwell

--Sig_/2G1qVqAboWVRSB1Qz.zxaT_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlx83VIACgkQAVBC80lX
0GyaFAf9FikT8e1m5N8PZiyZp4XFCG3A7aozEiNSJLy6x/709YwBRqePFEw9t+nL
tzsBm/bXMDhkVsIIIoc9QYeAeD5SEc4Q7QJaqhWvZoWxhtVwTtLd34dkqRuN8FAT
9is+RX9jh2hcidmQEckxH4U4PgE5/7dyH0/2UhRP6xD9B6FfQDiCUyxRvb0kX1pv
Hl4ppr7N2l7akbARR84aw2WsnQ/Xbz2AWwFGslA1RgU6BNw8OlkYQtzUdk6kzc6W
jt4yBur0WjME0uPteqvbev1003tqg8scb2VvTBlwrCv+jfHB1JHLcAozKHPZJ1X1
OFZyfBfoOzP/iOPQikc9ThaN1TtdMQ==
=nhdB
-----END PGP SIGNATURE-----

--Sig_/2G1qVqAboWVRSB1Qz.zxaT_--
