Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ADF5C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 02:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E65052075E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 02:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ESaiZxdh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbfC1C5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 22:57:11 -0400
Received: from ozlabs.org ([203.11.71.1]:45509 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbfC1C5L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 22:57:11 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44V8fX1Zctz9sPv;
        Thu, 28 Mar 2019 13:57:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1553741828;
        bh=IS0vyJ3KVMiVF4Mk+63ubCyk8S/SEYrA+2xZSwD+KFs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ESaiZxdhyX4ESuuuO4F55GkDkwK+vxlzSQ9NXq5QrEeXj7hY5aKSkOzZ5rcDD6AKa
         N8J03FOvowPkLpq/g0X0cahF43HhrMaPMoLqxc8Pg866JyS/4MUyxkIGTZrBcqTyCi
         Tq3xdCuTFC80nv3+uFVxWZrX1IgAQn2jJRhOplJZ/WHF76jk0VuyQ74NLDRVcrOCzv
         gPuuBz+q1FEIW5bzZSCvMHa4Hnc9DSkPatVNEP8ejeuD4zK3hhJ86l3B0FQ1N1F2wS
         5D6SPqfePkKksCs0xMCoffouJ7HuOixmq+TWfbe5gxg8ovXLr6yQk4MJKNpI+rcgHM
         sLLOZzYigjoYA==
Date:   Thu, 28 Mar 2019 13:57:07 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christian Brauner <christian@brauner.io>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the pidfd tree
Message-ID: <20190328135707.01e9368a@canb.auug.org.au>
In-Reply-To: <8EB36115-C5EB-4469-94F8-1D3DF1653ADB@brauner.io>
References: <20190328130449.1b6334b6@canb.auug.org.au>
        <8EB36115-C5EB-4469-94F8-1D3DF1653ADB@brauner.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/0J8FOeA2Wenpez0ong.TDt1"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/0J8FOeA2Wenpez0ong.TDt1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Christian,

On Thu, 28 Mar 2019 03:28:25 +0100 Christian Brauner <christian@brauner.io>=
 wrote:
>
> Sorry about that. Should be fixed now.

Thanks.

--=20
Cheers,
Stephen Rothwell

--Sig_/0J8FOeA2Wenpez0ong.TDt1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlycOAMACgkQAVBC80lX
0GzvKwgAgmTIQvH5DXVAUunFKe7jVjvYr7HYZKirXQX9umSGA3BlaQTwcVhK9vg4
KwesuYsfYvmR5D5rh5xyWolPr7JorOe3WejuxCBLs0YbCpNj7P+00WfWk8/AQJbw
AJOPtxRf7UksdDZ0ZmszaZ4ginVNsoHCvECeodn/TNq30+sJML3r/iIFP7CudrsQ
4IVFDefG5qW1P/SmAF9NHFfNsNtTVD/dG3PJxpEZ3nFO0utp8UXXI85n5xGOp/nR
wW9EXWIrmyx4ok7/oQQuvNo8cgy41gukCwWxsqFxd+JkYk1r0wuNTcgG77+YR0M4
DUrA4feFqUe7NRE0wu0eNw8NCi6cbw==
=H+CL
-----END PGP SIGNATURE-----

--Sig_/0J8FOeA2Wenpez0ong.TDt1--
