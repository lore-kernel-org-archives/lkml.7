Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0821EC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 08:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C96FC20B7C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 08:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="DIodWpzp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405899AbfHIIOw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 04:14:52 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:47635 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726054AbfHIIOw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 04:14:52 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 464dMF2qLqz9s3Z;
        Fri,  9 Aug 2019 18:14:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1565338490;
        bh=CaBI3pRW72rTTPLhhgx4VE8Io7Njb78GeFi0yPGLEes=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DIodWpzpmHHasSK4mdCmcv2rqXlo8OvaGtk01/EEOTRCxLA5F2OfE6P78zx+S33GF
         BOuM9hQ3BTZzJz8l8LEuNoVqHLpinlKEYe9XZMWEeD0LHnl2FF8EUTJS1hmTYuWgN2
         N8pev8WlPJbK5Q/dNoCegFj88sOAWNMJfUEHPRx++e6MsdoDlkgeb+EWJwrzS3NCtn
         GKeHKlCdNFauUIAuqI6jZZnmppGQU5bUIILdX5ONUfH4P9s8wP+aVnazXv8hStHz4S
         ao3bciItVVLoVQC1XF4nZrHoiUkdOcUinEyTXL3DuSQC3pwVbttqBHKOcfN61YLM7t
         DEvyqXiaukZBA==
Date:   Fri, 9 Aug 2019 18:14:46 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Tree for Aug 8
Message-ID: <20190809181446.19125f6e@canb.auug.org.au>
In-Reply-To: <CAK7LNASzxcicBPM5OkScnwHPef_7X=oiuO_0xCH3f55ACYZEWw@mail.gmail.com>
References: <20190808181739.62f257ed@canb.auug.org.au>
        <20190808225316.GA3725@osiris>
        <CAK7LNASzxcicBPM5OkScnwHPef_7X=oiuO_0xCH3f55ACYZEWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/kLHSecfJwxkAcT.4nyFawqk";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/kLHSecfJwxkAcT.4nyFawqk
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Masahiro,

On Fri, 9 Aug 2019 13:44:19 +0900 Masahiro Yamada <yamada.masahiro@socionex=
t.com> wrote:
>
> Stephen, could you revert this commit for today's linux-next ?

Sorry, I discovered your email too late :-(

--=20
Cheers,
Stephen Rothwell

--Sig_/kLHSecfJwxkAcT.4nyFawqk
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl1NK3YACgkQAVBC80lX
0GxC4Af7BK+6gfT7f+T3AnnYkhBnfRSaWw46H1C71ZUQ5qMtI6yc0WXxqoxcILfu
Nq/yMeUFPeO9B1anhdnaPcdPs3qVgIp3zCHpHnHKVxo2ki0tLuBCRuO33fx8x/EA
U6wmRlirbbuZbncLSzWVpu7oR9vWG3CDk8BpyIBEHW4oJMMZ/jkyhCMG5nnB3ZHe
rPuWavR9BHzBcIpenuQXtHh7Hh+5uEfmWdYHuETn+0o5D5+7xZz7Wohzvn2JR5Je
iAPUugcJQfuZ/yh7iix72sjk7Ywwwiemslyv/m8n8ub1uOQeKkrZ5oaOXEsLEIsv
vkJXEt+hLKtW81w+4gp4lSnPmm9ojw==
=3Rq3
-----END PGP SIGNATURE-----

--Sig_/kLHSecfJwxkAcT.4nyFawqk--
