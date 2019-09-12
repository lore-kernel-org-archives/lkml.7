Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A09C47404
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 11:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AE1720693
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 11:40:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GeL8p8RO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731451AbfILLkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 07:40:22 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:47976 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731429AbfILLkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 07:40:22 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x8CBdpeK074141;
        Thu, 12 Sep 2019 06:39:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1568288391;
        bh=S3Uw7YV4iduTm2oKlG6534ijPPVci6yUlAzgg9rmfq8=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=GeL8p8ROhUPfObNUFk/PLBiwXl4tBAb2eJPfeob4pLukY7J5A74Wet9FPQ604ClwE
         rpAL1zeAz19IimtEarFIGg8wkgxTmJXiAhsoH6QHTlRvWXoYz+tCcVIP6HuZq0wpV6
         Lr956nAtEz5pNjR6KzKPBoZ6ilx+yMGFpWnRn6As=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x8CBdpqu008220
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 12 Sep 2019 06:39:51 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 12
 Sep 2019 06:39:50 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 12 Sep 2019 06:39:50 -0500
Received: from [10.250.65.13] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x8CBdoVV107454;
        Thu, 12 Sep 2019 06:39:50 -0500
Subject: Re: [PATCH v3 1/2] dt-bindings: backlight: lm3630a: add enable_gpios
To:     Andreas Kemnade <andreas@kemnade.info>, <lee.jones@linaro.org>,
        <daniel.thompson@linaro.org>, <jingoohan1@gmail.com>,
        <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <b.zolnierkie@samsung.com>,
        <dri-devel@lists.freedesktop.org>, <linux-leds@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-fbdev@vger.kernel.org>,
        "H. Nikolaus Schaller" <hns@goldelico.com>
References: <20190911172106.12843-1-andreas@kemnade.info>
 <20190911172106.12843-2-andreas@kemnade.info>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <ff410d6c-e1e8-7c96-e8f7-0a0deb816f6a@ti.com>
Date:   Thu, 12 Sep 2019 06:39:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190911172106.12843-2-andreas@kemnade.info>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas

On 9/11/19 12:21 PM, Andreas Kemnade wrote:
> add enable-gpios to describe HWEN pin
>
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
> changes in v2: added example
> changes in v3: added Acked-by
>   .../bindings/leds/backlight/lm3630a-backlight.yaml           | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml
> index dc129d9a329e..1fa83feffe16 100644
> --- a/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml
> +++ b/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml
> @@ -29,6 +29,10 @@ properties:
>     '#size-cells':
>       const: 0
>   
> +  enable-gpios:
> +    description: GPIO to use to enable/disable the backlight (HWEN pin).
> +    maxItems: 1
> +
>   required:
>     - compatible
>     - reg
> @@ -92,6 +96,7 @@ examples:
>       i2c {
>           #address-cells = <1>;
>           #size-cells = <0>;
> +        enable-gpios = <&gpio2 5 GPIO_ACTIVE_HIGH>;
>   
>           led-controller@38 {
>                   compatible = "ti,lm3630a";

Looks good to me

Reviewed-by: Dan Murphy <dmurphy@ti.com>

