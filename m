Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B69C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 04:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C2EF2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 04:40:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="GS4pjnR4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbfENEkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 00:40:10 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:59485 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbfENEkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 00:40:10 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4534jg2N0Zz9sBp;
        Tue, 14 May 2019 14:40:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1557808807;
        bh=Yc6CnsKVV9TstH2Vl9g/5SEIYi+B95IbdtJuychAYjQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GS4pjnR4r5uBPQ3jyIpXzI49JWnhMnqaTL+aOfPNtniZ8KbrB5vQdzDiPizsUbeIk
         tb3jnaDBkIr6/5tYrnF6iAWjnF9lCDkFuOhFD9OZnwPNBevxZnOrFbbRpPcyFtCgym
         6WqwGo4BX0YgvWpyBGyeWWywEij+MdZRFUPfqKo82wt7B1dFuJJb8HbQULh6VcTva9
         i6akbyi771Cfx5q/Sv3aeBbxS3RyeEj0CD6JIHuC4F5/MEW/aEPW+mWfIycjR8nXPO
         12aXYgCf2CbSpl6OizBOGg6HtO3SxUWT5PxRP2DjU1yw8V40uC2/lEdh0UK15h3t7L
         9cuyfxJvXIKtA==
Date:   Tue, 14 May 2019 14:40:06 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Eduardo Valentin <edubezval@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gal Pressman <galpress@amazon.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Talel Shenhar <talel@amazon.com>
Subject: Re: linux-next: manual merge of the thermal-soc tree with Linus'
 tree
Message-ID: <20190514144006.60df13bb@canb.auug.org.au>
In-Reply-To: <20190514034409.GA5691@localhost.localdomain>
References: <20190513104928.0265b40f@canb.auug.org.au>
        <20190514034409.GA5691@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/2EkBLwMj1P8kge3EWnSyVJG"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/2EkBLwMj1P8kge3EWnSyVJG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Eduardo,

On Mon, 13 May 2019 20:44:11 -0700 Eduardo Valentin <edubezval@gmail.com> w=
rote:
>
> Thanks for spotting this. I am re-doing the branch based off v5.1-rc7,
> where the last conflict went in with my current queue.

Its really not worth the rebase.  Just fix the build problem and send it
all to Linus.

--=20
Cheers,
Stephen Rothwell

--Sig_/2EkBLwMj1P8kge3EWnSyVJG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzaRqYACgkQAVBC80lX
0GxmzAf+OnMWPR/PLV6gW4+7P0DgN4H8+d6uMwOlG5XPsTAqH7IwFFj9HQNjtsRM
GNMme0P2d3HRc9M9cIUAkZca29knRKS6lvE8QJPna3FDv5ma3T0Mjt5QE0EGCber
Z+mXUPksD+qgyZ6TyOmj8v7Ih+38+4wzMRzW1DPF4bl4feyO6G4m3Lbcqg7EqplS
3Peo7QW1s/l0vDJk3Ai6h7D0usNpW2ku8ba7geDPK2CyyaS9dWi4v72s2f2lt8M/
hT2PL3XrM/qrRzR7qC0+V2T6SLT81F4J21hUNRjGndP7yziybuHG2vLJu0lWQDjg
3CMRX+RT3RDRV1/6MfPmB466+o2/0Q==
=8J15
-----END PGP SIGNATURE-----

--Sig_/2EkBLwMj1P8kge3EWnSyVJG--
