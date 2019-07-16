Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C1FC76192
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 19:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C397205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 19:38:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="a5Y2ukJZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388626AbfGPTiE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 15:38:04 -0400
Received: from ozlabs.org ([203.11.71.1]:35857 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726213AbfGPTiE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 15:38:04 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45p9ff0LYbz9sBt;
        Wed, 17 Jul 2019 05:38:02 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1563305882;
        bh=2XmstIrQHROb6umNOg9uWOJl4VLaeO+HwdlYs+MRNjE=;
        h=Date:From:To:Cc:Subject:From;
        b=a5Y2ukJZYRtIHi8ESGvULW54wtj56hsEbJrpNdBCvRxiN32LFZZNXGkT21Mj//3KZ
         i1Aiu/yhHos0S5ItAXLGXnGeiEi9sbS8bNVf0lFe+9U8xQ3PhV4rhqPO6n9JyGMKxb
         T9qupnENeaD69AFg+dCLlIdvyFX/lWOFNjVMwMReXVP5grFX0npV4c7P45WDgebMtO
         cdOjxh2i10yx/fk8/OsaXydijYDbuD+g9podjL1XbYr36ZoCWjvzQklWXynchUhttN
         VdQqx7grOMNPyIvN61au1/0XxwSoc+XT6ZfbwdS9IgUdjHKbkKSBa3Du3fLrhClO69
         VPBnN1Fc/41nw==
Date:   Wed, 17 Jul 2019 05:37:53 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the amdgpu tree
Message-ID: <20190717053733.639b7f6b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/iL0F5JxeBpUEO+BrOtLF+_/"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/iL0F5JxeBpUEO+BrOtLF+_/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  50092eb42f16 ("drm/amdgpu: Fix unaligned memory copies")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/iL0F5JxeBpUEO+BrOtLF+_/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0uJ5EACgkQAVBC80lX
0Gy7FAf/d5mftaWV5a418/WaOi4gSTCDowr0sONL1ITc+G26k2CFVBKCFYCy9lCD
rcleHHhE1v8OHVEddnol3r5FexvSxvXh1/aIa59Qlm2G1ocKKUGaRelLMNmtTQh8
IlxgNlrgZtgBgVpMMUsriPbmTMSk7hJprQVJ9kUK4+/7DYgUsKid4vJfm/CqOi/b
x3x+LKfQKLQ+86o3Bh16B4QglLnQhRznrlsEdoO+u4bc83W4pzF6BTtj6okQkbqa
5EM+XBsqv0+peqv6JA094At6SBxL0NUAdVcIsCK7TO2snP8/G+UsDVqhVpo5Ft0g
HsRfQ+b8LRTITLqVNeSKPALOnGCAoQ==
=wB5i
-----END PGP SIGNATURE-----

--Sig_/iL0F5JxeBpUEO+BrOtLF+_/--
