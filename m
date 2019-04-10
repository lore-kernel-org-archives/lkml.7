Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D75CC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 10:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 092C820830
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 10:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554892284;
	bh=djomHspi2dpt2T+6XLqPePcXMHdKBd9zcM/msNIpm9E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hDBV0kQyS7NBysqjI1REhU6YWBBmdr6lZ5BP8bor+OgZdUhbyv15903KZvFKBh5U1
	 UwL9tha6N1MqEJE6uIDZvPH0X3gVtGmnYW+zWA6Eb42Jrw91yf3DFNN45DsKWK5lU1
	 mV5KEQSUMZUwtFwvLYCRhtQx8hjkR58L2DMYqG04=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730015AbfDJKbW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 06:31:22 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38666 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727323AbfDJKbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 06:31:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0QwRS+qQulYgtpTymhZ18Urz5MjjW1uI4/jVyPLomdg=; b=iid4YCnLsLU1pkbVIRGlS6RYC
        WwIcImyOi36kWceotoX4H0JaJq4V/ASrVr9VQq4S9nOPE49Jl4x814bAn2VclDdCI3UbZiA28C7BL
        6aBhsH7vOu2nCNSJUOJF33iD5GRYTlEZcj9L3F33zKfxuPExmFENBH7Tbt3Fqr1qj1MLw=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hEAVd-0007jr-TS; Wed, 10 Apr 2019 10:31:14 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id F14AD1128ED3; Wed, 10 Apr 2019 11:31:06 +0100 (BST)
Date:   Wed, 10 Apr 2019 11:31:06 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Cc:     yuehaibing@huawei.com, vigneshr@ti.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        michal.simek@xilinx.com, nagasuresh12@gmail.com
Subject: Re: [LINUX PATCH v2] spi: spi-mem: Fix build error without
 CONFIG_SPI_MEM
Message-ID: <20190410103106.GE6106@sirena.org.uk>
References: <1554875085-25350-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CGDBiGfvSTbxKZlW"
Content-Disposition: inline
In-Reply-To: <1554875085-25350-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
X-Cookie: teamwork, n.:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CGDBiGfvSTbxKZlW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2019 at 11:14:45AM +0530, Naga Sureshkumar Relli wrote:
> When building with CONFIG_SPI_MEM is not set
> gc warns this:
>=20
> drivers/spi/spi-zynq-qspi.o: In function `zynq_qspi_supports_op':
> spi-zynq-qspi.c:(.text+0x1da): undefined reference to `spi_mem_default_su=
pports_op'
>=20
> Fixes: 67dca5e580f1 ("spi: spi-mem: Add support for Zynq QSPI controller")
>=20
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> Signed-off-by: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>

Why is there a signed off by for YueHaibing here?  Did they write the
patch (in which case the authorship is incorrect)?

You've also got an extra blank line between the Fixes and the rest of
the tags which is unusual and might confuse some tools.

--CGDBiGfvSTbxKZlW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlytxeoACgkQJNaLcl1U
h9DUkgf5AWdnX2ZIBdbQt2YsEIvuq/qHrPSwZocJ8bSg/uUdDc+JTMSfV/kTo6oz
tfu0H86NODC8oFErYo4tvPxv4oVyKJxwm+mpa2yGdzzN7cLe+FZYzyxhZ6DhsihF
h0afCMoCV8uesIbntwp//g60MaYPVVgQzRNzc69mQxeB5U0VBSvPo3r93Cv2yMvx
DwjQBgIaYPDbYKiSRJsgnlYEx1AOnMsi3aJdI9DJHlzjnQRRA0C6Iip9psSTyf95
HArQmhLb57lOi6/AVpR/Z7sf3NJ3ApIO7J43i96QM0//K+hZsFXMu3+mvklk5Q4f
CNzeO+U+1p9QciX9GCxjgZAizmUDpg==
=kxip
-----END PGP SIGNATURE-----

--CGDBiGfvSTbxKZlW--
