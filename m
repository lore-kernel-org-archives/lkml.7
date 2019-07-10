Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B51C004EF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 11:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD597208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 11:26:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="TbgGZCXc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbfGJL0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 07:26:31 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:53679 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbfGJL0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 07:26:30 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45kH2C2Wrtz9s8m;
        Wed, 10 Jul 2019 21:26:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562757988;
        bh=7INYaCUq7snUi6RkopB4JyzdlcPRBZlesJ1RAJFGDEY=;
        h=Date:From:To:Cc:Subject:From;
        b=TbgGZCXc1R7vtjCSbfa4VNNA4ATyauAz4BizlBAc43Lw5MStEh0OfzLb4z+3WVs/L
         lH2CG2MjSaArSNsxLMGh4+2lU9v7do8EGM6hs27KsSBIOzQ2CIpKLEwagMEDvhYb8K
         rYq6TYJ6RqcRr0rgD2WEHKjOxqQ3hRmT5sinlfDYT6LEbXase2ezHvODP0FlT8R5QQ
         xObq9donYU5I3Q4i1sA98iDiVG+Nu0S9WEdaIrqeB6m2RAnkYYBip0hAsnDmFIS9/E
         u1xAiH1PdL/9+p3tAQ8mgf01gWy5nIMXG3m+ZgfmLJCoXr/xqez5XiLfJyjZPEbutM
         0fI8x9gGLnoZQ==
Date:   Wed, 10 Jul 2019 21:26:25 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wen Yang <wen.yang99@zte.com.cn>
Subject: linux-next: Fixes tag needs some work in the pm tree
Message-ID: <20190710212625.718c5327@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/6_E_+M7MasBoQ1_151EJMSW"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/6_E_+M7MasBoQ1_151EJMSW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  f43e075f7252 ("cpufreq/pasemi: fix an use-after-free in pas_cpufreq_cpu_i=
nit()")

Fixes tag

  Fixes: a9acc26b75f ("cpufreq/pasemi: fix possible object reference leak")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/6_E_+M7MasBoQ1_151EJMSW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0ly2EACgkQAVBC80lX
0GzpwAf/az9TRF+927S9E9lLZdvty4YjLHj1DHOglysX17MyUCLr8ZhUUDqD+LEG
5j9H3p8r7Yd9Op/PPM2l4Jbxw5OkDobqbGimXyaBuU6p9SyjJqnd0V2TOad06o+w
oRetixC2HTqZFlP1j2HNhobmbpZuX6/Yl3DY7QL3olMV78aQPFYgJ92xGCS2FIJe
ItMUuECeBOdi/JFHfn1dqmWxsc8GWehVjYpkVyE+BB7Q7uvLGZ+CwF+cZThmEC1E
7nM2Zb6tY+ifuQ2zL/73zZyUzYlnpflJzxmjMP41qE5xg9lLePq7eNfUxaHJ+e1C
SctiPj/kb6vSVJky8TfukBAGonpJcQ==
=vFWS
-----END PGP SIGNATURE-----

--Sig_/6_E_+M7MasBoQ1_151EJMSW--
