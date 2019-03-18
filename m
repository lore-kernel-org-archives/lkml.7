Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C9DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 21:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE5AE2064C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 21:31:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="dYZ1KO82"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbfCRVbL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 17:31:11 -0400
Received: from ozlabs.org ([203.11.71.1]:41853 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726926AbfCRVbL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 17:31:11 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44NTrW6xR7z9s3q;
        Tue, 19 Mar 2019 08:31:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1552944668;
        bh=Tv0NFBKe8iAnhVMY875Qx4THlP3I+/IbOsNTlS0b3rQ=;
        h=Date:From:To:Cc:Subject:From;
        b=dYZ1KO82BSeKkabgSk0d+wwKRgUdjOjSsILVVGZ/mMCmbFWBCnORtB2yEWg1U8u66
         1mB/Mw0kNnuGpEBT6OEsv1gTylVYlcTIb3kV3QmMaalyzD+AaJlXwiAdkppS8hUVyh
         tFEFifDsYoEwfczpnFAbSWtk0L+ai/q9o3OGK0X2713vwoHXQu6WMcW1clYYB00vdQ
         BjC8hYhz4rpSS7EoyVc4AxRymaJEMnFs1AEVr2DrCM8E+LO3gkgShx9vyVl7Yc7Asy
         j1ewIe4EHTFH5D7IK9GW6sP/E4hArqtyCWBHVRnUPGtFX+Q5qFzXCyr3L/+ZEWQMJS
         gUCtXFRHrIG8Q==
Date:   Tue, 19 Mar 2019 08:31:04 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Axel Lin <axel.lin@ingics.com>
Subject: linux-next: Fixes tag needs some work in the regulator tree
Message-ID: <20190319083104.1503e2ae@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/yeuk0cepF09Ag_WRB8Q0BYS"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/yeuk0cepF09Ag_WRB8Q0BYS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  d1a6cbdf1e59 ("regulator: lp87565: Fix missing register for LP87565_BUCK_=
0")

Fixes tag

  Fixes: f0168a9bf ("regulator: lp87565: Add support for lp87565 PMIC regul=
ators")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/yeuk0cepF09Ag_WRB8Q0BYS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlyQDhgACgkQAVBC80lX
0GySHggAjYdT2ySHL8s+1o4QM4JG2ZE71slYIMRiYEkkCG6TNOjXF0pbbk+px2SH
0cXOBwb0uAH6wQokLpCiRIA4v2gA6l/t4JmPY8QP//F7StGkUc3wnZDTKEZCT1vB
/8Ohil2WB0ffJJbk6B3PePVj2Alhy4SwQkj6cNDw6WJIGlcypzmwBwBgAVWWiwzB
I6cJe7M0TP2eNpQgnPcDB1/B3EA4EtJN2j+EN4vCZMl0XF+Eg8tkiqT1zIHVzGTX
Jvo2z6gh3O1VDALRMPv+qRRltGmYSCnGslOli8m4zJ3Fro903+EoNJKbAa3KvHOh
DfQEWM9sGu9cSfnQ8vj00ViczDBJHQ==
=XELr
-----END PGP SIGNATURE-----

--Sig_/yeuk0cepF09Ag_WRB8Q0BYS--
