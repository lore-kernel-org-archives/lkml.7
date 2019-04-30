Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD66C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 05:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D06282147A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 05:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ATGVhV5p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbfD3F4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 01:56:43 -0400
Received: from ozlabs.org ([203.11.71.1]:50537 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725554AbfD3F4n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 01:56:43 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44tW4Q5TQwz9s7T;
        Tue, 30 Apr 2019 15:56:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1556603800;
        bh=fkf8dRO8Kf3XvHzimMslSrDHa/MBXd80K5eextIiTSs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ATGVhV5pNbt8yefmy2R31wGalmZBrPxxtBrklUaatUnzSirqNraBpUpDFsPO4+nMr
         YvUmxjFWrLwACM4TJbp0wP/H+vxN+31vts1wjxifNoHgCldDXl7fRvohQ9q7g2EJu7
         ZDKpx/QfTDCowysoPwIFcp2VjFlE5XZeKLApueTFx6mll6De7ZeG9qyByX4IgLX0N/
         9mav3wzq0oaZVi+2fGh7JxhirNjpJzy7GkyMucUX4AU8ILIbW9XwDnXVofn9uuimIp
         KDTkce8GM0VdKbw4jhBgRTxwTbmK4+Wt8gXS8PBCUs70MCEUZmKCu28rwIWSRwXySS
         Ihxf1b7aPKI5Q==
Date:   Tue, 30 Apr 2019 15:56:38 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: linux-next: build warning after merge of the clk tree
Message-ID: <20190430155638.48e059f1@canb.auug.org.au>
In-Reply-To: <DB3PR0402MB3916B4CE00494BE730C07047F53A0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <20190430101939.76dc077c@canb.auug.org.au>
        <DB3PR0402MB3916B4CE00494BE730C07047F53A0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/K8vF_YX5vxvj4+T9qG7HvnH"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/K8vF_YX5vxvj4+T9qG7HvnH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Anson,

On Tue, 30 Apr 2019 01:44:58 +0000 Anson Huang <anson.huang@nxp.com> wrote:
>
> 	Thanks for notice.
> 	As it is intentional, I will send out a patch to add "/* fall through */=
" to avoid this build warning,

Excellent, thanks.

--=20
Cheers,
Stephen Rothwell

--Sig_/K8vF_YX5vxvj4+T9qG7HvnH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzH45YACgkQAVBC80lX
0GyzHQf+MDOwduTppkTMmqNBNvANKGSLzgM5SCQYLxUUEiwvgQ2F3OEdv28njdbG
IWeahaQisDX/lHf+ovKat4PYMO6cPpTIL+SgwiJREeR/PT7gnXj+QwYFg1e84ZnB
ao51Yd7t53GvmVJRwuHkJrdxAvTX2uAGFMmW0fnkVylwrQZrxuDfE57S5LsILw/u
mmV5QF4H0+X1gWdEo552bvNPomKsDa0DOjBuyUTNqq2dSaWWTwlVAJ4XrNoEsITB
GVwj8U1SXA6NRBpuwEB1i9V2WYhcapvxrKkOM40k4V6uqTPcV4r8BGAJ9cvy0qLA
W4nPNDhm/TX2z135CPjACbqgyIzK0A==
=qNhx
-----END PGP SIGNATURE-----

--Sig_/K8vF_YX5vxvj4+T9qG7HvnH--
