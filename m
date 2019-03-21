Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF564C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 23:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F127218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 23:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="PD6DSjC2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbfCUXFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 19:05:23 -0400
Received: from ozlabs.org ([203.11.71.1]:37197 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726695AbfCUXFW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 19:05:22 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44QMnq53jQz9sRy;
        Fri, 22 Mar 2019 10:05:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1553209519;
        bh=b6q639ISBNCc22gmNm9lf0SV6i81VMdLnismz4oV6As=;
        h=Date:From:To:Cc:Subject:From;
        b=PD6DSjC2P7899C17EjlxG+TpJ5fchikz5z4eLi46RUYoOO7TLsQotXMJDrw99Mxcs
         Qd8N9S3SiB8SvNV/OrL/5K5zft5Xpyy/E/F9QElImjyRjCL/WNOp0Cmwkgc2wlPZxC
         y5WCblTh1UuGfzXxx3zEh1ERp5L74I5O6l3+wj9jz8aP+uceLAG9J+uHNlYBSrPfYF
         CJBVLm83dj6nJ8K+yCANMEm40PK/dMThxgW54vsy5rfDNbbZOnSj03VIzZC94e8+wS
         7XA4fjJnf3DmafQGCRzL/1WE3IrkyX7slEC43wlNW4kNUJEnSpPJt3+uWsc+77PHcp
         GuPWP2mwHFbxQ==
Date:   Fri, 22 Mar 2019 10:05:12 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Scott Branden <scott.branden@broadcom.com>
Subject: linux-next: build warning after merge of the net-next tree
Message-ID: <20190322100512.51b5ea25@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/g8GA6XQIB7jGLEa/q1VShjD"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/g8GA6XQIB7jGLEa/q1VShjD
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the net-next tree, today's linux-next build (arm
multi_v7_defconfig) produced this warning:

drivers/net/phy/Kconfig:276:warning: prompt redefined

Introduced by commit

  17cc9821766c ("net: phy: Move Omega PHY entry to Cygnus PHY driver")

--=20
Cheers,
Stephen Rothwell

--Sig_/g8GA6XQIB7jGLEa/q1VShjD
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlyUGKgACgkQAVBC80lX
0GzxTgf+L6z3IEpUU+OwKxIsoPP98Q2F0PNUEsrr5HJNL7P1tTaet384dgE6cGlp
zoJwp11YF1Bwjy+yIAfYeJM9HjpWcMjaCK9fiJtzCIDYrKBGaRStEcTEZCAUibF7
rmVndLMCf0beLV1LF7HiYa++OY+X6LLaC0eUfyAdRMmBB1tyEffipMQCJqubhWaa
iMzcK4sWknlLC3rGx8OeDNFqz4Ero9Vh9QsUcymXko8YDWcs4qGYDJiTHD/I2HEi
fLOBbKuzjfWTzJx1t1GRPtFAg541sZ3lMLcuTNEuF/miIMtLJW8VoYoes1nfbQv4
g5kOTuTKAMCBX+f7LiDRUqMU9YJaVA==
=hqRW
-----END PGP SIGNATURE-----

--Sig_/g8GA6XQIB7jGLEa/q1VShjD--
