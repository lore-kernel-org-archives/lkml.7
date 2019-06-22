Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 780BDC43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 13:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CEAF20652
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 13:54:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="a3NL5t+l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbfFVNyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 09:54:13 -0400
Received: from ozlabs.org ([203.11.71.1]:39771 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726136AbfFVNyN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 09:54:13 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45WH8z39dCz9sNC;
        Sat, 22 Jun 2019 23:54:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561211651;
        bh=YWylLjrSZj42dT6vag9VF3yFuRD0Qiab2egI2PN8yxY=;
        h=Date:From:To:Cc:Subject:From;
        b=a3NL5t+lkK1sA1vSFxBZkJqkNrmqLYeEYPh1+BxKHkiNlnWjJohjlWZ0C2JfPAOHb
         o52EcMSkvzP4Smu+vDLxpykNv9cjIwbPSS7NPBKAlny5z4aRqV5C87gDwZMOBxUZ7K
         2XCNXm+KHfREL3db8uhjlBNHOtzaXtIdVSnz+wB6dFpu7g+HV/ayMSP3mWlPp/Le9g
         UFMN8E1JpP2BqciuaGy9xNfbD37ybAvErOmcjZ6x+Z+A1OMSC67QTQKVcOxSYqqmu7
         EK158eZS4PZ5Rp7Orje0n6dTtke1plBhaRES3c6bAoxbmcKdEPDPtfroqFRbS7/Ms+
         CHBkESITe7Htg==
Date:   Sat, 22 Jun 2019 23:54:09 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the amdgpu tree
Message-ID: <20190622235409.11917959@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/pjgtZt_t5I73Kk6_aOkDIKu"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/pjgtZt_t5I73Kk6_aOkDIKu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  e48c277af9db ("drm/amd/powrplay: add interface for dc to get max clock va=
lues")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/pjgtZt_t5I73Kk6_aOkDIKu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0OMwEACgkQAVBC80lX
0GyEcQf+Ljx+5OYSwEa3A2Z2us6vms4nz7vYx4iZ2YPO5BsDEeRILLvcZGepKsMA
tw5TQ8J1WJfBenCelyb12L0w63t6PLhZFiRTzfd7vCYh5qJgcYPKF/ghBRb3QZLW
fSUbWrto+ZhHOsfYm5hqg5y/Z+rhnOjNuF42+HMxVH1jbkZ75qd+CmFAtmg99Mpe
65HM20eFWm21YYO8HMaxEk+UBWCyL0z+y8Buk32tQmop9b310I8vTnTHPFwnwLWB
J3UNlcXbyQYvgZwv9GuXUJ0QWJzdEErAPiI3FakB3dAkT4aGWH/CYqtdOe7PF1hO
+FInh9b5Li4qCUmutaW2UHadeJpRqA==
=KS/7
-----END PGP SIGNATURE-----

--Sig_/pjgtZt_t5I73Kk6_aOkDIKu--
