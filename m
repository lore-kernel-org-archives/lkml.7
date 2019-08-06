Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 657FCC32754
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 03:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D18C216B7
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 03:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="OAxM9Zw9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731387AbfHFDpe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 23:45:34 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:56291 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728892AbfHFDpd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 23:45:33 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 462gWv0XZbz9s00;
        Tue,  6 Aug 2019 13:45:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1565063131;
        bh=Fvj0h0HdsEU0mUC9YXQP8w2BkXMBPPx9W0cbWjRIM8o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OAxM9Zw9hKK3wAN5W+GslDQNyuMsdIWfnviRVWxWy+Fbn08qGSrjYkQEeC/sRlDDP
         wHCK+Jrvs7t8p0RceMAxPvNrXr0xji6tyEHZ8ChgBgb7+Yiwd4O0sO5zoiYqaGpHFv
         KIZZivuPVLJUsbJ5HUwLpoS4yqvl2SfeJvWe0pLQbZVG/kJSU5abYS0z5G+ZSVKe0R
         yV+epo+97Xfhj4pnWDLjz3sHneyO5PQio3trjoeiEtSUjTQPFKH4YsXy3adOSwVLKx
         OVcfTG6sTYK7Wo/Rcxoog/O056jJ/9IuNRbQDVIqVAwhiIF2yNffyyOr4LtQa2UC3w
         uUjuJm6X+DdNQ==
Date:   Tue, 6 Aug 2019 13:45:30 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Philipp Rudo <prudo@linux.ibm.com>,
        Jessica Yu <jeyu@kernel.org>
Subject: Re: linux-next: build failure after merge of the integrity tree
Message-ID: <20190806134530.747d155e@canb.auug.org.au>
In-Reply-To: <87imrb0yoh.fsf@morokweng.localdomain>
References: <20190806121519.0f8ac653@canb.auug.org.au>
        <87imrb0yoh.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/f=RnfwCBcNhxz=EaUq2MfGT";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/f=RnfwCBcNhxz=EaUq2MfGT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Thiago,

On Tue, 06 Aug 2019 00:18:06 -0300 Thiago Jung Bauermann <bauerman@linux.ib=
m.com> wrote:
>
> Sorry for the trouble. I wasn't aware of that build time check.
> I'll enable HEADER_TEST and KERNEL_HEADER_TEST for my next patches.

I do allmodconfig builds which enable those.

> Thanks for providing the fix. Should I post a new version or can Mimi
> squash the above into the original patch?

Up to Mimi, but either works (or just committing my patch if the tree is
normally not rebased).

--=20
Cheers,
Stephen Rothwell

--Sig_/f=RnfwCBcNhxz=EaUq2MfGT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl1I99oACgkQAVBC80lX
0GyYMwgAliskcHsyzf60pv9m0WbhAxmeH8CFYru7m2qa/s5e3HBsTWAMAl3Ajk6F
DxvMKlD8Nz18ffl05Ok6QEX0Sb4uLIs6jWuD+Wa3w6gatTd/rHzXro09+rncTvI3
p2X61DRE1nuq+/7/qgbH2O8MXYNbsxW+FX259XwuTC/YmNhms0XwO8TYrd9Ub6dK
C60gRk1lJnz5XDR+UV4VAh2582cbpg6HQ0LUbOgc64FnrIyMB8FvlaeqmOblqtUA
yHwUl7ieR9SKm38h0qqEQq/iX4ek1IHLUkxWWc75QNYIxwPBu1TRzvNk8TjQb78u
ICZfek/NishemOcMcvwvnUc0pLcLFQ==
=gO7y
-----END PGP SIGNATURE-----

--Sig_/f=RnfwCBcNhxz=EaUq2MfGT--
