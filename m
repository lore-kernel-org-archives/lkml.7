Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F52C48BEA
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 12:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 872A92089F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 12:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="RgsJzCOt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730177AbfFXMYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 08:24:05 -0400
Received: from ozlabs.org ([203.11.71.1]:48301 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726700AbfFXMYF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 08:24:05 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45XT414Z2Fz9s7h;
        Mon, 24 Jun 2019 22:24:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561379042;
        bh=xxfRItH2391U7dMXmVvgDsDPes1u3Th6qKL0oNxkGUE=;
        h=Date:From:To:Cc:Subject:From;
        b=RgsJzCOtMbTN2QGsuF6PRJ7w2qC0saKv3TGPxVkzfZBNHFGz5ChO7WZh6qHbsIfUH
         EVEVYarbcEOGSZDY/fPtIGTNUDVNcqRedXgDeNWuDLzVY7vqtFWVkmvV40/MRGm8E1
         ESa/tjgvoHJKS49X+hxp9Jq9vavUpTKXSCVzjzJKxVvTDnmtCLdVb3FzDBPsLo6soc
         ifTpduTubFbjPg/iHO0VPYa5YO6/JXCOS7D8ZV/M5ykT31Qv+P0X4y3hJlBu6Lgf5C
         vLMjhXq/1ztVhD2IqBradoEi2DVi/ZnHcTYZ0Shg/oWSpKZm1P9hvJh9MZopGSalSe
         puiMWYiRT89HQ==
Date:   Mon, 24 Jun 2019 22:23:59 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Marco Felsch <m.felsch@pengutronix.de>
Subject: linux-next: Signed-off-by missing for commit in the imx-mxs tree
Message-ID: <20190624222359.62e92a15@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/K_EFrc3yKf0FARXxVJBIcj8"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/K_EFrc3yKf0FARXxVJBIcj8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  9b5800c21b4d ("ARM: dts: imx6qdl-kontron-samx6i: add Kontron SMARC SoM Su=
pport")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/K_EFrc3yKf0FARXxVJBIcj8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0QwN8ACgkQAVBC80lX
0GxKLwf/Uy/szCPIFgX8Zs/45tByhJ4lCdJWSlxkgK5VudQJiIx5cvFwhSArAVlf
EXK3zxebL8Oll2Pl3PhUhM5tXFa2GHNhRfF9hRLJ6bXj/jy6MNt4qMPRc7PMvW3z
m8Ko4yHJljrkaAv6GzFwF51BLTsB/CM9GqYrjR3B8LuX+eHf9e+V2FhvGWBptcTT
E7tixVha2aaDyGp4BdPYiMOADNmU22kkyZY+G/GPHXyT5gAfj1hoIITKLyk1BO00
YcjftzbtFXocmsJBT0DWzYYv0eZIPov0tdUOQUNR7F8roMo1jNhhvodA86scnha/
K6RNXKZ431O/z0lmxLfaUhhO+W0bqQ==
=/gE6
-----END PGP SIGNATURE-----

--Sig_/K_EFrc3yKf0FARXxVJBIcj8--
