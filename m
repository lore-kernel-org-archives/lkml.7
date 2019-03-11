Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2508C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 12:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B267420657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 12:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="AeFfzUqE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbfCKMXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 08:23:38 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:60706 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbfCKMXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 08:23:38 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2BCNP0g012151;
        Mon, 11 Mar 2019 07:23:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1552307005;
        bh=w0jduIkoqusdafGy3NhLuD9I1bsNYZOTkeQ0/5MvSsE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=AeFfzUqERl/m+5h28AJY0JRkHwYYaHSoG7FZU8exUTBP60WTX3x8N69FB7oMx0qyY
         rKJlWDPh8V6jRp6qfDzSFqOqdlQELuKVHqPhRLBNwwywpu5X+NMVhx1zTKHswQIOkF
         wdGsL20Oy7VSzo81HqGKRk83vJaqKAZmC0fVMfSg=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2BCNPEf002102
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Mar 2019 07:23:25 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 11
 Mar 2019 07:23:25 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 11 Mar 2019 07:23:25 -0500
Received: from [172.22.80.120] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2BCNOXQ019689;
        Mon, 11 Mar 2019 07:23:24 -0500
Subject: Re: [PATCH 04/25] dt-bindings: leds: Add LED_COLOR_NAME definitions
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        <linux-leds@vger.kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <pavel@ucw.cz>, <robh@kernel.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        Daniel Mack <daniel@zonque.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Oleh Kravchenko <oleg@kaa.org.ua>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Simon Shields <simon@lineageos.org>
References: <20190310182836.20841-1-jacek.anaszewski@gmail.com>
 <20190310182836.20841-5-jacek.anaszewski@gmail.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <4b4b5109-2da3-a74f-7e77-c4ab4d34ecbc@ti.com>
Date:   Mon, 11 Mar 2019 07:23:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190310182836.20841-5-jacek.anaszewski@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jacek

On 3/10/19 1:28 PM, Jacek Anaszewski wrote:
> Add common LED color name definitions for use in Device Tree.
> 
> Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> Cc: Baolin Wang <baolin.wang@linaro.org>
> Cc: Daniel Mack <daniel@zonque.org>
> Cc: Dan Murphy <dmurphy@ti.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Oleh Kravchenko <oleg@kaa.org.ua>
> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
> Cc: Simon Shields <simon@lineageos.org>
> ---
>  include/dt-bindings/leds/common.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/include/dt-bindings/leds/common.h b/include/dt-bindings/leds/common.h
> index ffcd46317307..0e986bb59391 100644
> --- a/include/dt-bindings/leds/common.h
> +++ b/include/dt-bindings/leds/common.h
> @@ -57,4 +57,13 @@
>  #define LED_FUNCTION_WLAN "wlan"
>  #define LED_FUNCTION_WPS "wps"
>  
> +/* Standard LED colors */
> +#define LED_COLOR_NAME_WHITE    "white"
> +#define LED_COLOR_NAME_RED      "red"
> +#define LED_COLOR_NAME_GREEN    "green"
> +#define LED_COLOR_NAME_BLUE     "blue"
> +#define LED_COLOR_NAME_AMBER    "amber"
> +#define LED_COLOR_NAME_VIOLET   "violet"
> +#define LED_COLOR_NAME_YELLOW   "yellow"
> +

#define LED_COLOR_NAME_INFRARED	"ir"

Dan

>  #endif /* __DT_BINDINGS_LEDS_H */
> 


-- 
------------------
Dan Murphy
