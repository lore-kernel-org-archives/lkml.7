Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A0C3C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50A7420679
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556272636;
	bh=vOo8M58He+Rp/gpFT2Ri+wgG6ma4Uc7r3bUF1I07ucQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mJ5f4qvdYdavpzJszw2zRYErne8LGZxNRNhKErRwzkhOPQXyuKfKWrezv4zvLTa1j
	 dXKrVXLW17Ke/imp/6lupbtD9MNBBZtUjnuWKthXYOEZeUNfMrNw4yocy7NHG4BI1M
	 eCIdw1SLvR8CHmINaQmBy8rqu9QSblwH1ud87Soc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbfDZJ5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 05:57:15 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46134 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfDZJ5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 05:57:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vOo8M58He+Rp/gpFT2Ri+wgG6ma4Uc7r3bUF1I07ucQ=; b=btGBSXhLU7UM0TbUQfvF1b7Z+
        FLktd6FPzkP5ZJO4YrRw/YYFFDva2ogrtMgPtybxxA9HwsoeyDVGHAHg694LBOp7jwnL4Sz4GEftr
        9sinjmC9Qe90/27eYz4S/LEwGrT2FpUOApwz+Dqsy5Kt7Vs//TAGOGtNP2d2zoiyxmbYM=;
Received: from [37.205.61.202] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hJxbP-0003gV-NU; Fri, 26 Apr 2019 09:57:07 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 8F955441D3B; Fri, 26 Apr 2019 10:57:06 +0100 (BST)
Date:   Fri, 26 Apr 2019 10:57:06 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "S.j. Wang" <shengjiu.wang@nxp.com>
Cc:     "timur@kernel.org" <timur@kernel.org>,
        "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V3] ASoC: fsl_esai: Add pm runtime function
Message-ID: <20190426095706.GB14916@sirena.org.uk>
References: <0320f04ac785a6046a6f9baec591d36a4a6189ec.1555899304.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ftEhullJWpWg/VHq"
Content-Disposition: inline
In-Reply-To: <0320f04ac785a6046a6f9baec591d36a4a6189ec.1555899304.git.shengjiu.wang@nxp.com>
X-Cookie: -- I have seen the FUN --
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ftEhullJWpWg/VHq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2019 at 02:31:55AM +0000, S.j. Wang wrote:
> Add pm runtime support and move clock handling there.
> Close the clocks at suspend to reduce the power consumption.
>=20
> fsl_esai_suspend is replaced by pm_runtime_force_suspend.
> fsl_esai_resume is replaced by pm_runtime_force_resume.

This doesn't apply against current code, please check and resend.

--ftEhullJWpWg/VHq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzC1fEACgkQJNaLcl1U
h9D8ugf/a57E7R0SaMmoq+3MoDHMiNdRtpJl6HAus9MmbdIFUbWvldlAob3AD6He
JMm76QgN0Af2NsTmLRhGAmLhrZQ2Bp+Wo/MP0lgSOrs2CdAFzseekjzOllajPGzX
1gL8JWRIYZ9fkRU6i87AaMJDctynIkGCaEhRqUbulbj0QD/0l8CJ1PfNfyugcFN8
WGEdEgD8DQ/ynwk6DUOkWC2HPiRWCB20kzZQH0b2mF6qTQL0YvAtfDot6XZQgWRV
veIRjLGv9koPdiNOOLVjN/QGD4x+op/M4w7e8SaHERWl0Yp9aUBeFUTrhFhhCWc9
qqFth3rvLMMRv/FZFgr2GMYhtAU92A==
=dqQx
-----END PGP SIGNATURE-----

--ftEhullJWpWg/VHq--
