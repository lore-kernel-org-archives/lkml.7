Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D9D8C606AC
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 13:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CA722064B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 13:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="qtl1Bn9r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731220AbfGHNFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 09:05:23 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:38927 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728800AbfGHNFW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 09:05:22 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45j5KD3RRSz9sPY;
        Mon,  8 Jul 2019 23:05:19 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562591120;
        bh=Vebdk3CqAvhEfu1Q7laCkjlWo4ELjTX1q3vyVvjJMhU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qtl1Bn9rhirZ9C1wre3PD21lFF81kZBteFi8PeLXLgZWSSk7PyzkaX84RAvcCo2XB
         xzUaXnL78l/hmx19MMG26M99YsbK1irxlM3/QZ6HK58c1X5bq+smasxnUExCXs9pet
         9dMYNBul0PfYs3AVRAFlPPgh6NL/gGrRRDo3mhdRqj/8eXyyVTQGgkF4DE6Ra4N9qE
         BaeXrAUfZH4Cr6cC/G19t1lplRFsmG426fuwDer72shPTjKydRlp4N7dPj9T6gIdzh
         laGPxst4IKFdsAPQHdSQqYlhBMeJHoUJzIhDuvIEKr3FM0O43MmDKvRXqHwpb019RV
         CLYZYFgWta8bw==
Date:   Mon, 8 Jul 2019 23:05:17 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jeremy Kerr <jk@ozlabs.org>,
        Alistair Popple <alistair@popple.id.au>,
        Eddie James <eajames@linux.ibm.com>,
        linux-fsi@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] FSI changes for 5.3
Message-ID: <20190708230517.49ae3d6a@canb.auug.org.au>
In-Reply-To: <CACPK8XeZTG8dxiQNi_HRyRAnfGnoagn2WonwYZD1mez9vzpJNA@mail.gmail.com>
References: <CACPK8XfCpgjAwMeoyhcZqgqtXO=-wtpuB2kwsogvBnd1VzynDg@mail.gmail.com>
        <041ce2ab04d0594accdbf51078906ac116cc0253.camel@kernel.crashing.org>
        <CACPK8XdGC4V5xs5S=JHk=tUayLGHQkF5eH0pvFnyffpDaUuqQQ@mail.gmail.com>
        <20190705073158.1c8384ed@canb.auug.org.au>
        <CACPK8XeZTG8dxiQNi_HRyRAnfGnoagn2WonwYZD1mez9vzpJNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/SuiLUR=DnGsN0jVh15dpiKk"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/SuiLUR=DnGsN0jVh15dpiKk
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Joel,

On Mon, 8 Jul 2019 03:41:40 +0000 Joel Stanley <joel@jms.id.au> wrote:
>
> Thanks. There is a next branch now, please take that instead.

Done from tomorrow.

--=20
Cheers,
Stephen Rothwell

--Sig_/SuiLUR=DnGsN0jVh15dpiKk
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0jP40ACgkQAVBC80lX
0GzT/wgApb2XsXLiC4MON2MOLxeQxG8/NF79IfMq91Hu0Gg2FAMZhQPNRijNp2ak
cVbHMd7BI3oM7XhXOYV2KepYz8GNL46Ph7gUuwREaLCtgf7d410TVLna5RJC50G6
xIKZb0ArqiW5ERk6vyxzs93dHKXD+GbNfT6qXfkK98OCxdQ/2Ab3MUrfI0ULM0F9
TM08Z6vjo+v1XilrOhZJ3VXXvRSczy1uGvywID+XaZT4ANPjRjqZLGMWWhqcvJib
OtCy2HjWuuZZaliO/1v/T56RD/XYZvlTRhsJxxS8hWuU2g6AX41UdQEXb688JpSs
Z/MP/AGJevf7fyR6QLt8vP0wd/SL4Q==
=Ahg8
-----END PGP SIGNATURE-----

--Sig_/SuiLUR=DnGsN0jVh15dpiKk--
