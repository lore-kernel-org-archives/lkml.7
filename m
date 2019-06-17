Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8504C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCE8320657
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="vB2lVW2W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729293AbfFQVgi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 17:36:38 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:32929 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727479AbfFQVgg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 17:36:36 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45SPfn2npyz9sSm;
        Tue, 18 Jun 2019 07:36:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1560807394;
        bh=/9DMT81agPim0zOZaguW0JTTgMiZb72yDrap4O72A/w=;
        h=Date:From:To:Cc:Subject:From;
        b=vB2lVW2WXWfjXsW4GUCMTVHZ6sH0MeZMIDLVKa64QX2ZV6hSb93O2fZwXXRikGLNV
         FXgUEjUmHuz73sr+YFVvSF9/rMtYiha7nbd3q0tqzw5D0Ip+ViO8STaP/CIiLtHfVv
         iNfy3I0GzTDr909rZCft4ku0TquTKPrtMWx1O5+1ewQLnMY1vKE2rKoUMGsgy1YurT
         kG0YNCm9371H+C58afErLkZ4KG8QOQ4dRL8UfvRpjxcrp7kE+BzUC6/SqDONfZx64d
         5y/E1on/jJsaLkEulVICGA8X43RrSTCGO9KkNLzm2vg8s18wWznQat+VE0D89Vw2WU
         rZK6TstDiHd2A==
Date:   Tue, 18 Jun 2019 07:36:18 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Patrick Havelange <patrick.havelange@essensium.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Subject: linux-next: Fixes tags need some work in the staging.current tree
Message-ID: <20190618073618.0682627e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_//cPS+k08t4+qTTCToQ6h_VK"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_//cPS+k08t4+qTTCToQ6h_VK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  0c75376fa395 ("counter/ftm-quaddec: Add missing dependencies in Kconfig")

Fixes tag

  Fixes: a3b9a99 ("counter: add FlexTimer Module Quadrature decoder counter=
 driver")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

In commit

  bce0d57db388 ("iio: imu: st_lsm6dsx: fix PM support for st_lsm6dsx i2c co=
ntroller")

Fixes tag

  Fixes: c91c1c844ebd ("imu: st_lsm6dsx: add i2c embedded controller suppor=
t")

has these problem(s):

  - Subject does not match target commit subject
    Just use
	git log -1 --format=3D'Fixes: %h ("%s")'

--=20
Cheers,
Stephen Rothwell

--Sig_//cPS+k08t4+qTTCToQ6h_VK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0IB9IACgkQAVBC80lX
0GwBbgf/ee33U6FgUUmzCxho47sKeyPkmbUmmcMTn4ELbJMQuN2B1s3sWpHiSdt3
vV8kP8Xu1+1KO3mG6Wb9nhkAYweC/cKfeC+ZtQ7BZOib3RCR3b1TPi0mJYa60wJI
KI5BtcUREbv++rKkiP/nZHW7OJFrmAs47zQm3rrrybE+bMeDkNd8GypQtNzuIwNp
63FCCUZpKPw1aHVKcvTHyxWP2JZm0zh883mc+uAHp4a4baE6r33SO8Xl5v7CgQm/
WdmElG3Ry7qnr9Sb0xlSFiG9EgPaWhNQ+6Sa2giU8NGyqUgNkfFxaFGcin58uKrd
P34MIBxVNA7YxsVUbvNb040C5x8EIg==
=2Xrn
-----END PGP SIGNATURE-----

--Sig_//cPS+k08t4+qTTCToQ6h_VK--
