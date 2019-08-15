Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA91C3A59B
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 21:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22A882083B
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 21:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="f0U1z3JQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733177AbfHOVxQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 17:53:16 -0400
Received: from ozlabs.org ([203.11.71.1]:40125 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732464AbfHOVxP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 17:53:15 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 468gDn3Zxtz9sN1;
        Fri, 16 Aug 2019 07:53:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1565905993;
        bh=UBvGR4rOMFCFjVgG/YgM8FmvoChkQdaLmgyvyVyoskA=;
        h=Date:From:To:Cc:Subject:From;
        b=f0U1z3JQ3ZU6WVrrtD62YcCQx8bFN1cRg303GsD3LnILDZxCadRIKIht7YD1LoUSE
         TZ+s2D8UN20yFgiqMDFg1H1kZ/jRQdfEP92fsQKxS9CAT8IXqDD+H9z3+96kiXd9Ws
         4XtvRL+irGkFSSjRdM0bVQC3zSCE2dFtp0E2aubYcBnPL8xuIPceA45vdZ9k8fluKL
         yxdMKlwKVJOfuZPdVXXEWWjSm1tGBNCOYy31Ljr18V2td7iXq8TFZ4T/7Xdn2sUcSG
         0+eQ+154QASeYypsWNAcbz93una7iJziHtgYm58kwyOlT9e25qJ0b0bBWv5en11NOg
         7SoGSdjncmCyA==
Date:   Fri, 16 Aug 2019 07:53:12 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Grover <andy.grover@oracle.com>,
        Gerd Rausch <gerd.rausch@oracle.com>,
        Chris Mason <chris.mason@oracle.com>
Subject: linux-next: Signed-off-by missing for commits in the net-next tree
Message-ID: <20190816075312.64959223@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/D6wGvOdsRiAA4rF/zP2nzLE";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/D6wGvOdsRiAA4rF/zP2nzLE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  11740ef44829 ("rds: check for excessive looping in rds_send_xmit")
  65dedd7fe1f2 ("RDS: limit the number of times we loop in rds_send_xmit")

are missing a Signed-off-by from their authors.

--=20
Cheers,
Stephen Rothwell

--Sig_/D6wGvOdsRiAA4rF/zP2nzLE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl1V1EgACgkQAVBC80lX
0Gw2Pgf+KLafuIEpBk4kwXQqoj4exbNOWc0HrZOKEgPfVElGiQRpWuF6XH6KnoWO
MF4FZez6xrMIZ40/YHhWKimd1sd27bdoFS3lvfbECbo08H7QSFS27oTsOvNetS90
OzQ8DErPn6+jskgrcAW45EKAgiF1Nu17ApJf3Gy9vnVJB0Yo6SY36q/w2DtqrXq/
beWnF8zSNrkGSlgx2OrmfBP5ABCyFBxwaKYBuBvAyfFsmUm+d3WL67ZzOexIooAP
RuSEUCUqG63k+3Kkaffrdty5XduKx/bFGpuW0ANVPDf/DXS1VMJ8NLKlQw4exWWA
TXFBdAKyvo2Z9ho2kapQRykLW2NKmg==
=QES6
-----END PGP SIGNATURE-----

--Sig_/D6wGvOdsRiAA4rF/zP2nzLE--
