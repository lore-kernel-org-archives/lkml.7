Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDD4C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 21:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72313218A5
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 21:30:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="OMPaCh9Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbfCUVaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 17:30:55 -0400
Received: from ozlabs.org ([203.11.71.1]:60363 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726529AbfCUVaz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 17:30:55 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44QKhq5TSkz9sR9;
        Fri, 22 Mar 2019 08:30:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1553203852;
        bh=pgJTgvz7awqNRP3sOfMviFHStxt5Z4Xv6kdZMvQ04Eo=;
        h=Date:From:To:Cc:Subject:From;
        b=OMPaCh9Qx37fC+yxF9Z0eOh6q2xyc+OdDf+jW/5bzLgTAHd8hHqGsIrj0N/AdFfqp
         9JSEXIulFg8Ct52tmfZXamGl1L8hrjotD6VPZaOn4/EKIaXZyJyUDwpV0f1ixkdRko
         13JhYn0uJ6IEYSa+dj22YwggMf8VUv8sSpJC9lmHWA5Pt4Iz5XDD2i+jsdL/U1bzAN
         OgXvfGtwJ+zn8V6uI+xXZQHDLj46CIpuJErZOyjYRA9D+K4KpjIX5htDHrfCOKredH
         TGrnPQljMfYAJ7d+gXM5yw0PEpgnBgC0HW2W5ihAodrMvtf5p3M+fGtrhOjruOwiph
         zDJAxipc89v9Q==
Date:   Fri, 22 Mar 2019 08:30:48 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: build warning after merge of the sunxi tree
Message-ID: <20190322083048.31084cf8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/DERXhB.NTGdHDK+TBouCq2V"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/DERXhB.NTGdHDK+TBouCq2V
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the sunxi tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

WARNING: unmet direct dependencies detected for MFD_SUN6I_PRCM
  Depends on [n]: HAS_IOMEM [=3Dy] && ARCH_SUNXI
  Selected by [y]:
  - CLK_SUNXI_PRCM_SUN6I [=3Dy] && COMMON_CLK [=3Dy] && CLK_SUNXI [=3Dy]
  - CLK_SUNXI_PRCM_SUN8I [=3Dy] && COMMON_CLK [=3Dy] && CLK_SUNXI [=3Dy]

WARNING: unmet direct dependencies detected for MFD_SUN6I_PRCM
  Depends on [n]: HAS_IOMEM [=3Dy] && ARCH_SUNXI
  Selected by [y]:
  - CLK_SUNXI_PRCM_SUN6I [=3Dy] && COMMON_CLK [=3Dy] && CLK_SUNXI [=3Dy]
  - CLK_SUNXI_PRCM_SUN8I [=3Dy] && COMMON_CLK [=3Dy] && CLK_SUNXI [=3Dy]

WARNING: unmet direct dependencies detected for MFD_SUN6I_PRCM
  Depends on [n]: HAS_IOMEM [=3Dy] && ARCH_SUNXI
  Selected by [y]:
  - CLK_SUNXI_PRCM_SUN6I [=3Dy] && COMMON_CLK [=3Dy] && CLK_SUNXI [=3Dy]
  - CLK_SUNXI_PRCM_SUN8I [=3Dy] && COMMON_CLK [=3Dy] && CLK_SUNXI [=3Dy]

Introduced by commit

  49c726d55c1b ("clk: sunxi: Add Kconfig options")

--=20
Cheers,
Stephen Rothwell

--Sig_/DERXhB.NTGdHDK+TBouCq2V
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlyUAogACgkQAVBC80lX
0GwB6wf6Ax+GSnIN08ERdKis6cyDDlZgEpfaqa4CFj5x3bcfJfIepB2gfODXMBOB
Ng5oSbo13hg5QwSsAzYlLv56cQrkpTvzF1oMa7UbbZI5cdZ/1UB1BKA10JPqJmLr
Vegz5stRTgDPybYR2U6xnw95LfR47vXuIEC1K2sDlbcg1IfxRxDiNHi3ThEiEPvy
0q/iu9XJn5AzSyDsLa7Cjb/QBjjE3XZH3lat+DryVf9CK+XQ/1l5akjdLSBxIEgE
oiakS0fW4W2rfPXxci7uep65Nzfe+B/y1vGvA9yoHJ6uaZYY9s8iMafUi5kzrNNm
rTcbD30pXSqSnElN2Ek+W5oluFvFKQ==
=CDNd
-----END PGP SIGNATURE-----

--Sig_/DERXhB.NTGdHDK+TBouCq2V--
