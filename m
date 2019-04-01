Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F2A8C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BD7D20880
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:00:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ZntR16Fy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731465AbfDASAy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 14:00:54 -0400
Received: from ozlabs.org ([203.11.71.1]:43787 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731346AbfDASAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 14:00:51 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44Y0WN3PMhz9sPn;
        Tue,  2 Apr 2019 05:00:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1554141648;
        bh=zhPP62BbpyltEcY13lsn4VmMzaxKQY0xzWQ+I+0bVO0=;
        h=Date:From:To:Cc:Subject:From;
        b=ZntR16FymnDwutMge8ZPzP9fWs54j3M0g7VSiGQQJW3CqsbYzv2vWRlF1ImY9bfvG
         y1YszBYyp+abQOp0pnbhS9fGRgkPRCeSFtVa6lXq6OOXRZ46SCGAZo5Mu394Jfvs2J
         dPpka1YEA3waEFKmmhJQ//T2XTQsQyBAReMjfuLAmVIsO1fj2bp7O/D3aC3aP2OEWv
         +yVfwEpJzZSsJdhCeqQTR1uQ6ZyBP6t5Ju5Mm4K7X0bVMFxGdvDU29NlUYYOHg593W
         uMcd80xampPsHJ2c7H+B+HMGPOm06puWUjseKaQRinHDSkLPOxhjEMIJT+y6icOiHo
         jZpV4JHh4RS7g==
Date:   Tue, 2 Apr 2019 05:00:48 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the phy tree
Message-ID: <20190402050048.0686d21b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/sElZDQsZbtFXZVahKKZwkGP"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/sElZDQsZbtFXZVahKKZwkGP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Kishon,

Commit

  b6e13b9c9482 ("phy: ti-pipe3: fix missing bit-wise or operator when assig=
ning val")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/sElZDQsZbtFXZVahKKZwkGP
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlyiUdAACgkQAVBC80lX
0GwyhQf7BNaVB10IQERl6TIvNmwyzg8i0aU8Za5nGYVIA5qzLapvG3L/qJ//TtQ9
ub+tz0qKiEufmd587vJflGyb5K3samVsJKz4wTyll8T8YSn0nLI6ybSHm9Ew0J89
R+tug6HejGmXogbfaXvYs8i4FL+9iBbpCjgIcFYiqovFtOLKSZGdWOE2Qr3SzmaA
a4x0rVse7r0B9bJjnbcwQuGLxcVen4RwKdBhNg0l8Rsqc4ZYRVklJ95FJgVdEj3h
xs44NGc6Ea0tGAdM/RLNqOVRy1U2q1hY1/XpoU4syeCAYZ+L8C6wfiLee3u5A0F8
Pckoa7li+N3+gqx5IC0B7NLLE8ooQg==
=Dzux
-----END PGP SIGNATURE-----

--Sig_/sElZDQsZbtFXZVahKKZwkGP--
