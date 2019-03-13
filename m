Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE54C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 15:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E34D5214AE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 15:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552489322;
	bh=8DDiM1eWGUAU4tuDVuZfKc088UEDnaZhWRIvS7K/tCM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JpqVxZM/MxHXxZU1RxXK+Vmij3DQNrPkN5oBp7pMpXu/JZqEkqwVDxAyTj1wJpFDV
	 /W5b8lwSkHfTrJ7M9nh/u6s+F5EEyqNofY1fS/1V5zgqyNh9fcKXQkqFrJ+crJuibF
	 Q5HENvjnzZceimtLVzar/KriFF4aR6iiGNQHoqv4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfCMPCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 11:02:01 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43842 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfCMPCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 11:02:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hSugnqnoJFSNcvCBKdbaU7QD11ItzVJo4CVY/LKjPw8=; b=ZbJPTAbwiih08LWJ34FlQHgN2
        9gIG41WG7joyBJE17zW+bp2hFygf0eiC5xiYy29kdH9bUnmspY8nVv0/LkmYeCdX7NQAImJruJFnz
        UsRLvaDi2FzMUa/uW1jfuwU3VwJv0ruY9SCoulM5Tbh1Te81WNrNtQYvX6/knjgtp+Reo=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h45Nt-0003Ii-AX; Wed, 13 Mar 2019 15:01:33 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 8EF9A1128B97; Wed, 13 Mar 2019 15:01:32 +0000 (GMT)
Date:   Wed, 13 Mar 2019 15:01:32 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v2 6/9] regulator: mt6358: Add support for MT6358
 regulator
Message-ID: <20190313150132.GA5951@sirena.org.uk>
References: <1552275991-34648-1-git-send-email-hsin-hsiung.wang@mediatek.com>
 <1552275991-34648-7-git-send-email-hsin-hsiung.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline
In-Reply-To: <1552275991-34648-7-git-send-email-hsin-hsiung.wang@mediatek.com>
X-Cookie: Availability is limited.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 11, 2019 at 11:46:28AM +0800, Hsin-Hsiung Wang wrote:

> +static const u32 vefuse_voltages[] = {
> +	1700000, 1800000, 1900000,
> +};

This and a bunch of the other regulators look like they're just linear
ranges and could use the linear range helpers.

> +static const u32 vcn33_bt_voltages[] = {
> +	3300000, 3400000, 3500000,
> +};
> +
> +static const u32 vcn33_wifi_voltages[] = {
> +	3300000, 3400000, 3500000,
> +};

These also have the same range so no matter which helpers are used I'd
expect the data to be shared, I think some of the other regulators might
have shared tables but didn't confirm.

> +static inline unsigned int mt6358_map_mode(unsigned int mode)
> +{
> +	return mode == MT6358_BUCK_MODE_FORCE_PWM ?
> +		REGULATOR_MODE_FAST : REGULATOR_MODE_NORMAL;
> +}

Please write normal if statements, it makes the code more readable.

> +static int mt6358_set_voltage_sel(struct regulator_dev *rdev,
> +				  unsigned int selector)
> +{
> +	int idx, ret;
> +	const u32 *pvol;
> +	struct mt6358_regulator_info *info = rdev_get_drvdata(rdev);
> +
> +	pvol = (const u32 *)info->index_table;
> +
> +	idx = pvol[selector];
> +	ret = regmap_update_bits(rdev->regmap, info->desc.vsel_reg,
> +				 info->desc.vsel_mask,
> +				 idx << info->vsel_shift);
> +
> +	return ret;
> +}

This looks like something other devices might do - rather than implement
it in the driver it would be a bit better to add it to helpers.c as a
reusable function.

> +static int mt6358_get_buck_voltage_sel(struct regulator_dev *rdev)
> +{
> +	int ret, regval;
> +	struct mt6358_regulator_info *info = rdev_get_drvdata(rdev);
> +
> +	ret = regmap_read(rdev->regmap, info->da_vsel_reg, &regval);
> +	if (ret != 0) {
> +		dev_info(&rdev->dev,
> +			 "Failed to get mt6358 Buck %s vsel reg: %d\n",
> +			 info->desc.name, ret);
> +		return ret;
> +	}
> +
> +	ret = (regval >> info->da_vsel_shift) & info->da_vsel_mask;
> +
> +	return ret;
> +}

This is just the generic get_voltage_sel() as far as I can see?

> +	/* Read PMIC chip revision to update constraints and voltage table */
> +	if (regmap_read(mt6397->regmap, MT6358_SWCID, &reg_value) < 0) {
> +		dev_err(&pdev->dev, "Failed to read Chip ID\n");
> +		return -EIO;
> +	}

We never use the value we read here?


--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyJG0kACgkQJNaLcl1U
h9Bqcwf/cBs7hTJMGSxxGTMQXuOiF7spWZKUwkRLK+rWiYzZv7xUeHEoUoSLZzm/
d1xUkLNQ48R3p7Ey4aVzFf3HltiH9RGj+3g8OszIJS6SdTybiZYhJqMsAMnqfX/x
tIbiu6NhlLrtm6qfKEEjHHnYSu1dIhMm6Y6JJ4D/yjpxWBed6xR0LlGTk7s3b3Gs
xf1hGjBU2Hl0CE4TiamypPcVTzEIx4mzw1VpB2qBXwCoDLG1wnJKwjAmFVFNyWLo
jpEeWmmqBboKOiRw+LfVXPW7CF35a3smalwrzBhIYToBop3b95kY5Pza/r7Vmr84
203AJzm4IdIG7xe56xcuLu3AOOQqaA==
=Aw1h
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--
