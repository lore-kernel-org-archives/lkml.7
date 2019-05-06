Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21812C04AB1
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 07:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8C142087F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 07:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557128276;
	bh=miGkatXHtioLnQgqzhowFjMzG9oQCfMzr4FBW9BO1Pk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=d/Z3XNlgqajDfns1QfUdDcYchlMA5lwKstK/TZWNpstBNRtT3mKP1FsBjMZrtgDcD
	 oX17NydR5Dir21VcXpdFflnL2BOzv2b2tXhPcVZX4k0hktIjNGZX5Y8g6CS7q17jVR
	 SxhWJNg1Ka7i/5iehzUJdWX9IJbQIMR//AsJGLZU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbfEFHhz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 03:37:55 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:39164 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbfEFHhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 03:37:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MlFyerrYRCSvPhKw2U+CT72hE7v7yaWVoYGE318wXPc=; b=N1euGcYiwa2CPfRpDTB2kTUHI
        3sBVaJ2Rw9Z5DDgVI4HY/3r4mDZCa5xj1+kGB6PX58BCiHIa7Gom+vBUyS3TDJlQhHQnq84ccmLJz
        WlwLAM+JS+XliWoOWhIB7QYZu+JlGFRqdv/AQTdE477BIRPZ1mXfYDzbBE3/F0EA3NmBQ=;
Received: from kd111239184067.au-net.ne.jp ([111.239.184.67] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hNYBt-0000s0-8z; Mon, 06 May 2019 07:37:37 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 1D8B2441D3C; Mon,  6 May 2019 04:37:33 +0100 (BST)
Date:   Mon, 6 May 2019 12:37:33 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org, srv_heupstream@mediatek.com
Subject: Re: [PATCH v3 07/10] regulator: mt6358: Add support for MT6358
 regulator
Message-ID: <20190506033733.GH14916@sirena.org.uk>
References: <20190503093117.54830-1-hsin-hsiung.wang@mediatek.com>
 <20190503093117.54830-8-hsin-hsiung.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RbAp84Sx/Z5HOs1D"
Content-Disposition: inline
In-Reply-To: <20190503093117.54830-8-hsin-hsiung.wang@mediatek.com>
X-Cookie: -- I have seen the FUN --
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RbAp84Sx/Z5HOs1D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 03, 2019 at 05:31:14PM +0800, Hsin-Hsiung Wang wrote:

A few fairly minor things but mostly this looks good.

> +static const u32 vcama1_voltages[] = {
> +	1800000, 2500000, 2700000,
> +	2800000, 2900000, 3000000,
> +};

> +static const u32 vcama2_voltages[] = {
> +	1800000, 2500000, 2700000,
> +	2800000, 2900000, 3000000,
> +};
> +

These two tables look the same?

> +static int mt6358_get_voltage_sel(struct regulator_dev *rdev)
> +{
> +	int idx, ret;
> +	u32 selector;
> +	struct mt6358_regulator_info *info = rdev_get_drvdata(rdev);
> +	const u32 *pvol;
> +
> +	ret = regmap_read(rdev->regmap, info->desc.vsel_reg, &selector);
> +	if (ret != 0) {
> +		dev_info(&rdev->dev,
> +			 "Failed to get mt6358 %s vsel reg: %d\n",
> +			 info->desc.name, ret);
> +		return ret;
> +	}
> +
> +	selector = (selector & info->desc.vsel_mask) >> info->vsel_shift;
> +	pvol = (const u32 *)info->index_table;
> +	ret = -1;
> +	for (idx = 0; idx < info->desc.n_voltages; idx++) {
> +		if (pvol[idx] == selector) {
> +			ret = idx;
> +			break;
> +		}
> +	}
> +
> +	return ret;
> +}

I don't entirely understand what this is intended to do which suggests
it could use some comments.  As far as I can tell it's looking up the
hardware selector in a table and then using the index of the entry in
that table as the selector in order to deal with a sparse set of
selectors, is that right?  You should be able to handle this by having
_list_voltage() return an error code for the invalid selectors though we
don't have helpers for that yet as it's an unusual design.

Also -1 is not a good return value in the case where you fail to do a
mapping, use -EINVAL.

> +	ret = regmap_read(rdev->regmap, info->da_vsel_reg, &regval);
> +	if (ret != 0) {
> +		dev_info(&rdev->dev,
> +			 "Failed to get mt6358 Buck %s vsel reg: %d\n",
> +			 info->desc.name, ret);
> +		return ret;
> +	}

These error messages should be dev_err().

--RbAp84Sx/Z5HOs1D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzPq/oACgkQJNaLcl1U
h9BktAf/aapG5sI3j3lduVVaxhPGb7OblQA1/rmv6rhzowc0XcjywrRfMMlL6sep
mS9qN1bqSNfzF9jPmK9OZS012K04jHqCbDzeJ8tJbRdq1SXNO0KpIukzTaPghrsc
I42t/n4iqmnDtVyHRlBmhIpzeeJPdghqNRL+Q0WnBFEAtCjMq3TBXasmbEqPNFBs
zMZHo7/pfbBJfeNiVYj4Z9Fujt9G1cLEiG0386sgTZLt2GXC1tFk5nsh1Z7dJppa
U+L2jM+HMVU9ylQcVEMzsJx//3eEQHBMvGL18tkGtjU8zWnYUpue/A4MKziwwRyI
WXOx4oPTy0KypDnnAhOZhT12VM+D1g==
=otJk
-----END PGP SIGNATURE-----

--RbAp84Sx/Z5HOs1D--
