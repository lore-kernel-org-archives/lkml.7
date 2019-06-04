Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4C2C28CC3
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 06:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 744C724CDE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 06:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Tv2bi02v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfFDGgA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 02:36:00 -0400
Received: from ozlabs.org ([203.11.71.1]:34437 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726554AbfFDGgA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 02:36:00 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45J2Hd2jWwz9sBb;
        Tue,  4 Jun 2019 16:35:57 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1559630157;
        bh=H4K9Tz/q5bvYmq3KOuuobShQeMP6gDZRNdoTCk5KclA=;
        h=Date:From:To:Cc:Subject:From;
        b=Tv2bi02vjGbJikb58V+Uxsxnh8zkG2TbXwYevJ6Kz6UfQmeLGU8X5205dnyqwuRqU
         XnV+ub8OTDKcM3dIkJK/6xKp7Cjs3KfdPClCfFY7cCBhCuglcLUZcOL7U8ootAwY0z
         LpfhCbTY8YF7ixaYSm/tdSGzv2uVs6jxFmlyWERg5QJKrUusqGnJFITkcywyFAbDLf
         0x3hBqliG6oYGadbOYl9Y4yfybI0Gc1/UbdG8iQUqCazT2CUCrJWawJrx5vvIIlypL
         y8LpGsZxYhvnDDW6pUhWpEIjQtpiaW0HdTavJ4LdC8XrwIExzpyn4M0KbY3I1Gvn+W
         KD0FfTsb9Lp0w==
Date:   Tue, 4 Jun 2019 16:35:56 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christian Hewitt <christianshewitt@gmail.com>
Subject: linux-next: Signed-off-by missing for commits in the amlogic tree
Message-ID: <20190604163556.6508a035@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/KGUtQs60+yDjiQeBNrOvUIu"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/KGUtQs60+yDjiQeBNrOvUIu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  43c34b2dd925 ("arm64: dts: meson-gxm-khadas-vim2: fix gpio-keys-polled no=
de")

is missing a Signed-off-by from its author.

Commit

  7ace72ad0a72 ("arm64: dts: meson: g12a: add SDIO controller")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/KGUtQs60+yDjiQeBNrOvUIu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlz2EUwACgkQAVBC80lX
0Gys6wf/W/VbW990N190vZ7dXeSo+R2VBm5yJGELyJnVvZjUFesvIoUDJgAH7jdL
mRW9kisBOa5f9lel5/AF/D7MDVdOyjkQFElQYNzKY1lmkl/nJTUnPngDXQqXwGKZ
BOVaVdQvx0+ydEXsEGPEsqVfJ5IOxbv3XhpKUZnefoHvgdHzBWyVAWid6C+c3l2x
nfLzk9LqUo7feD8Vr/0MFSTo9XKIwWdW12JUuUoafQMHuoc8N/6aeQAblagEJYR1
pF6SmRtiog57OzFjRM3WwqRUG2snkH7AwTO/rmq8kCT8Y2zsJAhpcIugcxiewH2q
H5EgFQInMC+UQ5fg/hJLa94rIdcdqw==
=9bS4
-----END PGP SIGNATURE-----

--Sig_/KGUtQs60+yDjiQeBNrOvUIu--
