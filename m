Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F4CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55F46205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="dwxT5WY8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729016AbfCUS4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 14:56:17 -0400
Received: from ozlabs.org ([203.11.71.1]:33279 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728882AbfCUSyO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 14:54:14 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44QGD14n0Wz9sRH;
        Fri, 22 Mar 2019 05:54:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1553194450;
        bh=YscWC8oDNJSVgquoq4EPs2G0sMhusEggVL41v4Ve0nI=;
        h=Date:From:To:Cc:Subject:From;
        b=dwxT5WY8+Bf3QRYEU8LghyIL7y5ieRisgANLxlAR4Yk4Cq5YoktIo7Cw+JjcQXNx/
         ffSkigxpKkIwHZj4sGvpB6YP+mpEH5G8ORglTzSiafdCK+vKH4sRYuI/DG+QaGwrmq
         9PeHvsA1QddmcgR0XWptkNqQrHpyaA58+FZQthy5aBSlt0RS4eN3/a9WsrMU0bzKvE
         N3XfqwYcyYd6DNSioa4/IfcrLWreLL6XTwOyZpu/9VqAOeIw2YOyKYei5JVBBpjXkl
         pQoVTPefL/K+GQNBPmZdmjKLbeElBsb4FuZj42J0xaS3ASzm4s9iI1LNfIf0WllxvQ
         jnbgGdMm3o7PA==
Date:   Fri, 22 Mar 2019 05:54:07 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hoang Le <hoang.h.le@dektech.com.au>
Subject: linux-next: Fixes tag needs some work in the net-next tree
Message-ID: <20190322055407.1f19a621@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/zC_joeOPsbuoP_RYdR3cxWF"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/zC_joeOPsbuoP_RYdR3cxWF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commits

  08e046c8966a ("tipc: fix a null pointer deref")
  77d5ad4048fb ("tipc: fix use-after-free in tipc_sk_filter_rcv")

Fixes tag

  Fixes: c55c8eda ("tipc: smooth change between replicast and broadcast")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/zC_joeOPsbuoP_RYdR3cxWF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlyT3c8ACgkQAVBC80lX
0GwdCQf+KFxg6xgWhc2imo1nOevF01EoQEkHxnU27Ki1RqByHaSpK4wlhOSNSGoo
u0NGH7CZF0eHx7VvfcvH3cRy1kXSJmzJLUYNDIf0bYDNbqYQglfm0uVlZqFQQszO
uieKnh8ReEtrgf3e7L43GKndNc+pHyF7XzTQinTFAQJ6bnTtRbwmrcINhIF8lvkt
xU5so3u631S0OQNw/EcFf8sKI0JuLgHnZvsr2h3WSrdZnYk1xwLnMrB0QefM0w6H
QUgeTY1v/ncL9yp0+DVDwyeDWpqC7/ulrm6ICpWru2Fia+1+bjMEA+NACd1EWX4R
GMIWUs2BzDanSFxzPIZNui9BqAfygg==
=x++1
-----END PGP SIGNATURE-----

--Sig_/zC_joeOPsbuoP_RYdR3cxWF--
