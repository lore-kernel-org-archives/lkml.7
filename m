Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D9A6C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D25620880
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="C45IB+Wp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731584AbfDAR6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:58:40 -0400
Received: from ozlabs.org ([203.11.71.1]:51359 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729485AbfDAR6i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:58:38 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44Y0Sp62lPz9sPZ;
        Tue,  2 Apr 2019 04:58:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1554141515;
        bh=Bi3Uu6Engo1xj316PMzRJX05F5/cCTIiYIkumGZnFDQ=;
        h=Date:From:To:Cc:Subject:From;
        b=C45IB+WpvYkbVqioqk4NtJ5sQ+tXrqpFH8vLriA4WHYULb18prFfqMRfyj4T8Ik02
         kSsVXmcoq2QB3IRhguIVkpX5yMDK8TPOkEqRVuMblE9HbyH6do1VaLMt45DSq2Y/jO
         VktPxnBUqD+Agbpbpm5erRO9sd+wIBVml+KkGDLBWyj7RaMEjHJq+yWWfqVgiIdEMg
         eKj5pPVf5AyZJyIpf6PjfHzIkCjs2CMLI4r741Sm5GSlpRjh6fUpj/tUVnAGuCvKmk
         jgLCxwp/WDvHciiE9GcJ+e9XLktSghPg0J4db8QIgWGx1/LX4Ok1EhbwN8yyPFZX3z
         5SsDdU+IRbyNg==
Date:   Tue, 2 Apr 2019 04:58:28 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: linux-next: Fixes tags need some work in the spi-fixes tree
Message-ID: <20190402045828.699f5700@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/YE/xY76rigPlK8m2vOrcty0"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/YE/xY76rigPlK8m2vOrcty0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Mark,

In commit

  019194933339 ("spi: tegra114: reset controller on probe")

Fixes tag

  Fixes: SPI driver can be built as module so perform SPI controller reset

has these problem(s):

  - No SHA1 recognised

In commit

  f4ce428c41fb ("spi: tegra114: configure dma burst size to fifo trig level=
")

Fixes tag

  Fixes: Configure DMA burst size to be same as SPI TX/RX trigger levels

has these problem(s):

  - No SHA1 recognised

In commit

  c4fc9e5b28ff ("spi: tegra114: flush fifos")

Fixes tag

  Fixes: Flush TX and RX FIFOs before start of new transfer and on FIFO

has these problem(s):

  - No SHA1 recognised

In commit

  32bd1a9551ca ("spi: tegra114: terminate dma and reset on transfer timeout=
")

Fixes tag

  Fixes: terminate DMA and perform controller reset on transfer timeout

has these problem(s):

  - No SHA1 recognised

In commit

  1a89ac5b9189 ("spi: tegra114: fix for unpacked mode transfers")

Fixes tag

  Fixes: computation of actual bytes to fill/receive in/from FIFO in unpack=
ed

has these problem(s):

  - No SHA1 recognised

In commit

  7b3d10cdf54b ("spi: tegra114: clear packed bit for unpacked mode")

Fixes tag

  Fixes: Clear packed bit when not using packed mode.

has these problem(s):

  - No SHA1 recognised

--=20
Cheers,
Stephen Rothwell

--Sig_/YE/xY76rigPlK8m2vOrcty0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlyiUUQACgkQAVBC80lX
0Gwa0gf/Rmt3xgQGd6sDTjIszOYyPmFEMxd6BrbE/1XaCvnMytytW2G+0Sbk1RW2
e+xhO2D6N8hQck1EsWEZ9d5VZdHONXMqqjiuwlkyK6KORREoX8ORmHm4HNOwdfK4
KQZ+rskrfpylpj1JR1zE74F2XteAM9t+4XJj6wI26wwfkinTR7CISIr+FHt04XJe
90h7MJtwBxVaBv0j4BhdyyCP4FBT5v9c6cSSa6JmctuoO1smkjD3dNeym068UJFP
MFyOYVnjuqQS85I2lAIFtzeTtoIBqe6Zs8ul2Z497aM1h5oOl/mbTO173C4VATYI
qss4uEx9aN8RXDiPTZAp7eyV3npcZw==
=87um
-----END PGP SIGNATURE-----

--Sig_/YE/xY76rigPlK8m2vOrcty0--
