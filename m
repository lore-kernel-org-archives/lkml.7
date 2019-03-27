Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D663BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 20:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A0AD20700
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 20:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="gShiKVK7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbfC0U1n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 16:27:43 -0400
Received: from ozlabs.org ([203.11.71.1]:56411 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725841AbfC0U1n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 16:27:43 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44V0175kHrz9sPg;
        Thu, 28 Mar 2019 07:27:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1553718460;
        bh=iFn85oVniUTCciFFdMVVCN7iRFk7Y0MJP0VL4yU0uto=;
        h=Date:From:To:Cc:Subject:From;
        b=gShiKVK7iSX4+7k8k5RmEdWmrdz19tTwRHWjAPFqu4H0xRKeTcHtDU3s40BFmvKGX
         nVIXxg54+RpRPGdq611Pv1GYx0fFFJ60PgtDt+K6VPxdf1k/6JPHEOWZEGQhuGS8KY
         j9gJaO0LK9QaVDv0tEtmAgAfQXtiqvZjUrtylTWlJyHVw4PO3jdDahDgam9v+VN7wo
         awMn8mfWkcNArnAQ8hJonuZjN2kIHBICH3Dam/pYKPWLLhkg3saKqu2n7hJftJGf/y
         a9LImQs+8WkWT3n3ZU55K4PqEtcbfCYj0M7Aft3m7Ag11L/67uZAxRIVSyF3gDhg/j
         gHERTYdyQcgGA==
Date:   Thu, 28 Mar 2019 07:27:34 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Razvan Stefanescu <razvan.stefanescu@microchip.com>
Subject: linux-next: Fixes tag needs some work in the tty.current tree
Message-ID: <20190328072734.2093d03c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/NyVSC6m2iVyJYjsKHiymQmt"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/NyVSC6m2iVyJYjsKHiymQmt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  69646d7a3689 ("tty/serial: atmel: RS485 HD w/DMA: enable RX after TX is s=
topped")

Fixes tag

  Fixes: b389f173aaa1 ("tty/serial: atmel: RS485 half duplex w/DMA: enable

has these problem(s):

  - Subject has leading but no trailing parentheses
  - Subject has leading but no trailing quotes

Please do not split Fixes tags across more than 1 line.

--=20
Cheers,
Stephen Rothwell

--Sig_/NyVSC6m2iVyJYjsKHiymQmt
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlyb3LYACgkQAVBC80lX
0GwHBQgAkD7cBTS7hUYKD4hoE9pLltdzovpDBdWdZKVXeTrMd4i9T4g2HgavU5Uk
f4dHLMdvhO+nY1Snl7B4bra43+qbMLNnwYvXEF/Q8Atn6Hq97AqrZxV8MycQSu3x
G6mfUFobNhy+UkDPPaPXMO1B1S0L7wB7bYNw9x48FBwtq6dYc0HyiGpj4FQh/LL2
1oZSnS783Yq0zsZSatG6OwohHQ0MI7U/IpvZ5MQEAyHcQYsOU4GlYGfifivuPzdz
sS+I71YNZl1Y3X2vwgOhpzkrY1HrZoJ6NpFDqCKu1ZPtsXfM75I6MHQP8ryp2E3S
YMI3wa4qLVpPekQ18aHR2BXqZ2UEHA==
=xMme
-----END PGP SIGNATURE-----

--Sig_/NyVSC6m2iVyJYjsKHiymQmt--
