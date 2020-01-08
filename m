Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC3AC00523
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 10:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D5252073A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 10:10:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="BDi5gRFk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbgAHKKg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 05:10:36 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:44511 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbgAHKKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 05:10:36 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 47t4kd1JBdz9sRh;
        Wed,  8 Jan 2020 21:10:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1578478233;
        bh=GoeUl6jdFt0zbRK3QhJAcx6XrW9/e/Rs6BFNwoM1vD4=;
        h=Date:From:To:Cc:Subject:From;
        b=BDi5gRFk71OW72kGHtdac/YUpr5iqWXf6OaYt2id8LRlOu84Xyz9rnBmiL95g+hr6
         WCwv7SNWpxrxNlzKtDNorKkCOUz9ua/bgCwvBf34z2K5SPV2EExWCYwibL83uyWwSB
         vwc0Ld2u+GYP2S//MRKsOg/9XUtoJTLVg5vO3Cj3C9AHOo5uYK4AhksQUFAdt8Wjva
         ED4QH+B0/V6lswT3S8YnFjO5OC2bDLLM6oV7yf9cBf7nuKb3xRpN8s/dq9pD4WBqIU
         AV6rwh7FoFCqcroD9+hmtP5LY0cpF491UYVfYcvAk8sy5zTLZfmPW1lN/Ir6IfzJc0
         a2uNiWQTmspKA==
Date:   Wed, 8 Jan 2020 21:10:30 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jiping Ma <jiping.ma2@windriver.com>
Subject: linux-next: Fixes tag needs some work in the net tree
Message-ID: <20200108211030.7a888ca7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/0Ck8cTm=3oTzyxStfTnUbSb";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/0Ck8cTm=3oTzyxStfTnUbSb
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  481a7d154cbb ("stmmac: debugfs entry name is not be changed when udev ren=
ame device name.")

Fixes tag

  Fixes: b6601323ef9e ("net: stmmac: debugfs entry name is not be changed w=
hen udev rename")

has these problem(s):

  - Target SHA1 does not exist

Also, please keep all the commit message tags together at the end of
the commit message.

--=20
Cheers,
Stephen Rothwell

--Sig_/0Ck8cTm=3oTzyxStfTnUbSb
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl4VqpYACgkQAVBC80lX
0GxMvQgAhPOYt2i9gXKK2PB2UZxf5sFrNXQIpAGrHl6R8OhLUdTaDtbpp8dpgSk9
9KO/ktPPg+q4Air5x6DpZnDUtnWs6Iy34zErE45oXPUeqqheRX0pOLdw1FWTqULR
ABwJdX16yZgYJl9fV0kwCsSD1iT+75iSaT4BNmHdROxZ87P6E/BfteDsORIOInx1
E4Pn/c+H+T368uLlyj7654OQXgmHGgIuYXk4dO6Q6H9L1nCLdLWfm883mdNeNDPH
DoAMaXUdecSaYJE9b+a9uzViFhPvDfjvT3kADZGxhPbgtKGXGvKNr2M6HS6CLeot
UcnEzOinmFj5RbFo7txGRMS3gCSSxQ==
=aMmy
-----END PGP SIGNATURE-----

--Sig_/0Ck8cTm=3oTzyxStfTnUbSb--
