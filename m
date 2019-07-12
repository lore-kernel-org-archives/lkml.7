Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOCALPART_IN_SUBJECT,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90BBDC742A2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 00:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69411208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 00:32:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="bLD4vkk+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730594AbfGLAcA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 20:32:00 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:36413 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728582AbfGLAcA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 20:32:00 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45lDP34S5Kz9sBt;
        Fri, 12 Jul 2019 10:31:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562891512;
        bh=tAyTsSMqJI7TR8669ycCC1PyQtmKW7Zr5Lc2ObC0jcw=;
        h=Date:From:To:Subject:From;
        b=bLD4vkk+FX278l4wZ1lznOZI6U1hLeJIrNmylr8wRsCrZxwcrS6e8FwiwJSZ410Zn
         RBcWX/Q2ltEng8UVRTXNCfL5nnOFSYFueUDchnPC8VE04lgSE/kbQEVXYdZuO1QtyE
         6TSIC9yxH31sTseaBwSh19p+u8c6f+6m79J58BdZYqHXX6eZgJC84f65HlA1PbTUH7
         jYwkBU9csiBUM0C29PVLyxezNVfP5XKpNGdkFw40Am0M1v4DcS7uTVUfNFcF9JHp98
         C+Ir9Nyu2cylnaHjwUpwlnb1d6JK00gXVwNm4zHeJT/jGJNN4mmw6PtYmGFMDJVQn8
         o2fikL2thDGVg==
Date:   Fri, 12 Jul 2019 10:30:45 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux-kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: we are in the merge window
Message-ID: <20190712102601.6d23c330@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/J=0z2gxGWvbPHCe95IAmoOA"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/J=0z2gxGWvbPHCe95IAmoOA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

[This has been Bcc'd to all the contacts I have for tree in linux-next]

Please do not add v5.4 material to your linux-next included branches
until after v5.3-rc1 has been released.

--=20
Cheers,
Stephen Rothwell

--Sig_/J=0z2gxGWvbPHCe95IAmoOA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0n1LUACgkQAVBC80lX
0GyLiggAhMqBKs8tiEWFZ3gkpZcCYh/SFFNWL6TZ9Q8Q8dk9It4OjdZqLendVOqI
niObkrawbEmuAi7ST5HmPyl3Apt3MxILNzqe9UrpV+aO0byOz25ase5n9Zehf3Dd
I/D5HSo5tkpjmMc/EgX0N9kzZr8hN5stv8MDj/iYBaUYeNI0gbZ9vBqEjIj5nv06
Xkdcj+EfTGi+uVnFf6LO0hXH5JOgwImNqcqAzRzmkSGwli3xvk7eVbodkyWsCX/T
8wwBm1VQ4b2to3QerJ+COKOBMO0rhKybKkji1m4hAR5VlaIzcwL8+BvmmzrZvLta
/mO4Os/KoXRP+gPIm/cCLxILFw/kiA==
=tjPW
-----END PGP SIGNATURE-----

--Sig_/J=0z2gxGWvbPHCe95IAmoOA--
