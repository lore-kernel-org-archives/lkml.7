Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A94A8C5B576
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 22:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7845D2075E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 22:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="dtEmFVpw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbfF0WBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 18:01:23 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:50337 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbfF0WBX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 18:01:23 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45ZYkk0m0Wz9s3Z;
        Fri, 28 Jun 2019 08:01:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561672879;
        bh=dru1e2WNl8XF+SRhnWn/YLNCM+xz01H+grIeFoUNSRg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dtEmFVpwlTJLMg5QNDLHy0ZQz30II4VVg7tEHgbhXlDVd5HqcOeQkyLLPuSARqwQG
         dm2SaLr3mdRWEhVtyZpXHDcfvrd7MAHkGLUu454k7i6HqmokIwYW2KwKE26qDdCuAa
         U+KFA4PQcMU+8QfI63aVzQCJ/hthkP0fna48T/4pQvVSOtcG1/2paW3ysgnMmwfGMa
         SaORiqNdzjelspGocWuWckMEUhEQ9ita3lCBlpN6rCvk7wEi3GPCp4dg6HMIaSgWyH
         L0ACaFj6/M0erYAvPLCgRstFXiTVEKvc//Gi391+y4lYyRl9vANEW5nwt5BKb1kVYd
         wzA1csyfGw5Lg==
Date:   Fri, 28 Jun 2019 08:01:05 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Dave Airlie <airlied@linux.ie>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        DRI <dri-devel@lists.freedesktop.org>
Subject: Re: linux-next: build failure after merge of the amdgpu tree
Message-ID: <20190628080105.4f88eba6@canb.auug.org.au>
In-Reply-To: <CADnq5_MOb2Fg+S4igqUrtFrmd3xVHtaLZGc02nu-m=Jn-TVtBw@mail.gmail.com>
References: <20190626212212.25b41df4@canb.auug.org.au>
        <20190627133527.391ed0a1@canb.auug.org.au>
        <CADnq5_MOb2Fg+S4igqUrtFrmd3xVHtaLZGc02nu-m=Jn-TVtBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/KADskRshsDlBe.K2D80XJg1"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/KADskRshsDlBe.K2D80XJg1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Alex,

On Thu, 27 Jun 2019 10:18:38 -0400 Alex Deucher <alexdeucher@gmail.com> wro=
te:
>
> Fixed in this patch:
> https://patchwork.freedesktop.org/patch/314527/?series=3D62866&rev=3D1

Thanks.  I will manually apply that to the drm tree merge until it is
no longer necessary there.

--=20
Cheers,
Stephen Rothwell

--Sig_/KADskRshsDlBe.K2D80XJg1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0VPKEACgkQAVBC80lX
0GwhfAf+NYOwaxJSl8pDn5625adqSdc80VI+FLOMPG8qHbaGpze4tjIR1RtP7d1h
XC7VwRmRy4Dswzvhdt4HYQB4p6W+BdqBU9P6lDKBd6K+I8v+4SB7XeEachavz4Vi
pAgHWjIbyYU11C9k4kYP0x561mZ6tLW4PTIhVDb2PThpEE+trEH1PD70jKqARzm6
161SCk6UIC/+SwFJRKRTudJld3SjwuvH4SfajwA7kEOIWI6NVeHb4OK5q7p1rVGe
wHKvLHVLvBF/1M/NFyXnlCUFqJdhQ8JBGNsFQCtEHCYQ6x1FRDn4nlwKCxoQuAv3
Q5SPhqCv8dUQ1Ii4zCg6vM3a6bE/8Q==
=ZnRx
-----END PGP SIGNATURE-----

--Sig_/KADskRshsDlBe.K2D80XJg1--
