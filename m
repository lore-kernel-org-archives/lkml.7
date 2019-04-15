Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4879C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 21:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C8A22070D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 21:36:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="lk8G5Hpo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbfDOVgS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 17:36:18 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:35795 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726696AbfDOVgS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 17:36:18 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44jhdW33PGz9s55;
        Tue, 16 Apr 2019 07:36:15 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1555364175;
        bh=PCpDUQIhTLPc64Le1pYyd+OyOJLFfb7P4fKEDT2FNPY=;
        h=Date:From:To:Cc:Subject:From;
        b=lk8G5Hpo4JqYxUF4hT15I5m6ZzxXHwziqfZF7cPwLQgWXXBO1b+hsvJeyuwZFY6nr
         JZopfGQKsrqWyS5NMfy1doRITun8us+xyaKhQdG+s2wzHkur5+BVl2j59NoU9zNVrq
         e61g7dZDusJ1nrOfBk/YKxdKw/z2TgrVCtrPNu9oA3M8r9KLuSZCo7nHdY80s3SLlb
         a3b0BlyTp2uhesvlMUQqh3MfN/vEVReAnc9JwxRU5wvXDNdziPgbA+vpHG9kvpVygD
         IsBNF0EdUT1UkMIMygYS9KQYFpq4jQB2mrLHLWobgMcYVSiWZ9gouOxwGYZveCEegP
         Ia0tFaHXJMmwQ==
Date:   Tue, 16 Apr 2019 07:36:14 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Benson Leung <bleung@google.com>,
        Guenter Roeck <groeck@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the chrome-platform
 tree
Message-ID: <20190416073614.01839443@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/EwWYngZQNSLZUtxQOYkQx_3"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/EwWYngZQNSLZUtxQOYkQx_3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  d9a3f2b2a31b ("platform/chrome: cros_ec: Add EC host command support usin=
g rpmsg")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/EwWYngZQNSLZUtxQOYkQx_3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAly0+U4ACgkQAVBC80lX
0Gxxswf/QtcpM3im9DujvjbyoDWGUzkOBVnT/imefiUR97ksjdcje2KtPDcrllb4
Re/ya5OWAv3ENAPNjI+rrjG/KPWvkp3jKbdzEO2cQ6NEKbTTQO7tqARgjK0YtA0T
s/8Gkqvqfy8fLiaKSSx+tn9fcvGKGMGaq8HimlZwXYBaY8dBWpj2dyC5KQXcOH+I
Vm9LSUrD4L35lDmJhjJX2snN7brCnux5Vn7GimKolnARh4j/l4gA33sUmERqPlBq
hzDABIdQvOG4lj+F0KhrD9s7hhyLNUk9YGtmaeEYL7RpphV5NtL7+4qwEot8Ouwc
wgXRUHDBxXHEeheEnOZR1Ll2jgbrQg==
=dQsJ
-----END PGP SIGNATURE-----

--Sig_/EwWYngZQNSLZUtxQOYkQx_3--
