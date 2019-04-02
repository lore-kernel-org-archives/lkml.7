Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E092C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DAC32133D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="azZt72RV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732163AbfDBNp6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:45:58 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:32948 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731447AbfDBNpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 09:45:54 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x32DjfgA026163;
        Tue, 2 Apr 2019 08:45:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554212741;
        bh=4vlPl2kpU0xasWQlLD1d2f58nJm1CZRazsYZhfd1mac=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=azZt72RVaQqD92VIjsHn9pD3UGgeKn5vBm0jCs3KyVGll7quw3z7857EwQHVqghM/
         rf1GxdKQr1GWWvyj5WANcpPb8J9drRurnFgT8yP2Ae7AkXJLSrdxR+eQOXVcB8cEhd
         VQ940PNMztzHOpngOwmiKhGyEAqdNBDK14g3HZ70=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x32DjfjS028572
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 2 Apr 2019 08:45:41 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 2 Apr
 2019 08:45:41 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 2 Apr 2019 08:45:41 -0500
Received: from [172.22.72.122] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x32DjeDX062730;
        Tue, 2 Apr 2019 08:45:40 -0500
Subject: Re: [PATCH v2 3/3] backlight: lm3630a: add device tree supprt
To:     Brian Masney <masneyb@onstation.org>, <lee.jones@linaro.org>,
        <daniel.thompson@linaro.org>, <jingoohan1@gmail.com>,
        <robh+dt@kernel.org>
CC:     <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>,
        <mark.rutland@arm.com>, <b.zolnierkie@samsung.com>,
        <dri-devel@lists.freedesktop.org>, <linux-leds@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-fbdev@vger.kernel.org>, <jonathan@marek.ca>
References: <20190401103034.21062-1-masneyb@onstation.org>
 <20190401103034.21062-4-masneyb@onstation.org>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <7bcd94ee-a4f8-c91b-697d-cc4c6337ec88@ti.com>
Date:   Tue, 2 Apr 2019 08:45:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190401103034.21062-4-masneyb@onstation.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

On 4/1/19 5:30 AM, Brian Masney wrote:
> Add device tree support to the lm3630a driver and allow configuring
> independently on both banks the mapping mode (linear or exponential),
> initial and maximum LED brightness.
> 
> Driver was tested on a LG Nexus 5 (hammerhead) phone.
> 

Don't need this in the commit message.

> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---
>  drivers/video/backlight/lm3630a_bl.c | 69 ++++++++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
> 
> diff --git a/drivers/video/backlight/lm3630a_bl.c b/drivers/video/backlight/lm3630a_bl.c
> index ef2553f452ca..96fbc1273dda 100644
> --- a/drivers/video/backlight/lm3630a_bl.c
> +++ b/drivers/video/backlight/lm3630a_bl.c
> @@ -35,6 +35,9 @@
>  #define REG_MAX		0x50
>  
>  #define INT_DEBOUNCE_MSEC	10
> +
> +#define LM3630A_MAX_SOURCES	2
> +
>  struct lm3630a_chip {
>  	struct device *dev;
>  	struct delayed_work work;
> @@ -364,6 +367,64 @@ static const struct regmap_config lm3630a_regmap = {
>  	.max_register = REG_MAX,
>  };
>  
> +static void lm3630a_parse_dt(struct lm3630a_chip *pchip)
> +{
> +	u32 sources[LM3630A_MAX_SOURCES], val;
> +	struct device_node *child_node;
> +	int num_sources, ret, i;
> +	bool linear;
> +
> +	for_each_available_child_of_node(pchip->dev->of_node, child_node) {

I would prefer we use fwnode api's.

See lm3532 patch submission for example
https://lore.kernel.org/patchwork/patch/1053132/

> +		num_sources = of_property_count_u32_elems(child_node,
> +							  "led-sources");
> +		if (num_sources < 0)
> +			continue;
> +

Not sure what this is checking here.  Wondering if you should return an error here instead.

> +		if (num_sources > LM3630A_MAX_SOURCES)
> +			num_sources = LM3630A_MAX_SOURCES;
> +

If num_sources is greater than max should we not log and return an error?
Why does the driver fix a malformed property?

> +		ret = of_property_read_u32_array(child_node, "led-sources",
> +						 sources, num_sources);
> +		if (ret) {
> +			dev_err(pchip->dev,
> +				"Error parsing led-sources node: %d\n", ret);
> +			return;

We should return an error here see comment below on the order of operation pdata->dt->default parameters.

> +		}
> +
> +		linear = of_property_read_bool(child_node,
> +					       "ti,linear-mapping-mode");
> +
> +		for (i = 0; i < num_sources; i++) {

If the reg property is used to determine control bank then this for..loop may be eliminated


> +			if (sources[i] == 0)
> +				pchip->pdata->leda_ctrl = linear ?
> +					LM3630A_LEDA_ENABLE_LINEAR :
> +					LM3630A_LEDA_ENABLE;
> +			else if (sources[i] == 1)
> +				pchip->pdata->ledb_ctrl = linear ?
> +					LM3630A_LEDB_ENABLE_LINEAR :
> +					LM3630A_LEDB_ENABLE;
> +
> +			ret = of_property_read_u32(child_node,
> +						   "default-brightness", &val);
> +			if (!ret) {
> +				if (sources[i] == 0)
> +					pchip->pdata->leda_init_brt = val;
> +				else if (sources[i] == 1)
> +					pchip->pdata->ledb_init_brt = val;
> +			}
> +
> +			ret = of_property_read_u32(child_node, "max-brightness",
> +						   &val);
> +			if (!ret) {
> +				if (sources[i] == 0)
> +					pchip->pdata->leda_max_brt = val;
> +				else if (sources[i] == 1)
> +					pchip->pdata->ledb_max_brt = val;
> +			}
> +		}
> +	};
> +}
> +
>  static int lm3630a_probe(struct i2c_client *client,
>  			 const struct i2c_device_id *id)
>  {
> @@ -405,6 +466,7 @@ static int lm3630a_probe(struct i2c_client *client,
>  		pdata->ledb_init_brt = LM3630A_MAX_BRIGHTNESS;
>  	}
>  	pchip->pdata = pdata;
> +	lm3630a_parse_dt(pchip);
>  

Hmm.  Wondering if this should be in the if (pdata == NULL) case and if parsing the
node fails then set defaults.

Because the way it is written if pdata is null then all the defaults are set then the dt parsing
overwrites the data.

Not sure if thats what you intended.

Dan

>  	/* chip initialize */
>  	rval = lm3630a_chip_init(pchip);
> @@ -470,11 +532,18 @@ static const struct i2c_device_id lm3630a_id[] = {
>  	{}
>  };
>  
> +static const struct of_device_id lm3630a_match_table[] = {
> +	{ .compatible = "ti,lm3630a", },
> +	{ },
> +};
> +
> +
>  MODULE_DEVICE_TABLE(i2c, lm3630a_id);
>  
>  static struct i2c_driver lm3630a_i2c_driver = {
>  	.driver = {
>  		   .name = LM3630A_NAME,
> +		   .of_match_table = lm3630a_match_table,
>  		   },
>  	.probe = lm3630a_probe,
>  	.remove = lm3630a_remove,
> 


-- 
------------------
Dan Murphy
