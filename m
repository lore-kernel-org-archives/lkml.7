Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 061EFC10F13
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 00:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1EFC21841
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 00:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="RKOTXh7B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbfDIAvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 20:51:42 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:48417 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbfDIAvm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 20:51:42 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44dTJB5yKlz9sPn;
        Tue,  9 Apr 2019 10:51:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1554771099;
        bh=fHjfEy3pklASv1IQbQXsPeR+9+ivEYzZdggUyY5ttOc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RKOTXh7BS0MrzrKHfAopKd1WH3rZJFRrY3Ifk5UaQaBlyNdkzgPS4LffKDz7I+X0u
         KwTm4tafb5zXWNM2Tdh4k+hOwU+weeRPoZHdXyAU6xrIxvJBEa/1VtZYqdObgPsO7U
         5uMQho3C/mO8pUD7hZcu/Binmd1CEtd/Lf/DX30qg6ifWk1/+Dal28bTBdk0T7LlQw
         z8FtxVSEUjpvyoIdQgn/6OK+NliaVFHkEHGBhZ0RoeXnXlnukpMbTiFpDztN9E59Hv
         JHWISqAapSgJ5C6tqDqY8Q9Y+0J87mWyEjXMyPw8LqoHTrdU2mqRV+bnfZbsnDOW6K
         dnzBP/Zz6Ji9g==
Date:   Tue, 9 Apr 2019 10:51:38 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: Re: linux-next: manual merge of the kspp-gustavo tree with Linus'
 tree
Message-ID: <20190409105138.6b202215@canb.auug.org.au>
In-Reply-To: <558944e8-5912-dc7c-637c-61dc892bae75@embeddedor.com>
References: <20190408071731.6bd422f3@canb.auug.org.au>
        <558944e8-5912-dc7c-637c-61dc892bae75@embeddedor.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/6Hj2W9W++m+9TWR4oeugLQO"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/6Hj2W9W++m+9TWR4oeugLQO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Gustavo,

On Mon, 8 Apr 2019 18:53:16 -0500 "Gustavo A. R. Silva" <gustavo@embeddedor=
.com> wrote:
>
> I just removed the above commit from my tree.

OK, thanks.

--=20
Cheers,
Stephen Rothwell

--Sig_/6Hj2W9W++m+9TWR4oeugLQO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlyr7JoACgkQAVBC80lX
0Gyiuwf/ZrFley/ma9CDR8e4X1Y73hpuoLw5XlulKMM5KeMSqGnMDs+fGG/At2wy
/E8qao4HET8OC34lnNuPrDP6K+zVey8fVevFgnW5Pp7fNnBAO77MfgutTgGM7LwL
dfQA81gsgrTm4xRBCh56XTtNQfCIsmVF3l/2qS3aRs5MR2uhh+yJ77Z4fX80SvNb
Ak/yB8n5cAXIlpagi7E/eynJthzGx+pNkh+c6DVweNq5DGUY96qlxGWC79b3oazb
B1HdkbAquZ52u4dnw4ewg904VrEGveCX/P5DNUDtCsQDkZ0YR4nKlGPN02D5oTN4
X7ENHiPJ5idh285PkBFtgssuFVeJ6g==
=ICcP
-----END PGP SIGNATURE-----

--Sig_/6Hj2W9W++m+9TWR4oeugLQO--
