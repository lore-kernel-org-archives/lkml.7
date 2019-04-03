Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68960C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39D1B20882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554266618;
	bh=F2+neki7ykzc6Pkq6wJ8ZN4AJqt+S6s/jTbfgCvD3S4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aGrUtaIcBXmkA890NNWeDwxcgN14iRjQhJvUuHm6Ha/Ubg6Id46YbZuyDlbem+ebL
	 GqhN5kN7ysD2gNzKgjL94kHPFRrgz3zs/giXr9MC5oNHVKkpg0J9udbfg9NOwMz+hb
	 Qlesk5bpXJSdaUiExy22n5BVrQC0l4cDvCsQSEJs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbfDCEnh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 00:43:37 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42594 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbfDCEng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 00:43:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=F2+neki7ykzc6Pkq6wJ8ZN4AJqt+S6s/jTbfgCvD3S4=; b=qvuGx2Jr8KcdzKHvLnIIRS3KP
        hSs7YOpunIzW4T7a5iv2Z9wlTBjqeCT7s5HqH3E5swLKU4v7truKb6nl7WhqjQCtQSwAe1WZBIeUH
        I4MiIg/P4xH/AFRbBfozomggxpY8WQjndS2LUylfQtIuLKoYN7TtfQM+sB/r611lrB4Po=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hBXk8-00042X-RV; Wed, 03 Apr 2019 04:43:21 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id B31CF440082; Wed,  3 Apr 2019 05:43:17 +0100 (BST)
Date:   Wed, 3 Apr 2019 11:43:17 +0700
From:   Mark Brown <broonie@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yintang Ren <yintang.ren@unisoc.com>
Subject: Re: linux-next: build failure after merge of the sound-asoc tree
Message-ID: <20190403044317.GD5748@sirena.org.uk>
References: <20190403111108.2ff4a309@canb.auug.org.au>
 <CAMz4ku+17HAZfh-03+y=WUy1NdsL7sQHK_XyzeToBh5-RAUSQg@mail.gmail.com>
 <20190403033518.GI2059@sirena.org.uk>
 <CAMz4kuLyAKwRLWu3+cfpDsLwCtJS21BN0xmL-DNxfmPYXC_tZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TybLhxa8M7aNoW+V"
Content-Disposition: inline
In-Reply-To: <CAMz4kuLyAKwRLWu3+cfpDsLwCtJS21BN0xmL-DNxfmPYXC_tZA@mail.gmail.com>
X-Cookie: Replace with same type.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TybLhxa8M7aNoW+V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 03, 2019 at 12:27:53PM +0800, Baolin Wang wrote:
> On Wed, 3 Apr 2019 at 11:35, Mark Brown <broonie@kernel.org> wrote:

> > We can't leave this broken in -next for that long, can you please post
> > the patch now if you've already got it?

> OK, but I need some time to setup my environment to send this patch
> and I'll try to fix this ASAP. Thanks.

Don't worry about it, I can do things directly - it was just if you had
the patch already it seemed better to use yours but if it's going to be
painful to set up a dev environment there's no need to worry.

--TybLhxa8M7aNoW+V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlykOeQACgkQJNaLcl1U
h9ChXQf+LlQxz18gvBxkA9hdMzFhZfqmWRczLrEuAAI+IhS/LhV0m0U7pXjmuuOs
skz9ovZ5ppxCfTPZQQ8ebAIuGIZ6mfMfg2BbY1u0a5eq1fVxgSwvCVGoOtvri3kk
clDObW1VuIEZxBusCIoK4IHABjbzK0nUj+WwBIL7/9QgX+XB51pQp3lpSUG3fAlz
fYcEzbxkvpggtlVksva9+CuoqvGuoxlOv2LF76PeaOxssK2SUBjlgKBtvkLCuq6H
s21StxeUGN88oQuyOa5LdFtGmW2c/4UjfCN1/dY19oKLGtMryakiOLoJqLeaJbRC
AwOxwmyihNBj65t4Pxn1AMlrEpA/pw==
=zRZu
-----END PGP SIGNATURE-----

--TybLhxa8M7aNoW+V--
