Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C6CC10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 22:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 302CC2075A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 22:45:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="dXZZp6O5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729685AbfDVWpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 18:45:05 -0400
Received: from ozlabs.org ([203.11.71.1]:57049 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728965AbfDVWpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 18:45:04 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44p1qf2bT4z9s7T;
        Tue, 23 Apr 2019 08:45:02 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1555973102;
        bh=QpyJpH6+jEhVKLaKM66uyRpTCCiPhfker/bAhbACyRE=;
        h=Date:From:To:Cc:Subject:From;
        b=dXZZp6O5m88RtC6EC6ogZ4+WOS6VPyURKzQTSgaIWvdQ7gAkLNMJqlKuADNdOjJYx
         qCpUwrL3bP9n6PDcLo3v83bF5F4SnNol9N3Pra2A1CgOtB3TG7DaOjRtT4R1S6/oMv
         HggoYbY4U1wRvaDVu2QfY8zWTIz+pLww7ZtCYil/TrKDnVuIbg0ck3/kZI1d+/fBkH
         U2BDl2quDFbSLZyQQoorW5/bmzLutWnXO1/KR2FALsxU+aHPqJLlP/0cnoA7a+WU4r
         g5q558fQOTt1CS6nM6lxn986RPmXo+qQMY7Dl2TjkGiFQd1vZqr4FsSDCpfgavNHb5
         SYsPCoILO1Tjg==
Date:   Tue, 23 Apr 2019 08:45:01 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Fabio Estevam <festevam@gmail.com>
Subject: linux-next: build failure after merge of the imx-mxs tree
Message-ID: <20190423084501.15824b18@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/gEokQ+0QF4RgqbAyZFJpool"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/gEokQ+0QF4RgqbAyZFJpool
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the imx-mxs tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

arch/arm/boot/dts/imx7d-zii-rpu2.dts:46.12-50.4: Warning (io_channels_prope=
rty): /iio-hwmon: Missing property '#io-channel-cells' in node /soc/aips-bu=
s@30400000/adc@30610000 or bad phandle (referred from io-channels[0])

Caused by commit

  69ab5392f517 ("ARM: dts: Add support for ZII i.MX7 RPU2 board")

--=20
Cheers,
Stephen Rothwell

--Sig_/gEokQ+0QF4RgqbAyZFJpool
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAly+Q+0ACgkQAVBC80lX
0GyIsggAo75ay3PgqQ0OwkeFeB9Dq1ZztKdAc2wkfr6+bM3f19sNnzqyDMWhCY7M
HUL4hFCLotb2Puj6KdtA1ygwSi6fB5t/d6Iq+OIWzlDU2smhXYeXMA/PGQ5DGFwY
2KE+RbzCJvEPnCCPDqd2iKgHmK1RhpgsXPIXp244Bq03ekdl5AlkiPXQcVGuzPjc
96pPI7cKwhvcBFDlxJ48LjJ8sRgJlAFCnlQQun2cc+N33QRJYjSF3l0XTnmQ60MM
liHiKTGSOF9Uh7VRbpu6T3XDcUm4vcfrgiiZxkNK9x5v2kyBb8ebOEIlOPMdgIVx
Gq5Y9kfp5lcn39SG0BQHVbP50uU3EQ==
=u3EY
-----END PGP SIGNATURE-----

--Sig_/gEokQ+0QF4RgqbAyZFJpool--
