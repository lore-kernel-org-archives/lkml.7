Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD6CC43218
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 07:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0BAF20881
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 07:17:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="XmDpMKFO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfD1HRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 03:17:06 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:57065 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbfD1HRG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 03:17:06 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44sJy7308Mz9s7T;
        Sun, 28 Apr 2019 17:17:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1556435823;
        bh=p/Uodc284icVMm2TjQerSrrMjv6ERffnZ16Fd8aefTM=;
        h=Date:From:To:Cc:Subject:From;
        b=XmDpMKFOzl+KTKBtIyqVYLZ0buTRt2N9FfjDQS+NWWLW5jgmDMBOqYH8f9D8/UGb3
         XBnHI++cZa16h55BeznKtoHY44tPqmK63yUCrpcXzSgThvfuDEFgEcDB8catl2WQTA
         1UNozPV5GHg66jUFM2VjezS3KPnKVGOVHVIWcVufpvsslOs3hjqO5wRivaVLmBUZoC
         Brgg05d/R/Pw9WlV+AwIh80cLC7W4FmkG1wvP4TpS19MXKNN1ladQmdD4kUeROXnex
         sZnU+jtappcjOeY8DNurAc3Ljuo6zJ2Zf9dqH1PEGVBrfKq3sk4N1LSeWGzS5QYbQL
         F3PvlZeoij6TA==
Date:   Sun, 28 Apr 2019 17:17:01 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the slave-dma tree
Message-ID: <20190428171701.2a96cd3c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/gIT.vGV=8Z1cQK+Zum/=jgy"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/gIT.vGV=8Z1cQK+Zum/=jgy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  9bd1be60f55b ("dmaengine: stm32-dma: Fix unsigned variable compared with =
zero")

Fixes tag

  Fixes: f4fd2ec08f17: ("dmaengine: stm32-dma: use platform_get_irq()")

has these problem(s):

  - The colon following the SHA1 is unexpected
    Just use
	git log -1 --format=3D'Fixes: %h ("%s")'

--=20
Cheers,
Stephen Rothwell

--Sig_/gIT.vGV=8Z1cQK+Zum/=jgy
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzFU20ACgkQAVBC80lX
0GyKlwf/bnf3VUpSUMuG3FQDj9yJjjOusJkAUFg4tXVu5DCN0enIwHfHpT/xE4Sn
x82OviM/UzfVriPYRkOVcpOCYMFzUVFLWuLYmHBo0IE6QkWmImn8qzGZ6tvFpf5Z
FGLmPTacZQIl9ffcLkGq+w1UhFK9SVjpQlgGKjUm2fgLAjpy+8QFXo6pFRtXva7s
m5F/X5TTqHCuPFX2P+bxs/kAytSn9UlUsI+3jBznODJIsAaRbP79FqMJYddnk+7x
mVNgQOeSL/0Ts8+/ppwH6gf5wOTTy5OqMg0UwdsBc4llxJCeOzyuvdWmqIZ9+pA+
R8FoPCT7NFX3OQbaQ5pCNoHX8Pcz+Q==
=uhnc
-----END PGP SIGNATURE-----

--Sig_/gIT.vGV=8Z1cQK+Zum/=jgy--
