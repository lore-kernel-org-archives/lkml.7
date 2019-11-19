Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92CEFC43215
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 18:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FF1D223BF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 18:38:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xUaj7hMn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbfKSSiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 13:38:02 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:44006 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727173AbfKSSiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 13:38:01 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xAJIbr6Z039222;
        Tue, 19 Nov 2019 12:37:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1574188673;
        bh=200y+IYezlbg1I7CHIbsZoBP5uAkW4mrYcSZBakSEkA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=xUaj7hMnZ4gydoPBzKyzJX1x7VBnBrpEwwFvuYeXRF1HpccFXeJEEpvlbW3AuWBoQ
         7ruduYMQfXtKq7jYsxvHSdU2wlGXe1n0FBnOIoner3JZxpHEx80H8kGQ3UVJBqNXeM
         QCjfZyu2GY3zoMIjhubrfN+6oSavdipD25/p96QI=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xAJIbqOZ061176
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 Nov 2019 12:37:52 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 19
 Nov 2019 12:37:52 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 19 Nov 2019 12:37:52 -0600
Received: from [10.250.33.226] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id xAJIbqTW082910;
        Tue, 19 Nov 2019 12:37:52 -0600
Subject: Re: [PATCH v2 4/4] dt-bindings: mfd: update TI tps6105x chip bindings
To:     Sven Van Asbroeck <thesven73@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Grigoryev Denis <grigoryev@fastwel.ru>,
        Axel Lin <axel.lin@ingics.com>,
        Mark Rutland <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>
References: <20191119154611.29625-1-TheSven73@gmail.com>
 <20191119154611.29625-5-TheSven73@gmail.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <a37d098e-12ea-af2e-22cd-cb5ec2856b6d@ti.com>
Date:   Tue, 19 Nov 2019 12:36:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191119154611.29625-5-TheSven73@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sven

On 11/19/19 9:46 AM, Sven Van Asbroeck wrote:
> The driver has been extended to optionally get its operational
> mode, regulator init data and led label from the devicetree.
>
> Tree: next-20191118
> Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
> ---
>   .../devicetree/bindings/mfd/tps6105x.txt      | 42 ++++++++++++++++++-
>   1 file changed, 41 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mfd/tps6105x.txt b/Documentation/devicetree/bindings/mfd/tps6105x.txt
> index 93602c7a19c8..ab5d4c52074f 100644
> --- a/Documentation/devicetree/bindings/mfd/tps6105x.txt
> +++ b/Documentation/devicetree/bindings/mfd/tps6105x.txt
> @@ -7,11 +7,51 @@ Required properties:
>   - compatible:		"ti,tps61050" or "ti,tps61052"
>   - reg:			Specifies the I2C slave address
>   
> -Example:
> +Optional sub-node:
> +
> +This subnode selects the chip's operational mode.
> +There can be at most one single available subnode.
> +
> +- regulator: presence of this sub-node puts the chip in regulator mode.
> +	see Documentation/devicetree/bindings/regulator/regulator.txt
> +
> +- led: presence of this sub-node puts the chip in led mode.
> +	Optional properties:
> +		- label: see Documentation/devicetree/bindings/leds/common.txt
> +
> +Example (GPIO operation only):
> +
> +i2c0 {
> +	tps61052@33 {
> +		compatible = "ti,tps61052";
> +		reg = <0x33>;
> +	};
> +};
> +
> +Example (GPIO + regulator operation):
>   
>   i2c0 {
>   	tps61052@33 {
>   		compatible = "ti,tps61052";
>   		reg = <0x33>;
> +
> +		regulator {
> +			regulator-min-microvolt = <5000000>;
> +			regulator-max-microvolt = <5000000>;
> +			regulator-always-on;
> +		};
> +	};
> +};
> +
> +Example (GPIO + led operation):
What part of the example is GPIO? Is that the default function?
> +
> +i2c0 {
> +	tps61052@33 {
> +		compatible = "ti,tps61052";
> +		reg = <0x33>;
> +
> +		led {
> +			label = "tps-torch";

function and color examples?


> +		};
>   	};
>   };
