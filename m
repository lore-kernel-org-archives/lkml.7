Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28EF8C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 14:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC8AA227CC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 14:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="cLa02IF7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728722AbfFCODG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 10:03:06 -0400
Received: from ozlabs.org ([203.11.71.1]:36913 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726780AbfFCODF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 10:03:05 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45HcFy3VZNz9s4V;
        Tue,  4 Jun 2019 00:03:02 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1559570582;
        bh=YQmprlQcov0lqweTkPPWd8ZDL5rmWYDbaGinmtBxu44=;
        h=Date:From:To:Cc:Subject:From;
        b=cLa02IF7Ofm8/RPc/K7inCIHa7B8re7Tmz/iqluo3XqfRIKxzRxwyf9uf+EvClD60
         xxtf3tDqcuFhZir2op+AHJ3tNVILDFv1sd6nFmnvydPvVJ8cD9mwOc1i36x9ViSJ8i
         ER/aVRw7UTuu7tngjpUutUanJ7I0LK5Xtv3ScE/adW7sutx7mHOuarr44x5w563MVv
         OJCn6+bwDUefwtkDiMV9D1Tss3E7dy33Ny+HWEHJVc0vPpF1k+lj8+yq2IsTMsuuZD
         MEQW2iuhW5oLGqRbmA8RC3Ir4cBaMNXEUWR301IXtnx5MbcX4KaOLd2nS00xcdHR09
         gbRCCniG+M8yQ==
Date:   Tue, 4 Jun 2019 00:02:55 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: linux-next: Fixes tag needs some work in the phy tree
Message-ID: <20190604000255.38c084e3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/.k/a7L63NBkov+bwl0D_R_N"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/.k/a7L63NBkov+bwl0D_R_N
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  3ddc3f3057ff ("phy: renesas: rcar-gen2: Fix memory leak at error paths")

Fixes tag

  Fixes: 1233f59f745 ("phy: Renesas R-Car Gen2 PHY driver")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/.k/a7L63NBkov+bwl0D_R_N
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlz1KI8ACgkQAVBC80lX
0GwVdgf6AgnZzXI0Tsoy83ah8JTi/GgbIvsitDcjcKwY/pblvYx2aL1VMtFOP+m+
NtIZdRxwH6Sn6msGEeq5JEst2chVWWqDRAbzPm3ANT7rH88meORasAgPLLP0HzDv
f1kenI5bDjti/eC2PUch6Rdpn5Ey7qAUXYJmJFEo0Nz72lSQUUSwBuHoX+r6UQAS
H3GExOPpMO05u1vh2ZJ2s7HLQsQcVXT5Cj/uptPTJxqzvdjPDGizS2C9Y38eQqc9
fBR4FuZzAalPOytImTLWOiqb2jyUbCb/MIUAFMPDoNZ4vnk/3xRsj42NZZ5R1/pm
J+Z5ghCs3rEyzVuPx52gYhulUv5LLw==
=AcrJ
-----END PGP SIGNATURE-----

--Sig_/.k/a7L63NBkov+bwl0D_R_N--
