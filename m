Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB10C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 06:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD78126433
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 06:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="r3GwtRCr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbfEaGLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 02:11:07 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:45839 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726158AbfEaGLH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 02:11:07 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45FYwm0K0Vz9sBr;
        Fri, 31 May 2019 16:11:02 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1559283064;
        bh=/DGdUvmIazHQUlf9mPACspVIRRRB10dQrvQwR2BJVz4=;
        h=Date:From:To:Cc:Subject:From;
        b=r3GwtRCrb+PP1SY1KvU2xNj4uU9qxEjbZFYSQU0GnienHfUtUFjPmi6R9Lql2Yozn
         N5dGINjtS+6GzqoZ2RO1U70UmbQ/eLmzFG0L5ky3FU0slqu+iOS4etuRAQ+RCUbGTd
         I+i0Xj2Q7h/kmEVe04MOBZNUPbQqynEb7bx+zOdZwkdw2TOA5KJC1Ylo7tquHBx7LN
         jw4W6DKbhaEuPMH31F+Lv7S3+/tILVQ7CkEdlraAQA7soCFF0HnsmMCGBQ9CHAqX6R
         NdqfFDc8qCsSZ2HWiZXywRPJmhIpiMwRVB5+AVdcOR8Y+AfMrwsasZ65nrNnOlz7Zk
         tuzxv96CykbcA==
Date:   Fri, 31 May 2019 16:11:02 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: linux-next: Fixes tag needs some work in the drm-fixes tree
Message-ID: <20190531161102.4d0b2c97@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/UapcH+QXdAMGnKLiDJYuPms"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/UapcH+QXdAMGnKLiDJYuPms
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  137caa702f23 ("drm/imx: ipuv3-plane: fix atomic update status query for n=
on-plus i.MX6Q")

Fixes tag

  Fixes: 70e8a0c71e9 ("drm/imx: ipuv3-plane: add function to query atomic u=
pdate status")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/UapcH+QXdAMGnKLiDJYuPms
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzwxXYACgkQAVBC80lX
0GwAJAf9EZ4F+IIwdZgVNyjEgLVKZbCJaJCYG6klilNRKDn+LpUeAudzXvxr5BnD
OVvt/z3EGsnkEcnbLnMNxNNfl3GBDr5oLMOBWyoJcRmG2dlpYnh2A5OVBezvRLlO
G9/OnmM/b7Az6QKNvTC9GyneIviCOhyLculeOjjskqAZE1N6k8n7n+3Y3hFdxq3V
RaINsrVHP6icyLGb/VzuSqva/WZGETQwRyeizhmdJ66jWbHFi2vUtwp5ePn5X3XV
UGtIucKXbE93oksslaHh7yyPSO7drGQOKG183aJFPyqudle8l0PhT4PDe/LDrGUX
DGsqz0YLYvkpaOCL4nh4bq+r0I8e1A==
=PFWD
-----END PGP SIGNATURE-----

--Sig_/UapcH+QXdAMGnKLiDJYuPms--
