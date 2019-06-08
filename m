Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE8CBC468BD
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 06:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2ECB214AF
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 06:13:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="DSklJHkf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730636AbfFHGNn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 02:13:43 -0400
Received: from ozlabs.org ([203.11.71.1]:37041 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbfFHGNm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 02:13:42 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45LTc35rDPz9s9y;
        Sat,  8 Jun 2019 16:13:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1559974419;
        bh=RIRADFEVOTd4e9VdslippAwgRDCTA3k+iVngq2+jJlM=;
        h=Date:From:To:Cc:Subject:From;
        b=DSklJHkfixXf+PCNc22dyimrQ1UCVCkrmZmE72jghvSEaWJkfjzwQs+bav2FVRHlt
         kW3g8CJb/WnFIf3ahVmChZbIgVugWOefSdB1cNpd1WAY/8P6AKxQz50qB7fibpwcG8
         TEldCKzrTs4u8exCf8NsA1WhmBkKyjuq3+NvN+YyhIFtZC4/s9h/QNBR67XOYfXCHQ
         wwuZb3U1Mg2vBJTcA+msToHtwaVHcPzeKfcSVVv7N8Ss4j+B1HovXdp3/w6nPeE4pt
         KvvksuNkSEefDPTlaMTnHy1GR0sCE2PzBsaA5kXGvfw/20V6aHncKDdJ1Di8wrJoof
         /f+FnvgL4mevg==
Date:   Sat, 8 Jun 2019 16:13:35 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Liviu Dudau <Liviu.Dudau@arm.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the mali-dp tree
Message-ID: <20190608161335.444f3d27@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/5d_WXFYOFq+j5p6Of2GVeNt"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/5d_WXFYOFq+j5p6Of2GVeNt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Liviu,

Commits

  74332e53e41d ("drm/komeda: Add image enhancement support")
  108ddcf9238f ("drm/komeda: Add engine clock requirement check for the dow=
nscaling")
  e980ebbe5cee ("drm/komeda: Add writeback scaling support")
  37bd61525f3a ("drm/komeda: Implement D71 scaler support")
  50be77015da8 ("drm/komeda: Add the initial scaler support for CORE")
  5bbab26c6a4a ("drm/komeda: Attach scaler to drm as private object")
  0bb0d408280e ("drm/komeda: Potential error pointer dereference")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/5d_WXFYOFq+j5p6Of2GVeNt
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlz7Ug8ACgkQAVBC80lX
0Gy78QgAjTWOlAlUFccVT/23n78X10QuyV7PgZKIVtcYbAToTk0tgc1wxZ9n8IlF
gQj0vLfS9jqZSZIcBnoZuPC6Pwfz+erXK4IS56ClWxcfd1ZTsc3w0CjRlbsrm1Qw
Yt+N83PnpcQQgdRY/U63U5ai+QOl8ebah++fLrJp70AWmcRHBNcCSh0vuYGUx2Wh
8ltim2blrjsXGQ29aTDH8Kzvwv5VpBG1jh+SoTHM2uJyBnYTX0yfxQw6GaEMbZ7u
5A8aMUr/0QjadTNiCQrc99u7tqt9yTkjgQjB7HNtRF/xiYBmm9KEW3gQSXRZpuOH
D4PTPWuE3LFDpz3vQDBMLuHRN2jIGg==
=kbLK
-----END PGP SIGNATURE-----

--Sig_/5d_WXFYOFq+j5p6Of2GVeNt--
