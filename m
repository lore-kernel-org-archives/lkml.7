Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C767C49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 11:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A2A42082C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 11:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568200103;
	bh=HHnXmjuPtzS2mOWRO4aXJSHL1FSaP/89qlf1dDrZaEE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EsYBJdA1gFb/XUn0ccg8rWNZD4vrq7a62WpAfGrwLf94uwo/zYouSfQ+95psdJB5M
	 SfKQEfD3wyPE5NZFTDIKxWa6sfxxDRtpQfja+JMBF/CiZD33vUb+cTQrO+QlwaZju6
	 hAvI+dodfnZY2p+RO2HbFL+R4UYhh74k1OGLi66w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbfIKLIW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 07:08:22 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58618 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbfIKLIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 07:08:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HHnXmjuPtzS2mOWRO4aXJSHL1FSaP/89qlf1dDrZaEE=; b=qK7u45WBdtW6VEw40C6FxeWOV
        TomAOJYtYL8dsv7+JXT0kLU+drfE1E/Z6mE4zWCgcOXC3ybMerTnM1uvNko2zCF6ExJLedM6oEnl0
        xpmIwJrtBW4K6IKp60dsSjADNbuq2+Ip7RAq4yX6CVESBdxmCboPFgiP3y1/OhtRQAQHY=;
Received: from [148.69.85.38] (helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1i80To-0008Rd-Kh; Wed, 11 Sep 2019 11:08:08 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id E841FD00451; Wed, 11 Sep 2019 12:08:07 +0100 (BST)
Date:   Wed, 11 Sep 2019 12:08:07 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>, timur@kernel.org,
        Xiubo.Lee@gmail.com, festevam@gmail.com, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] ASoC: fsl_asrc: Fix error with S24_3LE format
 bitstream in i.MX8
Message-ID: <20190911110807.GB2036@sirena.org.uk>
References: <cover.1568025083.git.shengjiu.wang@nxp.com>
 <2b6e028ca27b8569da4ab7868d7b90ff8c3225d0.1568025083.git.shengjiu.wang@nxp.com>
 <20190910015212.GA16760@Asurada-Nvidia.nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1ozVqH6bFr/3sC51"
Content-Disposition: inline
In-Reply-To: <20190910015212.GA16760@Asurada-Nvidia.nvidia.com>
X-Cookie: Be careful!  UGLY strikes 9 out of 10!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1ozVqH6bFr/3sC51
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 09, 2019 at 06:52:13PM -0700, Nicolin Chen wrote:

> And a quick feeling is that below code is mostly identical to what
> is in the soc-generic-dmaengine-pcm.c file. So I'm wondering if we
> could abstract a helper function somewhere in the ASoC core: Mark?

That's roughly what sound/core/pcm_dmaengine.c is doing -
possibly we should move more stuff into there.

--1ozVqH6bFr/3sC51
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl141ZcACgkQJNaLcl1U
h9BiLAf/TB2E4wy6DNKmjy1tOffUwKYDmy9RgufK7HCIINZHzoiiwRgXY0IcsAnQ
/l2Qpn8LKUi3uc4Db4urdP6TaWvOecadb/PX8ifkRVAUSIEWkbYumPmdfNeKQ2Sq
oUXlxF682VrGakytUZlz4dh/BFhiWxda52tfs4WUuzO4TyHjpmCM3dZg3Em3J536
FjgP4H1tnb1d/6j1am+7o5b4YBuQRmYo39ZJrEHOCliEZk6L7ycncUV+Ye4QSYCk
iOYjeb9FmZxK0JZErs0Eu7rXsk5JZQptegeJ8kTSZv7darXCSpVltusGB92mMij5
akx0MmeZQdSoM83elUgbLWuJtBnkjQ==
=7lNC
-----END PGP SIGNATURE-----

--1ozVqH6bFr/3sC51--
