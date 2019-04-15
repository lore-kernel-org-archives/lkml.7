Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B16FC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 09:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 698DC2073F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 09:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555322249;
	bh=tzAFElsxQrgJpUG+1qxU8C+cjRQJgT3tTkZVygVsHFU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wwFfPF++XztmDk9MFYQV58wYn7fSSBcIqgPtbmXXda2C6gW5kWj+HQhq3pOlI5HP/
	 3rCx3r3bT0vbcBGhABhjr2gLm6VwpuYAUZZMoiJjv7yVIk8Ns7nzbrGJMWx10F911Z
	 cSyDppYqjXeWKQWALfRsocMI7jo2N+atdvAvYAak=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbfDOJ52 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 05:57:28 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58224 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbfDOJ52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 05:57:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4dZvQl7YlF1yV7q9JfMz8fqbxH6iZxjZSrNpsjltjOU=; b=bOrVI8L6VnBjzWrXIpJvJBcWf
        y5d6so1DAotWuNuaeRYDQEn5nB/F6W3y7511gjtwGCMXnloFBK9NpxuceRTuxJrbNxbmxRt0iOGqb
        B1pshqDMVUiKnTmw5483fg8V78FTBXqsD916u6fStl36WvANBnU0su0Zu21cDvNrUCPzw=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hFyMY-000083-IJ; Mon, 15 Apr 2019 09:57:18 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id D0C4B11279E1; Mon, 15 Apr 2019 10:57:17 +0100 (BST)
Date:   Mon, 15 Apr 2019 10:57:17 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Pascal PAILLET-LME <p.paillet@st.com>
Cc:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 2/2] regulator: Add support for stm32 power regulators
Message-ID: <20190415095717.GA6880@sirena.org.uk>
References: <1555319855-2982-1-git-send-email-p.paillet@st.com>
 <1555319855-2982-3-git-send-email-p.paillet@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline
In-Reply-To: <1555319855-2982-3-git-send-email-p.paillet@st.com>
X-Cookie: There's no time like the pleasant.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 15, 2019 at 09:17:38AM +0000, Pascal PAILLET-LME wrote:

> +int stm32_pwr_reg_is_ready(struct regulator_dev *rdev)
> +{
> +	struct stm32_pwr_reg *priv = rdev_get_drvdata(rdev);
> +	u32 val;
> +
> +	val = readl_relaxed(priv->base + REG_PWR_CR3);
> +
> +	return (val & priv->ready_mask);
> +}

You should probably add a get_status() callback using this.

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAly0VX0ACgkQJNaLcl1U
h9AwaAf/aToCo2Lpwde4IyVS0Xah6RImQN5eFMHjqU/CAVzhfuHyxA3nncqEftbR
Ekr+CFAMrmjVYKnK4Qor47WwRDcGVkHgnlT3RqIMg7DlEUEdtgJm0ODNYQ53arhU
IaBwLKcv0/swlrt7tv0Bx2nB2BjTTE1DorL6DYw2fxhJ8o28FWgL4y+J/ZD6NUQB
KoiAe6vs/G1Wiyj3HRv+wd8nppNLHw6WCYdKUUOT6ApeTBfTmpMvuxGz2XLKrL3Q
/Aj8MN6dy6hLwwDZWtSV7UgcFkx/GpoMDORtFadEX9lyO0KcThiXKHh24D5MVFkd
mwSQr2AdZEEN8mMT8ZU8+gjOa3gVOg==
=JHeU
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
