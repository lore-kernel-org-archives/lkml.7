Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 212DCC10F11
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 00:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E331720811
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 00:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="gDxs7DGb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728747AbfDWAvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 20:51:42 -0400
Received: from ozlabs.org ([203.11.71.1]:58435 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726421AbfDWAvm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 20:51:42 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44p4dk5Vhkz9s9G;
        Tue, 23 Apr 2019 10:51:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1555980699;
        bh=aK2PjpST5SMLoeC4ht4B862LI4uMndfMEvlrS+2XoiI=;
        h=Date:From:To:Cc:Subject:From;
        b=gDxs7DGbBV8S36jYD6HORaeD2RiqZr3KxJNvW42cSHXhsDPI2nuoCK0hMMNaQDTzj
         zCNAa4MQWUAxd5W1yKXMFm7H+eV4VmpdOUl/GFNonPRn1fueIWzH9zVYCuY724MSag
         Cruw0PKs21THqxCKgoqLwSG/ZPSEwT8ExebRNwOwXnYk9j3S0vDRUNxMTV0ACWiKO6
         2oq7qjSyS96w138eXLf+g4qj6uUhasQP4UXXAgGyKqpOrfUAVoFypkJJzofL0mmUM6
         yKsNe1QgniY7ePH15ymV+iFqEYVJWhnSkKNOEzk7+eb6DF5Bap8pCLnE2Z9UOAnQtV
         JjLvnXwm01Dtg==
Date:   Tue, 23 Apr 2019 10:51:31 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sean Young <sean@mess.org>, Arnd Bergmann <arnd@arndb.de>
Subject: linux-next: manual merge of the v4l-dvb-next tree with the v4l-dvb
 tree
Message-ID: <20190423105131.7f460991@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/UgZn/0eMWNXqs_CbU66YxT+"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/UgZn/0eMWNXqs_CbU66YxT+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the v4l-dvb-next tree got a conflict in:

  drivers/media/platform/Kconfig

between commit:

  63604a143fe1 ("media: seco-cec: fix building with RC_CORE=3Dm")

from the v4l-dvb tree and commit:

  81527254e151 ("media: seco: depend on CONFIG_RC_CORE=3Dy when not a modul=
e")

from the v4l-dvb-next tree.

I fixed it up (I just used the v4l-dvb tree version) and can carry the
fix as necessary. This is now fixed as far as linux-next is concerned,
but any non trivial conflicts should be mentioned to your upstream
maintainer when your tree is submitted for merging.  You may also want
to consider cooperating with the maintainer of the conflicting tree to
minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/UgZn/0eMWNXqs_CbU66YxT+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAly+YZMACgkQAVBC80lX
0GxNYQf+NVcWPMWliyvLuqJadx2S/9l3vjkMy8nHmyxORStdVA0URBMOmDxc8QhN
gFdALg3DoJM8RFIEQoBjwa+hhLUT3F66yHhtY/u7hGG1609nYlsqknc4L4mC9H2Y
EsDBpLaoQE+fVsmYjIjP8Z4FxQ77/WB37Sz4xyEpt47WffuVxB0axXjyLCBwJFCQ
Y6w0xnUQKcqqd6Mwt8LlzM1TrfN5bWwYM+WIeEW2MWFmLuhI8x61hl46sNksKN/O
NScctplex4HMOTXtlRRD3oO9eqOWR3z3Qk5dKdehytiGHiFX111ryunOVK61r0Y/
PtZTTN8P+aHhYX9SgCJfwqjo3cvA2A==
=L0ta
-----END PGP SIGNATURE-----

--Sig_/UgZn/0eMWNXqs_CbU66YxT+--
