Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B303C19759
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 03:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C7F72183F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 03:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="X9fdExVr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfHEDEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Aug 2019 23:04:13 -0400
Received: from ozlabs.org ([203.11.71.1]:46505 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726765AbfHEDEN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Aug 2019 23:04:13 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4622ff22Fkz9sNx;
        Mon,  5 Aug 2019 13:04:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1564974250;
        bh=r9I99tLyLD5nxx5Zr+h7m74pVqauWanji7UCe01s9Pw=;
        h=Date:From:To:Cc:Subject:From;
        b=X9fdExVrw6l7zKmXACen9UT+yWJbBuO88sqIShkZf8thWKSFoozBT54vGFnMddjV5
         vi4BOJ5fySjY165F3IbSS0+NjQ5Os5gfpDmtd3e9dIV9kntKCDx5O/24PYiy54ovSK
         1gEAIP7LphOQVZ/e37Lp9nGY13euBSnCIPVLKv/PZBXWpUwTaYlqAdOuDoGmjkrh70
         /D1j4lH/eWsg58L/aaavQhj9K7jYxZEXLOcLsOfQzIs83TzZY4orUijmGdec27Lh3m
         vnoUz3yhza2KOV2NNT0mX32dv+KcznUT+A0zJmFkB0jehThTSFgkdrKLhd2Pys0vZe
         WzKuJgvqOpsJA==
Date:   Mon, 5 Aug 2019 13:04:03 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Saravana Kannan <saravanak@google.com>
Subject: linux-next: build warning after merge of the driver-core tree
Message-ID: <20190805130403.06dc27b4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/bes5F2ic.1asHnYSmE8if9o";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/bes5F2ic.1asHnYSmE8if9o
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the driver-core tree, today's linux-next build (powerpc
ppc64_defconfig) produced this warning:

drivers/of/platform.c:674:12: warning: 'of_link_to_suppliers' defined but n=
ot used [-Wunused-function]
 static int of_link_to_suppliers(struct device *dev)
            ^~~~~~~~~~~~~~~~~~~~

Introduced by commit

  690ff7881b26 ("of/platform: Add functional dependency link from DT bindin=
gs")

--=20
Cheers,
Stephen Rothwell

--Sig_/bes5F2ic.1asHnYSmE8if9o
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl1HnKMACgkQAVBC80lX
0GwPOwf/WnyFlJapb2s4Yc7hWk7pBo2Yo/avAfRCgVVc3/qWyeQlGAeFSruIrhzP
Ic+VDl5Io9qqsc4GaeaFC/L/CJL23QneqgQqlk0aRR3t+jcRjl1JY6nhcEy1daPI
ZaXci4Z/B/gYutuZ7vrlJOfEMCXgeQUh8eLsntm2i56mI0tGEtwCh4OmtXqHtm7c
dbarxQKOOPzTnB9x/V6SI7naTfyqc/7kHSbymDZwYQpb1gX1sRCd+zUOkJ3poNq2
+nkJMVKGz7+DwjEVAfGDndbgQP1nOh9iSeNQYpOUKOMoQD+O21h2P3WRjtIbBXag
CcoGI6MqwN6/g9mIZ61xrZcVnaRnlg==
=wQ+3
-----END PGP SIGNATURE-----

--Sig_/bes5F2ic.1asHnYSmE8if9o--
