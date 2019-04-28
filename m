Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8EC9C43219
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 06:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93B73206E0
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 06:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Hzmtdav0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbfD1Gy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 02:54:59 -0400
Received: from ozlabs.org ([203.11.71.1]:49925 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbfD1Gy7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 02:54:59 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44sJSb3bj9z9s7T;
        Sun, 28 Apr 2019 16:54:55 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1556434496;
        bh=A6bzTLeDkqh9m8mprdzIoUxCicGRLgKczzFBK9Wrbdc=;
        h=Date:From:To:Cc:Subject:From;
        b=Hzmtdav0XbCum0gmCkcz08agHMl61rEZJeIenCMiOAfQ+7faqZxBoUGj7G/0h5Z0g
         Srh+4HOv5PkzXTG6ksgESex7+8ePwkGnyfbT8wVGiI78E3/lP7FSE1pDsAJu64GyHL
         1WB1JA2yqhbPXQ7hLoadBqR/iCam5/bOih3rV5gB01iY4don75W7maz0JfoEqAJiTk
         sdh6E3CZUH3NtS2ihVIM0eaZVdhQzW262Bczn2NrGITrEAm6fLWV4WbGX5hhmeUPJ3
         Z+GOyIjHr6DCtZqoqV8rCATQG3ydkgS8hvE+M17EwvY8t3Io7TBv34zbMDGPr/S9mT
         3Mrcp/T9uGVDw==
Date:   Sun, 28 Apr 2019 16:54:53 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>
Subject: linux-next: Fixes tag needs some work in the input-current tree
Message-ID: <20190428165453.30c1dff0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/sfDooC91NRA3T80DjEs1=nR"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/sfDooC91NRA3T80DjEs1=nR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

In commit

  3a349763cf11 ("Input: synaptics-rmi4 - write config register values to th=
e right offset")

Fixes tag

  Fixes: ff8f83708b3e (Input: synaptics-rmi4 - add support for 2D

has these problem(s):

  - Subject has leading but no trailing parentheses

Please do not split Fixes tags across more than one line.  Just use:

  git log -1 --format=3D'Fixes: %h ("%s")' <commit>

--=20
Cheers,
Stephen Rothwell

--Sig_/sfDooC91NRA3T80DjEs1=nR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzFTj0ACgkQAVBC80lX
0GzPLwf9EC7TLYHfLDgW4R+8XVrxnrDBrWNxZW0de6ZQJDPxlP9rIenfapJrWrvb
gsx4dZeL42zKn9s/EU0YyuG/CZUbq/HaMl7vpt0Fc6beUfJIlza5UzdhGexw4ihL
E9tMvql2w+rj8MYrUEy1FKSuI5tU93yL41djPFaiqS07E3a87fcGESlgOqovI8RE
eJqoA5ebF+UbFfhKgZK7oid1T6kJlekuad/OqQ4tIhlsS7ht7j6vbCUZFtl5D7Jz
Wf57Ag7WMm7VWpoA7ZrwG4RkV1fkkb8S4agofPvnN5Um8gdUXAXuLZi3YkXAqOaq
PrsBQb+jdQAuayM3bTakovlQCyfjkw==
=oJFM
-----END PGP SIGNATURE-----

--Sig_/sfDooC91NRA3T80DjEs1=nR--
