Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F7ACC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 16:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E29792173C
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 16:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555519130;
	bh=XqRkaVnwrL/ow9vM63u05oH5M/da4FvYjuyU2cDqH/A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kJzLt/e+o1ttBtvqV1Dlp2FGS+OEkem5NamdMZZ9+htofRh/JCYNCu/Eh5rvbK5UC
	 NixS8iag7RgNM6GZsCk+lC1h6ZTHXeXS0Z7UuXd12PIuaR+xsANO48t031N5Dc9wjA
	 NpQRpUoUhCb0zTwBNvk9wZ+PTn6xtigKlpwnZGI8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732776AbfDQQis (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 12:38:48 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59258 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729641AbfDQQis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 12:38:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+IoyZONCNcIk6gW+f4RbRgzV/lBDtVJuwPQDjeUNlNo=; b=Qt6XodE0fCLFLXYYm70X7Ukb6
        HzbFsLzo4maoWkI7ID4eD/HzRsY741G5SmUj6nb4+e5csjLjuhRCcKEehpDFtYywpRffkOCE5EXnu
        b7o2YPVSxAvC5q59lHIlWw7qFuGykEGcDUr/W8qMy/8rRRY+mOBtAjDYA/5SwYg+pd4l0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hGna1-00012T-1Y; Wed, 17 Apr 2019 16:38:37 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 874E11128FC7; Wed, 17 Apr 2019 17:38:36 +0100 (BST)
Date:   Wed, 17 Apr 2019 17:38:36 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Pascal PAILLET-LME <p.paillet@st.com>,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] regulator: stm32-pwr: Make some symbols static
Message-ID: <20190417163836.GA1675@sirena.org.uk>
References: <20190417023112.162916-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
In-Reply-To: <20190417023112.162916-1-weiyongjun1@huawei.com>
X-Cookie: Drop in any mailbox.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2019 at 02:31:12AM +0000, Wei Yongjun wrote:
> Fixes the following sparse warnings:
>=20
> drivers/regulator/stm32-pwr.c:35:5: warning:
>  symbol 'ready_mask_table' was not declared. Should it be static?
> drivers/regulator/stm32-pwr.c:47:5: warning:
>  symbol 'stm32_pwr_reg_is_ready' was not declared. Should it be static?
> drivers/regulator/stm32-pwr.c:57:5: warning:
>  symbol 'stm32_pwr_reg_is_enabled' was not declared. Should it be static?

Someone already sent a patch for this.

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAly3VosACgkQJNaLcl1U
h9BTqgf/efTFfwbNwPOEnavpH8p2CUDIke5R4NB5EjkTYY54sng9TIrP1IpX8Yhy
ZJoFYdGz47bHsXupVE0UAHCFrX9KTPR02Lfh0+9qI1ry7WNUQ+kWkP1Z7PW5b7XJ
G2gy7ecZTbfWUAs2H4o2/qhZl5HYWCPKujb+Qyg+lRBLgOxACMATdkij99sujOz4
YnR3FwPKVNHUL8TwaBA78WAiXITVAZ7xycUumhMLG/5TvuXd8NqtNg1pd1aOaHPJ
RBVi/L1QnP6L1lNJCvzr4Xm7nmwSCd01vJbIQ5bllhKaxjOHd9ogd4A58tAXvpAQ
EY5uP6rktrhnM4Mbv/Me24ddT4lfpA==
=drWu
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
