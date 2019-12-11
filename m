Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E5D1C2BD09
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 03:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4051020836
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 03:21:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="HmRTRhxc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbfLKDVE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 22:21:04 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:49031 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726687AbfLKDVE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 22:21:04 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 47Xhz15Fchz9sR7;
        Wed, 11 Dec 2019 14:21:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1576034461;
        bh=lltzgu2HV7j5rxYl5lhex07J61NitzEC2ZoE4pCHpIg=;
        h=Date:From:To:Cc:Subject:From;
        b=HmRTRhxcZ9grRCSEYT2/9DRrMDDdddr0z1TdOQtRwQOw9zmNu9Ix9dhNSthsEKFnu
         Anvpom5GkRcAEwQoNDc4dPEULUz5QwX0LkqAm02kHtUUZzR8MSJM1Amf2YonnDImrt
         /uk6uNIHEaaHltb0+Bbm1gVT1+xxE6HNZHc/6ypjvf+LYa2LM0pHesTDwAWG9SO+FL
         8jzKlZAn0book0XDxuEFc7x2/UOtqWxXxqqwi9LopBId7sOxFKLE3cab3tWUgnPipv
         Qzg+hWK5bC4XiMPrpJyDbKO3pTOpbrMoyE/WfzZjiZtDnir0F5ajXeZ4+qPoZt2Crz
         AH2gio3AJgdfg==
Date:   Wed, 11 Dec 2019 14:21:00 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the cpufreq-arm
 tree
Message-ID: <20191211142100.423ef8b0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/YJZo=hBYa+PDgd8yq.d8AT0";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/YJZo=hBYa+PDgd8yq.d8AT0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  dfb3f45d17b6 ("cpufreq: scmi: Match scmi device by both name and protocol=
 id")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/YJZo=hBYa+PDgd8yq.d8AT0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl3wYJwACgkQAVBC80lX
0GyUAwf/VIgHycApPnRen02Fqa5tcvRjO4MwWBJn5AWUEM01CHmt/u38yLFT5r5U
HV/zAvol5YYgskpBh63MSpzIrlqdJkQ19hKlsmvqWiaCBzN08YLht7fuy9QBf2gU
HPu5aLY+06XI22pJas5EF9nI8c7BDrsvdaOsafCT+zZ1kyxflAetJcdU2nmKjlw9
pqPsB3IeJ/dBJDhSGgdrH93uNmMN8NGGDZJqmhWxqHiiSwCMz0XFzmUwJhL8EdIw
QNeNiCKPxZfTNUonsJjgIAY2dkmQpEzTVQ8FWU/iUYbXdwuNTrfind2OeW8jopp3
Kar68MufKyNMdmia0EsEfj3Xu1usnw==
=1Fr0
-----END PGP SIGNATURE-----

--Sig_/YJZo=hBYa+PDgd8yq.d8AT0--
