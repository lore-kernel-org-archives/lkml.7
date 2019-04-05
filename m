Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E68EC10F0F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CC712186A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:48:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="iRD+N1lP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730587AbfDELsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 07:48:52 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:37486 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbfDELsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 07:48:51 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x35Bml7Q128080;
        Fri, 5 Apr 2019 06:48:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554464927;
        bh=2raMo1Ue8ZxcSai8F+CrgsRobZNAmlPCa+oX274RPE0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=iRD+N1lPPSX+BGJTH/aQRJdy6qV45l2nFBEZnMFyIUDDCLPOKFHus2sgWPRaix/xo
         LzcgU4hdc2suxqfYgyeNjK33iNDV+dwJmCYjmP/42x2KEDkejmmSP2gV/Vfutg9BNj
         Mai5tNeSqZ6pK4G+4aPR1VIhpGUtIdK37GimYYCw=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x35BmlRg084683
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 5 Apr 2019 06:48:47 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 5 Apr
 2019 06:48:47 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 5 Apr 2019 06:48:47 -0500
Received: from [172.22.78.91] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x35Bmk9g028552;
        Fri, 5 Apr 2019 06:48:47 -0500
Subject: Re: [PATCH v3 14/25] dt-bindings: lm36010: Add function and color
 properties
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        <linux-leds@vger.kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <pavel@ucw.cz>, <robh@kernel.org>
References: <20190331175501.23471-1-jacek.anaszewski@gmail.com>
 <20190331175501.23471-15-jacek.anaszewski@gmail.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <adf1f4fe-6a23-4244-db71-b5c3dbcf9615@ti.com>
Date:   Fri, 5 Apr 2019 06:48:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190331175501.23471-15-jacek.anaszewski@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jacek

On 3/31/19 12:54 PM, Jacek Anaszewski wrote:
> Refer to new "function" and "color" properties and mark "label"
> as deprecated.
> 
> Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> Cc: Dan Murphy <dmurphy@ti.com>
> ---
>  Documentation/devicetree/bindings/leds/leds-lm3601x.txt | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/leds/leds-lm3601x.txt b/Documentation/devicetree/bindings/leds/leds-lm3601x.txt
> index a88b2c41e75b..095dafb6ec7f 100644
> --- a/Documentation/devicetree/bindings/leds/leds-lm3601x.txt
> +++ b/Documentation/devicetree/bindings/leds/leds-lm3601x.txt
> @@ -22,9 +22,14 @@ Required properties for flash LED child nodes:
>  	- led-max-microamp : Range from 2.4mA - 376mA
>  
>  Optional child properties:
> -	- label : see Documentation/devicetree/bindings/leds/common.txt
> +	- function : see Documentation/devicetree/bindings/leds/common.txt
> +	- color : see Documentation/devicetree/bindings/leds/common.txt
> +	- label : see Documentation/devicetree/bindings/leds/common.txt (deprecated)
>  
>  Example:
> +
> +#include <dt-bindings/leds/common.h>
> +
>  led-controller@64 {
>  	compatible = "ti,lm36010";
>  	#address-cells = <1>;
> @@ -33,7 +38,8 @@ led-controller@64 {
>  
>  	led@0 {
>  		reg = <1>;
> -		label = "white:torch";
> +		function = LED_FUNCTION_TORCH;
> +		color = <LED_COLOR_ID_WHITE>;
>  		led-max-microamp = <376000>;
>  		flash-max-microamp = <1500000>;
>  		flash-max-timeout-us = <1600000>;
> 

Reviewed-by: Dan Murphy <dmurphy@ti.com>

-- 
------------------
Dan Murphy
