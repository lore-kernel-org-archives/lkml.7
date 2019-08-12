Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C88AAC32753
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 10:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 937AA208C2
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 10:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="mQwxLC2H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbfHLKGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 06:06:13 -0400
Received: from ozlabs.org ([203.11.71.1]:57991 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727409AbfHLKGM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 06:06:12 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 466WhK6QxWz9sN1;
        Mon, 12 Aug 2019 20:06:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1565604370;
        bh=iqB1LVYeaEpnmcXmOoPdhBF8HxreRVomAaxJjtwya2E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mQwxLC2HNy7DVGPJkkE/aOR73lZKPaOSCqqoERPfR42rl+P9XQcbouR2puhm1Fqey
         sW3vGdRuOvcOf0nqFH0NvSLvVDG8g+2vjrclHGwmsOogqRSSyxALjBqJBOTIoCKy6P
         2+nswUn3rpjGU6o+nXTbiXorDcPTy4yAxXZUGyxVnsWXCvY/FuV7Yhq+LTnbyTNFIw
         Wk56BA+uquL+8v9i8FjY5mt9J9VWsAELGeiSBo0j98ubRb0enrI6/ummMRI4M8WN+w
         siizPG6tqj30bw1pAu6u+q48ZIeP0GDXdos8q517z4q0yXJy6989xGqCUbvRh5LBL3
         5KZC66ef1pZSA==
Date:   Mon, 12 Aug 2019 20:06:07 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma: ti: unexport filter functions
Message-ID: <20190812200607.6ac1ab09@canb.auug.org.au>
In-Reply-To: <20190812093623.992757-1-arnd@arndb.de>
References: <20190812093623.992757-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/0CO=r8YnSAbj=0kxeaVWCKS";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/0CO=r8YnSAbj=0kxeaVWCKS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Arnd,

Just a nit.

On Mon, 12 Aug 2019 11:36:03 +0200 Arnd Bergmann <arnd@arndb.de> wrote:
>
> The two filter functions are now marked stable, but still exported,
                                          ^^^^^^
static ...

--=20
Cheers,
Stephen Rothwell

--Sig_/0CO=r8YnSAbj=0kxeaVWCKS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl1ROg8ACgkQAVBC80lX
0Gz1xwf9GGNXlG54PTj7UkR/zWsjuxUMRGFmp0x/w490cWeQK+q1uyRqR9/etbqm
/yjR8pq/AzUAW3pxQWimCOZzZhbSEVy2cDr5uJEM/DYinYoU4aK63i8YPP4ZCcvM
lVwIdgqfL+01TpT7QEV0io5NWvGUVTgNb58Mprb3f7CyE7Idp6N1K7Ib2k29GIkw
PvsxGCGEkY0XSjEKU1jfapRf6cbck4U9icWtAinJUjR3n7mi2YCk7MWe3XHnFkcj
rpR6EeF+HKJAQ0rO87clq0ICB+1y5+QFSPiyRMeIKN6T6Izy+3d4fh/lOmu53sVb
TImghilme58cxoToyDEvVugFktiUyA==
=KUm0
-----END PGP SIGNATURE-----

--Sig_/0CO=r8YnSAbj=0kxeaVWCKS--
