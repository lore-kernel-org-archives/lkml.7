Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B4CC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 116B92186A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ScOJu+Io"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729994AbfDELsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 07:48:03 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:59222 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbfDELsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 07:48:03 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x35BlxLR018470;
        Fri, 5 Apr 2019 06:47:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554464879;
        bh=h+lKNV/tyP7GgAYGMMmtMgrqmcB1TwERoQ2EC30aoAo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ScOJu+IodmOn0gqgdHSl706CSSi9CNNGTE7G9SwYqi2NQq7lrYT99w65oNx0RheiT
         GSr8/IIOrMgNK9T+a3rnxPqdHBbf1jv3/rIb3m2uc0EkLcyYzVObe+qw5ZK3JPyHD5
         yJlD9ysei+veXm6Mw2+vezTQ1oSvF0Slc27hGIHM=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x35BlxMq068211
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 5 Apr 2019 06:47:59 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 5 Apr
 2019 06:47:59 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 5 Apr 2019 06:47:59 -0500
Received: from [172.22.78.91] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x35Blwb4026676;
        Fri, 5 Apr 2019 06:47:59 -0500
Subject: Re: [PATCH v3 10/25] dt-bindings: lp8860: Add function and color
 properties
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        <linux-leds@vger.kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <pavel@ucw.cz>, <robh@kernel.org>
References: <20190331175501.23471-1-jacek.anaszewski@gmail.com>
 <20190331175501.23471-11-jacek.anaszewski@gmail.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <ed50b431-eaec-0470-649b-4fc50801a075@ti.com>
Date:   Fri, 5 Apr 2019 06:47:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190331175501.23471-11-jacek.anaszewski@gmail.com>
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
>  Documentation/devicetree/bindings/leds/leds-lp8860.txt | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/leds/leds-lp8860.txt b/Documentation/devicetree/bindings/leds/leds-lp8860.txt
> index 5f0e892ad759..9863220db4ba 100644
> --- a/Documentation/devicetree/bindings/leds/leds-lp8860.txt
> +++ b/Documentation/devicetree/bindings/leds/leds-lp8860.txt
> @@ -20,12 +20,16 @@ Required child properties:
>  	- reg : 0
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
>  led-controller@2d {
>  	compatible = "ti,lp8860";
>  	#address-cells = <1>;
> @@ -36,7 +40,8 @@ led-controller@2d {
>  
>  	led@0 {
>  		reg = <0>;
> -		label = "white:backlight";
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
