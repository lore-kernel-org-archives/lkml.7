Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 867B8C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F8682186A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Ign21MZW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730512AbfDELsT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 07:48:19 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:37374 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfDELsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 07:48:18 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x35BmFNY127751;
        Fri, 5 Apr 2019 06:48:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554464895;
        bh=GU+MpCA8+Z2sWYX9oR6SV2RkS3/nywrbvgWs+ruKCao=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Ign21MZW6Jdhfyyn2m6feGq6nBMrvjOHScxO/PNvZEk7L2DVQxlVtXIxUYkQcLTa/
         WNdj559RN24kSB/LfNROZaf/WnT75YfADg2Jlr7ASnuNizc0UmEp0AjAfV5/gDyVrN
         ATHlWOYLaJlMoXeOcICCeW2gYexSYGhQ1EvW7M0c=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x35BmFIX079652
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 5 Apr 2019 06:48:15 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 5 Apr
 2019 06:48:15 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 5 Apr 2019 06:48:15 -0500
Received: from [172.22.78.91] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x35BmEun022397;
        Fri, 5 Apr 2019 06:48:15 -0500
Subject: Re: [PATCH v3 12/25] dt-bindings: lm3692x: Add function and color
 properties
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        <linux-leds@vger.kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <pavel@ucw.cz>, <robh@kernel.org>
References: <20190331175501.23471-1-jacek.anaszewski@gmail.com>
 <20190331175501.23471-13-jacek.anaszewski@gmail.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <a2c1bee1-cce0-fd1a-bd4a-9b3390dc63e0@ti.com>
Date:   Fri, 5 Apr 2019 06:48:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190331175501.23471-13-jacek.anaszewski@gmail.com>
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
>  Documentation/devicetree/bindings/leds/leds-lm3692x.txt | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/leds/leds-lm3692x.txt b/Documentation/devicetree/bindings/leds/leds-lm3692x.txt
> index 08b352840bd7..4c2d923f8758 100644
> --- a/Documentation/devicetree/bindings/leds/leds-lm3692x.txt
> +++ b/Documentation/devicetree/bindings/leds/leds-lm3692x.txt
> @@ -26,12 +26,16 @@ Required child properties:
>  		3 - Will enable the LED3 sync (LM36923 only)
>  
>  Optional child properties:
> -	- label : see Documentation/devicetree/bindings/leds/common.txt
> +	- function : see Documentation/devicetree/bindings/leds/common.txt
> +	- color : see Documentation/devicetree/bindings/leds/common.txt
> +	- label : see Documentation/devicetree/bindings/leds/common.txt (deprecated)
>  	- linux,default-trigger :
>  	   see Documentation/devicetree/bindings/leds/common.txt
>  
>  Example:
>  
> +#include <dt-bindings/leds/common.h>
> +
>  led-controller@36 {
>  	compatible = "ti,lm3692x";
>  	reg = <0x36>;
> @@ -43,7 +47,8 @@ led-controller@36 {
>  
>  	led@0 {
>  		reg = <0>;
> -		label = "white:backlight_cluster";
> +		function = LED_FUNCTION_BACKLIGHT;
> +		color = <LED_COLOR_ID_WHITE>;
>  		linux,default-trigger = "backlight";
>  	};
>  }
> 

Reviewed-by: Dan Murphy <dmurphy@ti.com>

-- 
------------------
Dan Murphy
