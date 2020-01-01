Return-Path: <SRS0=1Df5=2W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD4AAC3F68F
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 07:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84B912072C
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 07:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="PfRxVU9u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbgAAHQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 02:16:31 -0500
Received: from ozlabs.org ([203.11.71.1]:47605 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725790AbgAAHQb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 02:16:31 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 47nhLc08Xmz9sPW;
        Wed,  1 Jan 2020 17:37:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1577860680;
        bh=93Fnsa30PklcDpFSSNiGRs2LS3a6XWqJl1XuNw+iCbs=;
        h=Date:From:To:Cc:Subject:From;
        b=PfRxVU9uKUIksJWSdwOWYmFbhLVwm/JBTmRtq4zc3D1erXmAK3MUU5xAFqAd8tcFv
         wRbACeBibuhC8SQfQFa0BFKTGiOrqcZOFmzFNKtAUNQ94jngNZ6hYmdwWQ0KeYSqMB
         L3/pQRlQmTrznsySzoSMGO74IoZ2xcM5f+gAlPrPwmZLjzIoUqE/d8MqJOHe+9NChz
         XkwCc1+2PlergTqvC7LZFJXO108Pm56SwITV31HByIWdGTbzUIjNJrDXmEslYiWyx0
         FlphcWOSMncvpdASrB+/Tw+kkAJXKC29h/KYKO7zBG2rdJ3X0lFn3Ps2LWNy00M4RO
         qUgs8iJ88kDqw==
Date:   Wed, 1 Jan 2020 17:38:01 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the scmi tree
Message-ID: <20200101173801.2e9a1758@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/7_XYvOjSZ_sYAbguaP_I6MW";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/7_XYvOjSZ_sYAbguaP_I6MW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  75ee475c4018 ("drivers: firmware: scmi: Extend SCMI transport layer by tr=
ace events")
  60542ecbce11 ("include: trace: Add SCMI header with trace events")

are missing a Signed-off-by from their committers.

--=20
Cheers,
Stephen Rothwell

--Sig_/7_XYvOjSZ_sYAbguaP_I6MW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl4MPkkACgkQAVBC80lX
0Gxbzgf/RDclKyAOMExaFHKCBl+P5RpJySrigWUl6112IofAr0oPjsiznWaCp9Mg
oN+dbfI4supoUQP6yrlIglCA72E3wlzKAlKxepKgqq/PvTT0MXvs2dWyiz6XWFps
MtkTH14n7nEYI35ypHCAY/bkOvrl15iUdop9hzvfVkiE2t+ezFeywrvJAxKqX60g
zMT9e6kh8iGRoXRYyuAhBdey+7SsSBtxGsDuqQsVBomKR3UdOI5XxILELZ0DuMII
IUXxCFb2Ar5NNHbboxTfVWWUnsIDM4PznD2XwC+0ZMboDCxyXaY7j82068OSOqPp
Cm3g5/DpSKap7SmxBVHlM28Dkei8pQ==
=Spr3
-----END PGP SIGNATURE-----

--Sig_/7_XYvOjSZ_sYAbguaP_I6MW--
