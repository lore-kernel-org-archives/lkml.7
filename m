Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E83C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 13:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F304F2085A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 13:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="YWnn41//"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727925AbfFZNuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 09:50:16 -0400
Received: from ozlabs.org ([203.11.71.1]:32887 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726628AbfFZNuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 09:50:15 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45YktX4q3Zz9s3Z;
        Wed, 26 Jun 2019 23:50:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561557012;
        bh=CgFVAxLBBoJNkTiZPu52i39tbpv4zdhD2FMfBFNNmxI=;
        h=Date:From:To:Cc:Subject:From;
        b=YWnn41//Gs/iCFZMtwMZdMM6UtI+r2DjT9cy8AAifiKOAh2GznGMvMAmFtoSs5N7j
         AXGF+BWqReftkVsEMImoLD75/ZzRMUgUFTKnInGumPc4iYE5NmhRYMtYs0en0XDM93
         KoiNVk2lSLZSFh8BU/yAK5CHDceahkgxQHi+BmBPNCg81PdFmZF7dbDO8yXwafgD+9
         l176Aq52oESwmWUwSDkMAO/RwyuPIJQJnJYgXNX3WO5AxEnYp2jM2VG8BY2U5beX+p
         Q0kli/lVcBPtBVDYcJ0q0ZxAX+p+TOIt3TWOnGBFd6P/kUCfCvPbYEfmSTm7dqU09m
         lgwOuCWy6haLw==
Date:   Wed, 26 Jun 2019 23:50:11 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>
Subject: linux-next: Fixes tag needs some work in the pinctrl tree
Message-ID: <20190626235011.7b449eb0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/guC+oxRqAXQQC6UWwHorbL3"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/guC+oxRqAXQQC6UWwHorbL3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Linus,

In commit

  99fd24aa4a45 ("pinctrl: mediatek: Ignore interrupts that are wake only du=
ring resume")

Fixes tag

  Fixes: bf22ff45bed ("genirq: Avoid unnecessary low level irq function cal=
ls")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/guC+oxRqAXQQC6UWwHorbL3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0TeBMACgkQAVBC80lX
0GxSQwgApiDxRMm6wi3XwcKZMTfIGRWkrSxyH6mqr4A5Nzl6jSx9NX9xu9qJM5Wa
w+lD29RU6MTUsGwJGkbu6gvG65mcnrYCP0ZUr7vyOqc54PqDrGk2wGhAVDmVWagg
73bOfNCS0VJnHNDnBilyat4UjA+2GojVg1pzMYqPbx93nRjF+cxGm77Qkl7o0DOm
nacwcIH74qUOCmEzH93wI2bcRbCQEZsMgIrEh7mCVrR4LDsyLrcp/29TrEMacl37
P4JK3dur3xMqn9rmoz2AMHErbIaR9jBOMgViykPn4YKUgmxkWg2xqX6Mn84/1Rh9
IDR8W+DNLEp3B7cxxodUowHZygq4uQ==
=5JVO
-----END PGP SIGNATURE-----

--Sig_/guC+oxRqAXQQC6UWwHorbL3--
