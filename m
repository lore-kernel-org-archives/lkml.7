Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 376C4C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 23:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04E3420815
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 23:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="iMfhsWXy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfFZXz0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 19:55:26 -0400
Received: from ozlabs.org ([203.11.71.1]:57105 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726410AbfFZXzZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 19:55:25 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45Z0Jq2Tk4z9s3Z;
        Thu, 27 Jun 2019 09:55:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561593323;
        bh=SYlgLJfuAa7iCBO1w4Ah7GvEiBB0bTAAJV5lwV4dbv4=;
        h=Date:From:To:Cc:Subject:From;
        b=iMfhsWXysePT6XoI2D922UTPbWSH+1GSOnpk4kv920g/lWzI9uOK+C8g9cuZapyfH
         U9jGFeaBJdSodyFqRZuP7VqttjzoKaixgXO9DyLdue6CWHjHi2FivEAE/1Hc5jZ/YV
         gyHQEhFmjqZIm5HoraZWDmPcNgQiCytNuAUD1Olmud2nrUGKNTSFli1M6Cb8Aa2krc
         RpV8DpZlHVu8NTirYtj8iyjZ3XSNIfFwzYbw6ggzNxLHneYVt+sv/acGyC8Ho1sE20
         ANE33BxEPLZPZxu6FIPeWJIpiY2QW7gWusvzTrzHPi7O/ikNXrrAw+wVBSUx9ukJMb
         AlBU00M13VGpQ==
Date:   Thu, 27 Jun 2019 09:55:22 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the f2fs tree
Message-ID: <20190627095522.457b7511@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ESojSdprCuyKUx=dFCIuK+U"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ESojSdprCuyKUx=dFCIuK+U
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jaegeuk,

Commit

  dfc06c892ea3 ("f2fs: fix is_idle() check for discard type")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/ESojSdprCuyKUx=dFCIuK+U
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0UBeoACgkQAVBC80lX
0GyXuggAoeXxyHUiHWIK+hrIrTVxrnFMdGnPthdi8667/8VSXhl83HXB8h7FvGYA
WChtKHn4RMntdcps6mMoK63HJqmJ5oIM7gekkMsDBDJ6X8yPu0n6g0c00+bmqZto
A7A1G0WGfc5hB8D1vBMGbwFM8r44qo9qCuLP3M8UfFBgW95yKLBk8tJe4h+D0tuF
rSTW/w1jgFKcVTopPi1uVe9O64Cosv/ScWzyBOJ9kU3v3Oqlu1pT50hywv+PBhR+
QkQCWPPiixHt1s0dAZ/J1Zttpjl0fOWoqQR9OeDgkhoOq3+Ht1GbO7HuE39wD08H
JHv1uHjxGc0r/cp8FjWFC4Tnenh3Ag==
=Qobp
-----END PGP SIGNATURE-----

--Sig_/ESojSdprCuyKUx=dFCIuK+U--
