Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B55C072B5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 21:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFAE42183F
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 21:31:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="HY513BJb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbfEUVbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 17:31:52 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:41477 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727174AbfEUVbv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 17:31:51 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 457pqm5gdkz9s3Z;
        Wed, 22 May 2019 07:31:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1558474309;
        bh=PmVMcoemgl+1IdY4Kvo5d2IphPdqSI/6Q44w1Y8yLY4=;
        h=Date:From:To:Cc:Subject:From;
        b=HY513BJbAjDRCOSqeJW2K2FirEvtezNBBiqkbOjujXt+HYcRSmITT18YDL0FVk4cm
         aUwitsWTMzJBXlxSa7s8kF/2L/SDUaULoKscnpp4IqR4lPiusRIYi+IdqDusoyVIHo
         9ROQhme0Y4kM9mJXq/jMjrKGdiuTjUufprLZ4oTuriK4eIzZJk2iW/a6yH80Kd1Qfn
         fpO4PCFl2I3vzFgUWJsWyvjpneosfVOgMQzk/zZnIfBKEVsJAuQjR2xK3z4cfvbXRN
         cUmnHYfKbD6K33USMXHkSIwJJYrAnpdl5LKt3fUjsoLu1b1OrSPpXwR2swynjX3kpe
         NdD3ybtyzv7mg==
Date:   Wed, 22 May 2019 07:31:41 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>
Subject: linux-next: Fixes tag needs some work in the sound-asoc tree
Message-ID: <20190522073141.1cd226e6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ilG6zk7VSWYdOFLvo=3vW__"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ilG6zk7VSWYdOFLvo=3vW__
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  e355d3de196f ("ASoC: Mediatek: MT8183: fix compile error")

Fixes tag

  Fixes: 1628fc3f4771 ("ASoC: Mediatek: MT8183: add memory interface data a=
lign")

has these problem(s):

  - Subject does not match target commit subject
    Just use
	git log -1 --format=3D'Fixes: %h ("%s")'

--=20
Cheers,
Stephen Rothwell

--Sig_/ilG6zk7VSWYdOFLvo=3vW__
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzkbj0ACgkQAVBC80lX
0GxFbwgAi6217xPl21htkDiW2HAY4ypDvx1bt9MmaEjK43JOx9n4iWfWNrX266jF
wboK/DJpHbYORoE0pU4GkIpMI4a8m9H3U0KM9bxxgbjmz3U6pvHvuM8+AvFQaUsc
edYj+h8+sz5Lf01u/F7NEtQt7vJePgaQnxmT6Z4lG83fQjwh3tJVRpO7mVL77H4/
xq2CC5J8rf6KwExQoZy4b0u/F6ETnrp6kjAMXLiyJ+Zaq4cjDhf6yJMqER6DcD7L
EjeFjhRcgYBJVTOBT4KR6DaWLdlj8pmsetcL+fnxxG0K+go8tSYtgBvpm5xqPds5
fUHj+LdHA6KPwcg/4IhWKlPWVh+aZg==
=GDsa
-----END PGP SIGNATURE-----

--Sig_/ilG6zk7VSWYdOFLvo=3vW__--
