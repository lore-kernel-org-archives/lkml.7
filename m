Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B25C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 21:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A252E20866
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 21:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ltnYKZ0C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbfEAVoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 17:44:04 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:52177 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726116AbfEAVoE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 17:44:04 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44vX360ssTz9s9y;
        Thu,  2 May 2019 07:44:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1556747042;
        bh=G+FqxP1wCqdR3zuvAR4o7OCUkf/l0kFwCNAUzf5oDGk=;
        h=Date:From:To:Cc:Subject:From;
        b=ltnYKZ0Ctm0KXW9Owuky480KdqAR5BeZIrIG1+R100XsjmVOSptD91pHSp4MHRoYX
         D1c9o/FgFOnNVDH2GBZhbLpWfyJMZy/Cm3fvNpYbKvR6vCBPoqbgmd5hZ1giiGt1iJ
         QGlzGFCK+PnU3wKycWSzavTIOgKEx1DZ3zNkDD/IwemGi7qZ6jnk7AxgcTHRL8/e7G
         V05Phbq7/nrxE7+cs0sIfmyHvOvu7xDAaGFfoo87MGRZReCA1HLg2cVwdxX/BLjt5i
         yGaLlurK8p2+optpjpN2Ii0OQj7YzlkPh9Oia8EAI1jUlccOf/5NSil1fslEr4e5zv
         uxMeuH7UcRdCA==
Date:   Thu, 2 May 2019 07:43:58 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the clk tree
Message-ID: <20190502074358.4966fc20@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/DV0zWxCcxi5k4otIIDmjcJC"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/DV0zWxCcxi5k4otIIDmjcJC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  a048fe996b51 ("clk: imx: pllv4: add fractional-N pll support")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/DV0zWxCcxi5k4otIIDmjcJC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzKEx4ACgkQAVBC80lX
0Gx/8wf+JusGDcy35pqrz8vvXerevz/daug2TWzUPo8G/be5pylAxC0XPh7sSbb2
iKnkGLvyB7z8VPIcAzjmuw/wVNrdKxrLxR7ms5xcWrGnHQeTGHOz/BkrplBGUA+6
KwUnpPZ/qrlh6h2KFoi3Td5/fm0B+mO2Wnf2j8uoBkOkrf0svULOMsDco6kwT09b
QafRtyGG/g8VKAPbA55BY61upTn33NxXA1gv2WyXUO2AEqGHN2Niz7z4E/dfK9ci
kBCExeVsubRkZMImYC16MJYYFN8RBsAdaKwukDQI2V6XVlJe6+07Mx440S4OWCJE
fwmis57JD/9fkwXi+dkIgjOJeIhvyg==
=hu6v
-----END PGP SIGNATURE-----

--Sig_/DV0zWxCcxi5k4otIIDmjcJC--
