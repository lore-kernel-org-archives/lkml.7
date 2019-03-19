Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A65F5C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 05:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6468A20989
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 05:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ZT8dt1jw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfCSFUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 01:20:31 -0400
Received: from ozlabs.org ([203.11.71.1]:35417 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725931AbfCSFUa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 01:20:30 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44NhG264N2z9s7T;
        Tue, 19 Mar 2019 16:20:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1552972827;
        bh=KPYZAMDGoyY8dTeHLC5gTm3HzqeP1v82+qVRumDS2Rc=;
        h=Date:From:To:Cc:Subject:From;
        b=ZT8dt1jwjPWny2vJDrnPL859ViAYBRgNcGztCkqETptjMPoMdTTky0Ir9Ou3N6Oyy
         TFna4qS+5wtk0XfM6sb0Y87+hycwUisyBH1xDQxm6KS6ERWSoogSFDe2RCwMKVeTVE
         7M/YjjejSb5zOZRfdxaL9tOXAkYqDYYk+0edPNIIc/gj9GAAuy+NkgCvQIp/Q5aAtv
         BA202/WRt1b4WBfaX1Pa9ZhUKwo/J2fwsaQGpBw+DKiN+3UVOXhh5JFYJ/BONOUjU1
         52ZxTc30VbCsrw6zbJ/+EpmujzbyTNqs5ep0lwbsKl5hQXWwSi6xttyDe5HW3C7I72
         JhPHGUoGU8lVw==
Date:   Tue, 19 Mar 2019 16:20:25 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yoshiki Komachi <komachi.yoshiki@lab.ntt.co.jp>
Subject: linux-next: Fixes tag needs some work in the net tree
Message-ID: <20190319162025.3024a5e6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_//kWFd7n=Pi9h5i=LkzhdcLF"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_//kWFd7n=Pi9h5i=LkzhdcLF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  18bed89107a4 ("af_packet: fix the tx skb protocol in raw sockets with ETH=
_P_ALL")

Fixes tag

  Fixes: 75c65772c3 ("net/packet: Ask driver for protocol if not provided b=
y user")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_//kWFd7n=Pi9h5i=LkzhdcLF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlyQfBkACgkQAVBC80lX
0Gz/Uwf/QM4t34PddhPvfqKsRMftReoe/YZZSAT1uCfk0TbLDi+MCm3oi5DclJM1
ZUqMgye4kMZZmkH6lmzssW0d0wNrPwVlxo+Cd8lsXXPmhs7vsFffbTrAXGMbGJ8V
L3oO4HogPYr6mNnhL8XKTBiO7luNMM/RR4ImT3ZPMgxOWTi2jRi54GklS14/tvxn
v49o259YpVT2orZpZ/Foo15nUGomIZQpCAUI4MZQFtHDhw5sm1CryB6dQ6ANeyyC
NeAdqACSeylKrQnYAl14UtmEdi1oFJ3Ax+kSwj9Kx1icIAIoiXvqbc4sgA5gQnUG
37uMZguksrQy3C/wM1gb+SZb4X/Wzg==
=0CFl
-----END PGP SIGNATURE-----

--Sig_//kWFd7n=Pi9h5i=LkzhdcLF--
