Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4FB3C28EB6
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 21:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B187220673
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 21:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="W68Fj/Zd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728617AbfFFVt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 17:49:29 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:53415 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726941AbfFFVt2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 17:49:28 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45KfSk10T3z9s00;
        Fri,  7 Jun 2019 07:49:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1559857766;
        bh=9WgYds+xNr4KNLZm9sCl6oZ6GqsGzFWaykzhKuDwk3s=;
        h=Date:From:To:Cc:Subject:From;
        b=W68Fj/Zd3tPvc3dHLxbHAlJByd2RtYY1JGcUTKOE2E0nkc2ijdjPCkmPv+wYNZt3c
         sCHDeSdkUCXEnjoMILCxGEfAL+yKBB3Kcy9e+B2j0D59z85xI19Q3W5kEL6mAvLEd4
         LtsrKv/gK4VD+4ggTTev5prk7YQd4EUGX6/pCPakaJZS71pMF4L1l8/tgTGGi7t2v3
         Vh02WY7dWdF20IF4CjH+TWQUaqkpTQyL4ZXJ0tm2m3Sx5ykbEAg+gNpjlTNFh82f3C
         x5wBRaYynqA6xZgHwW44Lh0czFo1WbZdZWuRHORBAabqfWMBXFDU5QZnxwyeJcwxTE
         +CD9KgTEmJCUQ==
Date:   Fri, 7 Jun 2019 07:49:21 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the clk tree
Message-ID: <20190607074921.6d4f8dfb@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Hb1dwY/j9mWRI9e367sx4In"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Hb1dwY/j9mWRI9e367sx4In
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  01269050c65c ("clk: mediatek: mt8516: Remove unused variable")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/Hb1dwY/j9mWRI9e367sx4In
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlz5imIACgkQAVBC80lX
0GxOSAf9Fe27LLDIAmI3mpJ0YHa0I6krA9Cx+vJxqtRNTPI62rNUClH/ShjAMrRD
Kk6WMxow7bk4L2gGuJfXd6XbOgGJBQsw3icecnlDy2pmnM21MEsmAXb16Ka3wMoI
inzvLpWjhGgsGYVWQ6edZyMLVAIt3Q5tQISfLpcnWsPbkD1CYqb3SMUqGoP/fmID
gXo1zRDDunl7FWwP2i5xm3HWqbolzrRfehGlBBoGo5PLy3E1JTMQYIYN0TIkLQng
4TcBvNZQO+PVFQc/tWg58pV1hE3owUEnnws278JCZcG4Po5D3bC2XXcm24Y8OUr1
TpWEo2kTqT9EqMnjcGz7NX2s/blHwg==
=Yu6S
-----END PGP SIGNATURE-----

--Sig_/Hb1dwY/j9mWRI9e367sx4In--
