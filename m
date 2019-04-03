Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E40C3C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 03:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9DD120830
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 03:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554262537;
	bh=Rm9D8y3vQlDOBLawVxzl3GV+DVrRRWRGJ9DF/+ZW9Lc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DStP96rQK7JW9GQ8kAwRVRXm+GgdCWY+eMwIcCKTInxJSp5GsSoyqlKdxcwScofCr
	 5I2/aIAxyBa9i3W1eSyHWMjnUnhdQ7FnhVH0ZAGI2t0fv39viJA92+10pRR0YuaN7A
	 IX7Ykt3Xvd6RpUmYvUNm1oIAzKSZwmgX4bfU5SFA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfDCDfg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 23:35:36 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41118 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbfDCDfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 23:35:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Rm9D8y3vQlDOBLawVxzl3GV+DVrRRWRGJ9DF/+ZW9Lc=; b=EQlk5JNuZ4gHjO6w6A5Fgqp8V
        vL2e/BThs/oYfjl+S0nzzMnzi59SubfYcdwipvAX8mxa3inBmUq7EgeDCyBG0xyr8CQKdY5u5M9RU
        xGexccsTyfJABfsOAxa0o+kK6d4ummaKYfRmELhyoJs+ojsfLS8KRjGVH1TwJsqS2ZPQI=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hBWgL-0003dk-Q6; Wed, 03 Apr 2019 03:35:22 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 6FBB8440082; Wed,  3 Apr 2019 04:35:18 +0100 (BST)
Date:   Wed, 3 Apr 2019 10:35:18 +0700
From:   Mark Brown <broonie@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yintang Ren <yintang.ren@unisoc.com>
Subject: Re: linux-next: build failure after merge of the sound-asoc tree
Message-ID: <20190403033518.GI2059@sirena.org.uk>
References: <20190403111108.2ff4a309@canb.auug.org.au>
 <CAMz4ku+17HAZfh-03+y=WUy1NdsL7sQHK_XyzeToBh5-RAUSQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ggHp9WSrPOeNxb0b"
Content-Disposition: inline
In-Reply-To: <CAMz4ku+17HAZfh-03+y=WUy1NdsL7sQHK_XyzeToBh5-RAUSQg@mail.gmail.com>
X-Cookie: Use extra care when cleaning on stairs.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ggHp9WSrPOeNxb0b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 03, 2019 at 10:12:47AM +0800, Baolin Wang wrote:

> snd-soc-sprd-platform-objs := sprd-pcm-dma.o sprd-pcm-compress.o

> obj-$(CONFIG_SND_SOC_SPRD) += snd-soc-sprd-platform.o

> I will send out one incremental patch to fix this issue after my
> business trip. Thanks.

We can't leave this broken in -next for that long, can you please post
the patch now if you've already got it?

--ggHp9WSrPOeNxb0b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlykKfUACgkQJNaLcl1U
h9BY6gf/ZpB3yEl94efbF5gOaXY6r5fyhFa25W+G+efPdBL5r6Cp8fcrlhZASCEy
I98JPfaJiXhlognp4F0hYLcbWvELt7MGWGPB8k4ANk9/H+/WCvnXPMqLF8fucY4x
qW2ZiaJLp7zwwiIkwh6LXTwHDX0labfeYFo5q8NCuAVEftvjUouKLHJfff+wmGvz
M7ZRaOumz+lQ4HkQRkdm2YAjZjpeC2pk9+yvklDIuX4gwyzSsuS4Wb82UNZP0ipR
s2CoN8pajVkQv4799FuoH4stqjYCmLh8rZ1HeB6VqTXcVask7iQZiRszCc3D7JT4
0MCUe4zSHp4vmbt5jiTx3rSViImkAg==
=fM9m
-----END PGP SIGNATURE-----

--ggHp9WSrPOeNxb0b--
