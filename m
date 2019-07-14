Return-Path: <SRS0=2uMJ=VL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3154C74A41
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 12:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AD022064A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 12:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="jYOZqyfW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbfGNMzi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 08:55:38 -0400
Received: from ozlabs.org ([203.11.71.1]:60997 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728316AbfGNMzi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 08:55:38 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45mmqC09K3z9sN6;
        Sun, 14 Jul 2019 22:55:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1563108935;
        bh=FyJ9ev1inMHsgGNdHri21RqevrCv+51et1dM/m8BvTU=;
        h=Date:From:To:Cc:Subject:From;
        b=jYOZqyfWdPzBN8Wsx/4zSOIZrjhp8MEJO2emLmQdjAocv3RBgPdB2iM7TsGgp3Eds
         aRpEuSatytyjujoJU+ksnEaxs+MZVStks0x7qCfjm2xLFGkr7VGny25fsjtKnhKfj5
         NKt34m15ZcYthR1cDzdW41PyZeEzLEe+uHrqM684f+2iYjjYVdrtAqEA5dPSTlXq4F
         vT79YrM/WRCn2tm6dp5ebf0hNfozqabVB1+uRWTRWCwXPpzwOjQ+7jTw45BIAKGKTS
         QRGi5keIZxYrwH/slC0VvffRjV87peaTOcZLU3K5okryNjl/3Q4iyp/Kj6y4f2ZK3T
         I2ey2u6wMJxHg==
Date:   Sun, 14 Jul 2019 22:55:34 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: linux-next: Fixes tag needs some work in the hyperv-fixes tree
Message-ID: <20190714225534.1dc093ad@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/nGgmlx7Hig0s5zQfq+ftQ.T"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/nGgmlx7Hig0s5zQfq+ftQ.T
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  2e6d7851bdeb ("PCI: pci-hyperv: fix build errors on non-SYSFS config")

Fixes tag

  Fixes: a15f2c08c708 ("PCI: hv: support reporting serial number as slot

has these problem(s):

  - Subject has leading but no trailing parentheses
  - Subject has leading but no trailing quotes

Please do not split Fixes tags over more than one line.  Also do not
include blank lines among the tag lines.

--=20
Cheers,
Stephen Rothwell

--Sig_/nGgmlx7Hig0s5zQfq+ftQ.T
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0rJkYACgkQAVBC80lX
0GyvEQf/bwoc6qihQRAQGjM7n5k5NKPD6USPio1qgiJy/foNeIOCyHEnMDLd6xjh
HZp/w//0JSSJpwhTeoFROZequiEOIGYs4XDzMGe5F5RdlAjwkFn1R79msNMu/9fu
iYEMNP092wIUgGK267hpKDlqL4FbU516omeG2eFrfCeIbnGkfSEx0KbDdj9F6U+I
fv0Dzex7ZLxfu9sOaEZjfnan8aEPsMOhXhacCs3/eLMJbD3DNuwFvblaUXArnHob
WC1lN8BP1pmBY9wTn3y24cpWctEtHu9NpiisRbGwhxDmiPCXVC8dGVD9rMS2huKk
QTrtd7eePW3Vh7sLLWAnaywrm0MHQA==
=ZxPM
-----END PGP SIGNATURE-----

--Sig_/nGgmlx7Hig0s5zQfq+ftQ.T--
