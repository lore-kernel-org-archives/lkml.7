Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD09CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 12:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3BCA2070B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 12:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572005865;
	bh=g/v7Kx4MIL9d7GkTgW3XXwdds91AGMgT2YjzHQsFZP4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ynVyJ0vxSG5Zm+LcMj8ZdO4GuZI/ir0iIzDsFbI2GrGBf448VT1q+KDAjPhUnpOEO
	 y0vBVd9w2eV+4STQdwDgk2A/8+dme3qxXMLnVOhdR5NnSbPsDyiiaWHf5xJTll36qu
	 xZ//1byyObMaDmxUDQyM/8s7PgDJEoWqHRIqRC3c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504452AbfJYMRo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 08:17:44 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50782 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504406AbfJYMRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 08:17:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PZHphFzZcBL/EMTby6gryx3qP37IoYyFFsfAPSnqwkY=; b=CKgmlm3rTzskDLLmTDgfppNlD
        NIMAX9TTB3PshlLF0VfB4cxNqoGTleESzbsXRYOkts//LCam5PQRwcG3FVlXkFr56VWdJeQf0l3wS
        YXlbzyCBg4MB6/0lPdU3j+AIABkdaRDrA3h4A0i14LhcmWuTadHrrDq9iqwBD3jp9lXg4=;
