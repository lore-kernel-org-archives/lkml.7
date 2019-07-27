Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B621C41514
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 05:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04F1C2166E
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 05:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="U/Jngwsa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbfG0FHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 01:07:48 -0400
Received: from ozlabs.org ([203.11.71.1]:43053 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725818AbfG0FHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 01:07:47 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45wYqN0Df9z9s8m;
        Sat, 27 Jul 2019 15:07:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1564204064;
        bh=9VKOPpnCFNPvhE4WbCH3Jd3UIbwkeUe5Udt6mTVfzQA=;
        h=Date:From:To:Cc:Subject:From;
        b=U/JngwsaMcSUk+pVEdrV1ZabkstSszx7BdFKOumorvjeO7QIDgE1V6HTbACt7Qzpi
         KW1VWHri8P3GNTJYyNMmrO7o2/h9+JtGYccnrV1gSf0wz5nIPZYbaJuvlmQBOE6CEB
         scL8spAIPkeUPz54Op2wUkU9d3oSj5x0+J3aJIqAcuR2Nrf64iPt36VfOrT9GA+MqJ
         UjwmfRlV6FIc+ZJRkTijMxI7IMS4+rHBxIAoZkaX7YK4Qmpr9HP2o/dwVHNmTkUUOw
         dFU3GKopotF1bf7GniAmX+Bvql6CznK9OB8Hn0xmqq+iIBc6OlCSYwRrNcR/s1Eixx
         NmcfrYD0NstSw==
Date:   Sat, 27 Jul 2019 15:07:38 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Hook, Gary" <Gary.Hook@amd.com>
Subject: linux-next: Signed-off-by missing for commit in the crypto tree
Message-ID: <20190727150738.3640330a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/3xuTo3MPgvbTu/7bDhsMuiR";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/3xuTo3MPgvbTu/7bDhsMuiR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  53a5d5192803 ("crypto: ccp - Log an error message when ccp-crypto fails t=
o load")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/3xuTo3MPgvbTu/7bDhsMuiR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl073BoACgkQAVBC80lX
0GxGewf/ad86dxEWUFE63NAJ28+iTnoxJkqp6Yc4Gg97n03HSMgqL4Cq/5KEkkq/
kwo7WE5ND6KZX3llmDZ5iKOx9LaO2XlYiWusCrpjhRIV16gyBshl4tJVnJFcDPNy
Ve5ma/lbGlrktND25/ORtaZh2Z/hxJVCh9yudXpYif7sGKN4a3MEbfg18LcdGlUS
oO7Ry2aqxZKkSDFfO8V1DdE1dn8hcCRKlVfRIjg7veQ0G9Y4NF78CbOgYgywwQ2Z
69d1wf8km1H4+ivrKj3kBDgadUa9Nzw82ySIpJI+VI/4scOyk127hY3isgiYE60O
5gEPU7is3YXib3Zap598UjTEot+tww==
=nznr
-----END PGP SIGNATURE-----

--Sig_/3xuTo3MPgvbTu/7bDhsMuiR--
