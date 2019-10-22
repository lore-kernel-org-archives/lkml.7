Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C92C9CA9EAF
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 00:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E7C0214B2
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 00:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="W8C2Bseb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387429AbfJVAr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 20:47:58 -0400
Received: from ozlabs.org ([203.11.71.1]:58757 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387404AbfJVAr5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 20:47:57 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46xvxQ6YpBz9sNx;
        Tue, 22 Oct 2019 11:47:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1571705275;
        bh=WOPh2oZi7opzkS/Fh2BInhUc/0MNYstmOLktzbUmneY=;
        h=Date:From:To:Cc:Subject:From;
        b=W8C2BsebC9f19xnbvMQDMWVXo/lQ5s1s8Alca+5HsZiHD7Hd6SqMvjH5thmrQRfrB
         VoZHDbqDhbxyfTSmLCkikr8a5vlUaTWPWqjAi7RO/jGn8ZNGwvLJXH9Vtnwx4mXr8A
         sx99TTKrjHFdPR7Ffo5GqbKV08vJuXU7rGXyahQSypPLufTdT8HLxEH1OClUno45eQ
         nkw/jhYu5A1sCyB8OIOuMRHbpsXb0dFkLnHaNeVuccRRFnXcYdwa2eVJM2U39zUOoU
         bKjHgjJl+W+SyXeyENgrBCR96sV9fCnNbtLhFHJ55/u61LVo3QFwGlXuBt65WoKy60
         E8etV5JeBJFMw==
Date:   Tue, 22 Oct 2019 11:47:37 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>
Subject: linux-next: build warning after merge of the mmc tree
Message-ID: <20191022114737.0fd6211c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/FRxtKUTFHLLeKOmOpCRJFTw";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/FRxtKUTFHLLeKOmOpCRJFTw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mmc tree, today's linux-next build (arm
multi_v7_defconfig) produced this warning:

drivers/mmc/core/block.c: In function '__mmc_blk_ioctl_cmd':
drivers/mmc/core/block.c:500:6: warning: unused variable 'status' [-Wunused=
-variable]
  500 |  u32 status =3D 0;
      |      ^~~~~~

Introduced by commit

  05224f7e4975 ("mmc: block: Add CMD13 polling for MMC IOCTLS with R1B resp=
onse")

--=20
Cheers,
Stephen Rothwell

--Sig_/FRxtKUTFHLLeKOmOpCRJFTw
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl2uUaoACgkQAVBC80lX
0GwF+Qf/d9XDmmZd054hStri66HiXZDkInsBYHA8odNqGwvB2BuEXfy6a7u9Jm1L
REuCsUDBvHiCPDlCgTMF2Wci/UIgF8x1rlqeFmYP5UFulFiYKdXE3Vbg12NE8h/C
TImBSQ9mjuqo+0zQYGf3yGPJqhAt1fRkFQe0DuN/gh/l34TXZi8o8j83TriULVRN
KhYYU/ESEJEwpMR7mlSA9wt+RcsJy8N/FCIM5USZSPBzsQ5RqWgxBs/mAPYfSARO
KUNuQZ7nmy4UyWMNr1M4xsnTfvrErCYUuwZ+Ai7hhtQ2r3zZCDzFTUYsJe7jDNAR
sSlfRdPe5JfuwDJ7PPMbDQg5raFbMQ==
=t5vp
-----END PGP SIGNATURE-----

--Sig_/FRxtKUTFHLLeKOmOpCRJFTw--