Received: from 188.30.141.58.threembb.co.uk ([188.30.141.58] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1iNyXD-0006tF-Mb; Fri, 25 Oct 2019 12:17:40 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 079CFD020A1; Fri, 25 Oct 2019 13:17:38 +0100 (BST)
Date:   Fri, 25 Oct 2019 13:17:37 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andrey Zhizhikin <andrey.z@gmail.com>
Cc:     lgirdwood@gmail.com, andriy.shevchenko@linux.intel.com,
        lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>
Subject: Re: [PATCH 1/2] regulator: add support for Intel Cherry Whiskey Cove
 regulator
Message-ID: <20191025121737.GC4568@sirena.org.uk>
References: <20191024142939.25920-1-andrey.zhizhikin@leica-geosystems.com>
 <20191024142939.25920-2-andrey.zhizhikin@leica-geosystems.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5G06lTa6Jq83wMTw"
Content-Disposition: inline
In-Reply-To: <20191024142939.25920-2-andrey.zhizhikin@leica-geosystems.com>
X-Cookie: Keep out of the sunlight.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5G06lTa6Jq83wMTw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 24, 2019 at 02:29:38PM +0000, Andrey Zhizhikin wrote:

> +	  Only select this regulator driver if the MFD part is selected
> +	  in the Kernel configuration, it is meant to be operable as a cell.

This i what Kconfig dependencies are for.

> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * intel-cht-wc-regulator.c - CherryTrail regulator driver
> + *

Please use C++ style for the entire comment so things look more
consistent.

> +#define CHT_WC_VPROG1A_VRANGE	53
> +#define CHT_WC_VPROG1B_VRANGE	53
> +#define CHT_WC_VPROG1F_VRANGE	53
> +#define CHT_WC_V1P8SX_VRANGE	53
> +#define CHT_WC_V1P2SX_VRANGE	53
> +#define CHT_WC_V1P2A_VRANGE	53
> +#define CHT_WC_VSDIO_VRANGE	53
> +#define CHT_WC_V2P8SX_VRANGE	53
> +#define CHT_WC_V3P3SD_VRANGE	53
> +#define CHT_WC_VPROG2D_VRANGE	53
> +#define CHT_WC_VPROG3A_VRANGE	53
> +#define CHT_WC_VPROG3B_VRANGE	53
> +#define CHT_WC_VPROG4A_VRANGE	53
> +#define CHT_WC_VPROG4B_VRANGE	53
> +#define CHT_WC_VPROG4C_VRANGE	53
> +#define CHT_WC_VPROG4D_VRANGE	53
> +#define CHT_WC_VPROG5A_VRANGE	53
> +#define CHT_WC_VPROG5B_VRANGE	53
> +#define CHT_WC_VPROG6A_VRANGE	53
> +#define CHT_WC_VPROG6B_VRANGE	53

These appear to be identical - is this not just a bunch of
instantiations of the same IPs

> +/* voltage tables */
> +static unsigned int CHT_WC_V3P3A_VSEL_TABLE[CHT_WC_V3P3A_VRANGE],
> +		    CHT_WC_V1P8A_VSEL_TABLE[CHT_WC_V1P8A_VRANGE],
> +		    CHT_WC_V1P05A_VSEL_TABLE[CHT_WC_V1P05A_VRANGE],
> +		    CHT_WC_VDDQ_VSEL_TABLE[CHT_WC_VDDQ_VRANGE],
> +		    CHT_WC_V1P8SX_VSEL_TABLE[CHT_WC_V1P8SX_VRANGE],
> +		    CHT_WC_V1P2SX_VSEL_TABLE[CHT_WC_V1P2SX_VRANGE],
> +		    CHT_WC_V1P2A_VSEL_TABLE[CHT_WC_V1P2A_VRANGE],
> +		    CHT_WC_V2P8SX_VSEL_TABLE[CHT_WC_V2P8SX_VRANGE],
> +		    CHT_WC_V3P3SD_VSEL_TABLE[CHT_WC_V3P3SD_VRANGE],
> +		    CHT_WC_VPROG1A_VSEL_TABLE[CHT_WC_VPROG1A_VRANGE],
> +		    CHT_WC_VPROG1B_VSEL_TABLE[CHT_WC_VPROG1B_VRANGE],
> +		    CHT_WC_VPROG1F_VSEL_TABLE[CHT_WC_VPROG1F_VRANGE],
> +		    CHT_WC_VPROG2D_VSEL_TABLE[CHT_WC_VPROG2D_VRANGE],
> +		    CHT_WC_VPROG3A_VSEL_TABLE[CHT_WC_VPROG3A_VRANGE],
> +		    CHT_WC_VPROG3B_VSEL_TABLE[CHT_WC_VPROG3B_VRANGE],
> +		    CHT_WC_VPROG4A_VSEL_TABLE[CHT_WC_VPROG4A_VRANGE],
> +		    CHT_WC_VPROG4B_VSEL_TABLE[CHT_WC_VPROG4B_VRANGE],
> +		    CHT_WC_VPROG4C_VSEL_TABLE[CHT_WC_VPROG4C_VRANGE],
> +		    CHT_WC_VPROG4D_VSEL_TABLE[CHT_WC_VPROG4D_VRANGE],
> +		    CHT_WC_VPROG5A_VSEL_TABLE[CHT_WC_VPROG5A_VRANGE],
> +		    CHT_WC_VPROG5B_VSEL_TABLE[CHT_WC_VPROG5B_VRANGE],
> +		    CHT_WC_VPROG6A_VSEL_TABLE[CHT_WC_VPROG6A_VRANGE],
> +		    CHT_WC_VPROG6B_VSEL_TABLE[CHT_WC_VPROG6B_VRANGE];

Please write a series of individual variable declarations, the
above way of writing things is very unusual and hence confusing
to read.  Though like I say it looks like the tables are mostly
identical so you probably only need a much smaller number of
tables, one per IP.

> +/*
> + * The VSDIO regulator should only support 1.8V and 3.3V. All other
> + * voltages are invalid for sd card, so disable them here.
> + */
> +static unsigned int CHT_WC_VSDIO_VSEL_TABLE[CHT_WC_VSDIO_VRANGE] = {
> +	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
> +	0, 0, 0, 0, 0, 0, 0, 0, 1800000, 0, 0, 0,
> +	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
> +	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
> +	0, 0, 3300000, 0, 0
> +};

Is this really a limitation of the *regulator* or is it a
limitation of the consumer?  The combination of the way this is
written and the register layout makes it look like it's a
consumer limitation in which case leave it up to the consumer to
figure out what constraints it has.

> +/* List the SD card interface as a consumer of vqmmc voltage source from VSDIO
> + * regulator. This is the only interface that requires this source on Cherry
> + * Trail to operate with UHS-I cards.
> + */
> +static struct regulator_consumer_supply cht_wc_vqmmc_supply_consumer[] = {
> +	REGULATOR_SUPPLY("vqmmc", "80860F14:02"),
> +};

This looks like board specific configuration so should be defined
in the board.

> +static struct regulator_init_data vqmmc_init_data = {
> +	.constraints = {
> +		.min_uV			= 1800000,
> +		.max_uV			= 3300000,
> +		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE |
> +					REGULATOR_CHANGE_STATUS,
> +		.valid_modes_mask	= REGULATOR_MODE_NORMAL,
> +		.settling_time		= 20000,
> +	},
> +	.num_consumer_supplies	= ARRAY_SIZE(cht_wc_vqmmc_supply_consumer),
> +	.consumer_supplies	= cht_wc_vqmmc_supply_consumer,
> +};

This *definitely* appears to be board specific configuration and
should be defined for the board.

> +static int cht_wc_regulator_enable(struct regulator_dev *rdev)
> +{
> +	struct ch_wc_regulator_info *pmic_info = rdev_get_drvdata(rdev);

regulator_enable_regmap()

> +static int cht_wc_regulator_disable(struct regulator_dev *rdev)
> +{
> +	struct ch_wc_regulator_info *pmic_info = rdev_get_drvdata(rdev);

regulator_disable_regmap()

> +static int cht_wc_regulator_is_enabled(struct regulator_dev *rdev)
> +{
> +	struct ch_wc_regulator_info *pmic_info = rdev_get_drvdata(rdev);
> +	int rval;

This looks like it's a get_status() operation (reading back the
actual staus of the regulator rather than if we asked for it to
be enabled or disabled).

> +static int cht_wc_regulator_read_voltage_sel(struct regulator_dev *rdev)
> +{

regulator_get_voltage_sel_regmap()

> +static int cht_wc_regulator_set_voltage_sel(struct regulator_dev *rdev,
> +		unsigned int selector)

regulator_set_voltage_sel_regmap()

> +static void initialize_vtable(struct ch_wc_regulator_info *reg_info)
> +{
> +	unsigned int i, volt;
> +
> +	if (reg_info->runtime_table == true) {
> +		for (i = 0; i < reg_info->nvolts; i++) {
> +			volt = reg_info->min_mV + (i * reg_info->scale);
> +			if (volt < reg_info->min_mV)
> +				volt = reg_info->min_mV;
> +			if (volt > reg_info->max_mV)
> +				volt = reg_info->max_mV;
> +			/* set value in uV */
> +			reg_info->vtable[i] = volt*1000;
> +		}
> +	}
> +	reg_info->desc.volt_table = reg_info->vtable;
> +	reg_info->desc.n_voltages = reg_info->nvolts;
> +}

This looks like you've got a linear range so you should be using
regulator_map_voltage_linear and regulator_list_voltage_linear.

> +	regulator->rdev = regulator_register(&reg_info->desc, &config);

devm_regulator_register()

> +static int __init cht_wc_regulator_init(void)
> +{
> +	return platform_driver_register(&cht_wc_regulator_driver);
> +}
> +subsys_initcall_sync(cht_wc_regulator_init);

Why subsys_initcall() and not just module_platform_driver?
Deferred probe should work fine for regulators.

--5G06lTa6Jq83wMTw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2y5+EACgkQJNaLcl1U
h9AyPwf8D720tUeawEYezueBB8RS3AlS7EbQYVayzN7mXo7tlnGVP5uwui6D9lUF
Fx52cODW8it+ZcvN16tzkMHqCD0NkSV4mC8y8UvfeRFOW6lf2ue8aVee0NgPDThF
F4jW6CrMT17EEHzQdEcxGRFASPolH6ouzU6x7y6JOrKZXArrYzOxnL1MUiC7Go1Q
Kfshz/iZh1tW8wYPAvCtKvJWnN42W/hyOPGMlZdS50CycKzBtMFttfDSR9PD677T
exWEP/b84pNo5VqChMxFyRQhuiL2QLlfDGmXSZGNLiQvPQgFg8YZJ8ca0DODNvQv
agfS6VVlm/EVa701lNPil77II9eogw==
=5xvu
-----END PGP SIGNATURE-----

--5G06lTa6Jq83wMTw--
