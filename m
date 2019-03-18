Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2391DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 23:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEBEA2173C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 23:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="FhPoauzL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbfCRXzd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 19:55:33 -0400
Received: from ozlabs.org ([203.11.71.1]:38287 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726487AbfCRXzd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 19:55:33 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44NY370dNBz9s4Y;
        Tue, 19 Mar 2019 10:55:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1552953331;
        bh=lCiYfhgZvO0KW8BvRZAcMxtRIZkTjyYfzmt5c3b6vgk=;
        h=Date:From:To:Cc:Subject:From;
        b=FhPoauzLOA1aeuo+A7rUZY0cH3/Vdae6f/CBWYPtm43t/L87z8NHB2qHrkbu5dP1R
         GFnggDAGOilPDAARn7znIXPceV6XBv87gnBbfL7XlPfo8P3dCucwoGR67AEGhzl/O9
         RdM0AxVR6P5rCHQkX6skt8P6b3GoC0WRpc6CNdTN+l4w15pxOxDlxICsVpxuU809hQ
         N3CIV0/eDI+Vnp0aqfuZxac0Ngra8Uh/r52BbxsUD2kpCsBb5a5ym4Gaxew/Nake2a
         Clj8kOlXZN10BZsdp4vi/yd4xOYFbR/5/jL5BszmKWL/QkS7ZwY4OP6tKl9CPfbjzg
         D6ycQRjiq7tKQ==
Date:   Tue, 19 Mar 2019 10:55:28 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Dave Airlie <airlied@redhat.com>,
        Mario Kleiner <mario.kleiner.de@gmail.com>,
        David Francis <David.Francis@amd.com>
Subject: linux-next: manual merge of the amdgpu tree with Linus' tree
Message-ID: <20190319105528.115f0a88@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Z_JOi7uQlBwHhx=TkNMJKXv"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Z_JOi7uQlBwHhx=TkNMJKXv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the amdgpu tree got a conflict in:

  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c

between commits:

  d63716658ac1 ("drm/amd/display: Use vrr friendly pageflip throttling in D=
C.")
  634092b1b9f6 ("drm/amd/display: Use vrr friendly pageflip throttling in D=
C.")

from Linus' tree and commit:

  7b19bba58f77 ("drm/amd/display: Use vrr friendly pageflip throttling in D=
C.")

and following commits from the amdgpu tree.

I fixed it up (I used the version from the amdgpu tree) and can carry the
fix as necessary. This is now fixed as far as linux-next is concerned,
but any non trivial conflicts should be mentioned to your upstream
maintainer when your tree is submitted for merging.  You may also want
to consider cooperating with the maintainer of the conflicting tree to
minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/Z_JOi7uQlBwHhx=TkNMJKXv
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlyQL/AACgkQAVBC80lX
0GzcxAgAmKauUZUsKk0MC6nhciAMHKjHyRAmh1wq3xRwLeI66GMUf5dvNqI5q9mv
x8KKkqCuDrUWy+MiGSMICX/m3JrGKifwAZltxSSTEjcVav3N0+DGHrsyNMT+7V1a
PDb43IO5MtW+6OERkEVXXVEEbZb2Ku+bljLabDqth5vPehs1PKJBDfgWgBmlOfNu
thIcciCIr84dXuJsQvSMsAKES+wkazNkZ8xxxMl4gEC/vFkCcOUJrJb0+fjXCIfc
+V89nCGWAZ4UL2TCJFWwHyjqlpPp0xeD04M6mzovX2ilmDT9UYvxJXzvV9mzGqlL
s5BKXleCzNYc13XdXRzo7uuwh6OW9A==
=Nooh
-----END PGP SIGNATURE-----

--Sig_/Z_JOi7uQlBwHhx=TkNMJKXv--
