Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D9FC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3AAF20866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560342080;
	bh=G2m8Nt3FXBKC+GjteG/VdeKPHraKkYODHIoLlrW4ZZs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=L+5JkpvEHjpKBU4nVxp2duQriNiSUmUeLM0aIZJyO6PWo+PfqYXhSN+RpDbK7IsZF
	 s2mJDvJKFxOVNLHhnukuv317CDPJBGJGAumue0P1L15+L9RAAxFqvgNhhQrU4lhI/n
	 wyrLQUn/FT5q5uUm3UGjY8ERINb3T5iVcqsgPMEw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438861AbfFLMVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 08:21:20 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44396 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438851AbfFLMVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 08:21:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=d3oBGtYp5aam1o95qHh2KnsO5hZEEN9b6/RJcidctN0=; b=bcE5oJO+9cz6djAxmTehfgjmn
        K2XzTRV30h+kC4e0eN8qq+A8+O9ZkgGwbhL6/LLaeRh5VFNE6c1YM+AFRczXuuECL1HFIngu1OXjQ
        PUHseJc+0JB1cyZsvqYz/PJwPwSLzsRtH40kazOS7TrUQ2UCXPNtXlnWoaPS75cR1fLrE=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hb2Ff-0002q7-TP; Wed, 12 Jun 2019 12:21:15 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id E18B2440046; Wed, 12 Jun 2019 13:21:14 +0100 (BST)
Date:   Wed, 12 Jun 2019 13:21:14 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     lgirdwood@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drivers: regulator: 88pm800: fix warning same module
 names
Message-ID: <20190612122114.GE5316@sirena.org.uk>
References: <20190612081158.1424-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fWddYNRDgTk9wQGZ"
Content-Disposition: inline
In-Reply-To: <20190612081158.1424-1-anders.roxell@linaro.org>
X-Cookie: Editing is a rewording activity.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fWddYNRDgTk9wQGZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 12, 2019 at 10:11:58AM +0200, Anders Roxell wrote:
> When building with CONFIG_MFD_88PM800 and CONFIG_REGULATOR_88PM800
> enabled as loadable modules, we see the following warning:

Please use subject lines matching the style for the subsystem.  This
makes it easier for people to identify relevant patches.

--fWddYNRDgTk9wQGZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0A7jcACgkQJNaLcl1U
h9CL7wf/SsCMcskwgcT7KEvtiAR3xJGC1Z6BTa85bFuFa/zydPP2OTMn7HrqShXe
A0EMxH7YpYcScfI3SYxGktPOi2hbkT0cJpI2EFE067GIDfvy83GawlHHjCbjHKyj
QYAphr8G292c6NwrDtuybSOKInKItfCUpDO5AlP7xLKfQjiV0+t8v462HYqA0uoy
0zkgn0tdGSly4AVanpQ6i4VJIVnShUvWrC50YJRBNHAO1Ihk8dV1wmXS57lqZja5
9T1b0Or7HQmWV+us4MFf1kMqDVwxsZMDYAd+NGfqfJ2HFGlu/WB2wm//6zA8i3Cr
KmhTinAhFm9ybDUkzmmVb+y0VWyo6g==
=Z/KL
-----END PGP SIGNATURE-----

--fWddYNRDgTk9wQGZ--
