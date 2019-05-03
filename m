Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1595C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 06:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7261A206DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 06:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556863261;
	bh=qjEXpZqnBLeKa8qp5yPa2qc3EooQM5I8RpvMNoSsDpQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nLsl7ewfl45mcpotF9dnsLlgj41fYGM/ArOfxWGIaSVJyZcdCwxHRhnlgy9SmC7xe
	 TMYIbyozz0mYmRLVDfFvyhR5Ttx4HP8zDT61qnRWSQq2dCfeJSYBmv7IxZDR9E7Zba
	 7mXMkY6ucQlbaq4R/y9i4LOjMBFBIlQv/XcLpsHA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbfECGBA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 02:01:00 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50798 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbfECGBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 02:01:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=b+00Xez4VVqvi11sX2TSXpfIJgpjwEvl8UnGe/5MG3c=; b=eeMhrqL1edD4BmDM+M2z7gyso
        TcGG1Ud//m2wYJB9GDY2Zk1BXBLfwBVREENjIqVoftX5U0QtHlAMKZzCVIN/eTNMmxqIKt03OiDUs
        zgJGJZhK5Zx2ZoVmnuJcXcMAdPm469jHejXJe7F+zmBjHaaXLUQr5LYUpjXDzrKq6wnQI=;
Received: from [42.29.24.106] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hMRFR-0000RO-SJ; Fri, 03 May 2019 06:00:42 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 866E1441D3C; Fri,  3 May 2019 07:00:34 +0100 (BST)
Date:   Fri, 3 May 2019 15:00:34 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Fabien Parent <fparent@baylibre.com>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        matthias.bgg@gmail.com, perex@perex.cz, tiwai@suse.com,
        kaichieh.chuang@mediatek.com, shunli.wang@mediatek.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] ASoC: mediatek: mt8516: Add ADDA DAI driver
Message-ID: <20190503060034.GD14916@sirena.org.uk>
References: <20190502121041.8045-1-fparent@baylibre.com>
 <20190502121041.8045-5-fparent@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/EQiL+SffV/fXkvV"
Content-Disposition: inline
In-Reply-To: <20190502121041.8045-5-fparent@baylibre.com>
X-Cookie: -- I have seen the FUN --
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/EQiL+SffV/fXkvV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 02, 2019 at 02:10:40PM +0200, Fabien Parent wrote:

> +static int mt8516_afe_adda_hw_params(struct snd_pcm_substream *substream,
> +			  struct snd_pcm_hw_params *params,
> +			  struct snd_soc_dai *dai)
> +{
> +	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
> +	unsigned int width_val = params_width(params) > 16 ?
> +		(AFE_CONN_24BIT_O03 | AFE_CONN_24BIT_O04) : 0;

Please write normal conditional statements rather than burying things in
the variable declarations usin the ternery operator, it makes things
much more legible.

--/EQiL+SffV/fXkvV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzL2QEACgkQJNaLcl1U
h9CnBQf+I75JGpPa7HZs9a5wiVauteNssp4QFPfRbk8PmvqiqEycEs+1ykqmWwhK
K7c2GX0MELLAlaU9UmlelicrJB5+xaGGOAUFl5CVnVt9zxLdrXPvfeet/dK9FBtY
Vpjh1BVvkUYgD9gz/u2sRgOtysfwQzfB17Uh3GtNHfoofg4Fhi/MqevPdkDyRf00
ZelGCTTFYLeFLm66hzyjZHfGPlRBTG1G7IcNJ/mRgGg7Asc2LaxhauBM0nLTqANG
H5t9WOoaoIbQy2JDR0PCw22mB0gE+tY7gkMZZy3NWxnzZk4uNTgR5Me2P/vly6Bc
x6jXh8xYjanv7sdTg/r/in0JXtVYTA==
=rEDi
-----END PGP SIGNATURE-----

--/EQiL+SffV/fXkvV--
