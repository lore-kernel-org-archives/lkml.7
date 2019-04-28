Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE53BC43218
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 06:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAEDC2075D
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 06:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="a8fIWFJl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfD1Gtz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 02:49:55 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:53033 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbfD1Gtz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 02:49:55 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44sJLl5C4Gz9s7T;
        Sun, 28 Apr 2019 16:49:51 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1556434192;
        bh=3bz+rh2Bk1eLs6riuj4kHskPs6kRc414sklJXiERsl4=;
        h=Date:From:To:Cc:Subject:From;
        b=a8fIWFJl+IcO30TJdt//9JPg9Np7WTQyOGQJLappWW0loiR66GWMKDai9JbHY1DKN
         eA3zOGReSuJHZTtLpeAUioCcbPrCkD126mUlsMNuVYB58q+WHAYNynrFoaUn5/WNcC
         vWkatl8BronwPWBkcwE2sOu5FzoYYF2A9jlO76WcdPYEN6TffU4kuWxhB6/wBara1m
         uhcHx27sPq5+hkV1PJaukzjg8VhlYJ7DE6rGipyXgFZIuczg2KkHK9a90lRXmVoc0e
         EDSqPVu0fG9rrc1u7Zk3qNuR6lsR79WqcW2BTHbYuNdYzJ1pE7rJvhhPFwOv28lGX7
         Zr+hKew5/t51Q==
Date:   Sun, 28 Apr 2019 16:49:36 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>
Subject: linux-next: Fixes tag needs some work in the net tree
Message-ID: <20190428164936.51bc0e7d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/v3H7.PmPscfamGqzgt0jHF_"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/v3H7.PmPscfamGqzgt0jHF_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  c1c477217882 ("l2tp: use rcu_dereference_sk_user_data() in l2tp_udp_encap=
_recv()")

Fixes tag

  Fixes: d00fa9adc528 ("il2tp: fix races with tunnel socket close")

has these problem(s):

  - Subject does not match target commit subject
    Just use
	git log -1 --format=3D'Fixes: %h ("%s")'

Did you mean

Fixes: d00fa9adc528 ("l2tp: fix races with tunnel socket close")

--=20
Cheers,
Stephen Rothwell

--Sig_/v3H7.PmPscfamGqzgt0jHF_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzFTQAACgkQAVBC80lX
0GyxsQf9FwooBMbY+hUtE6GYrJ2iZJy4z7QmdSBeYjMdthpqjWCffwtAkYgNpZVF
Q/FKbenCjXyz0bKaYJTtTb3Ejql6HMJj6bauW7s68aELaKcFsntl8aMtufcyAxEX
7ODiZ9b6RJOF+7h+0tWb7aLAiXlOrnUFnihuWkhNnUjlj9QVguQCnHQnfvcjPgCc
dw4jJxVHp1NXKVz3Dw7vFeWdS4B/eBUqeALnPCmSHZewFLMvnRNHNgCQhGXP30p9
bxLIkzm26ejBjqFP+RyuwRV5TkdbYJf7BCQ2Rvwg/sMOUm54MW+3q9/xted26d0N
tGQYSkzm0sx2kYftlX9fxqpr8LeLNQ==
=nd0u
-----END PGP SIGNATURE-----

--Sig_/v3H7.PmPscfamGqzgt0jHF_--
