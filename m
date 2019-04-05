Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F34C10F0F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 01:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EF5B217D6
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 01:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="e4AOwV2W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730505AbfDEBLx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 21:11:53 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:43642 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730335AbfDEBLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 21:11:52 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x351BP61108213;
        Thu, 4 Apr 2019 20:11:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554426685;
        bh=ONCTjnaJiqFp3Buz0U41D3loWM6yqRLMRDv2UE2iGAI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=e4AOwV2W8qinHDqHIixun8l1FGejRs88qujW++N+dT+iBxOWne7+REUk6++Nsevlq
         VWV0x2vyXc+8xiEy0od0xzuOsQ5cDA45vOHdx78QNmorF2CLU6d5ubUEld8DzZHoAZ
         m9lCJw+UDspbemDeXRlt5NBxfdckE1Cu+nIdkc6c=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x351BORi097114
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 4 Apr 2019 20:11:24 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 4 Apr
 2019 20:11:24 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 4 Apr 2019 20:11:24 -0500
Received: from [172.22.84.10] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x351BO5q073623;
        Thu, 4 Apr 2019 20:11:24 -0500
Subject: Re: [PATCH v3 02/25] dt-bindings: leds: Add LED_FUNCTION definitions
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
References: <20190331175501.23471-1-jacek.anaszewski@gmail.com>
 <20190331175501.23471-3-jacek.anaszewski@gmail.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <c7c92db0-55e5-afba-c8ab-66e221b48b82@ti.com>
Date:   Thu, 4 Apr 2019 20:11:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190331175501.23471-3-jacek.anaszewski@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/31/19 12:54 PM, Jacek Anaszewski wrote:
> Add initial set of common LED function definitions for use in Device Tree.
> 
> Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> Cc: Baolin Wang <baolin.wang@linaro.org>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Dan Murphy <dmurphy@ti.com>
> Cc: Daniel Mack <daniel@zonque.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Oleh Kravchenko <oleg@kaa.org.ua>
> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
> Cc: Simon Shields <simon@lineageos.org>
> ---
>  include/dt-bindings/leds/common.h | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/include/dt-bindings/leds/common.h b/include/dt-bindings/leds/common.h
> index e171d0a6beb2..0325db5b4208 100644
> --- a/include/dt-bindings/leds/common.h
> +++ b/include/dt-bindings/leds/common.h
> @@ -19,4 +19,40 @@
>  #define LEDS_BOOST_ADAPTIVE	1
>  #define LEDS_BOOST_FIXED	2
>  
> +/* Standard LED functions */
> +#define LED_FUNCTION_ACTIVITY "activity"
> +#define LED_FUNCTION_ALARM "alarm"
> +#define LED_FUNCTION_BACKLIGHT "backlight"
> +#define LED_FUNCTION_BLUETOOTH "bluetooth"
> +#define LED_FUNCTION_BOOT "boot"
> +#define LED_FUNCTION_CHARGE "charge"
> +#define LED_FUNCTION_DEBUG "debug"
> +#define LED_FUNCTION_DISK "disk"
> +#define LED_FUNCTION_DISK_ERR "disk-err"
> +#define LED_FUNCTION_DISK_READ "disk-read"
> +#define LED_FUNCTION_DISK_WRITE "disk-write"
> +#define LED_FUNCTION_FAULT "fault"
> +#define LED_FUNCTION_FLASH "flash"
> +#define LED_FUNCTION_HEARTBEAT "heartbeat"
> +#define LED_FUNCTION_INDICATOR "indicator"
> +#define LED_FUNCTION_KEYBOARD "keyboard"
> +#define LED_FUNCTION_KEYPAD "keypad"
> +#define LED_FUNCTION_LAN "lan"
> +#define LED_FUNCTION_MMC "mmc"
> +#define LED_FUNCTION_NAND "nand"
> +#define LED_FUNCTION_ON "on"
> +#define LED_FUNCTION_PROGRAMMING "programming"
> +#define LED_FUNCTION_POWER "power"
> +#define LED_FUNCTION_RX "rx"
> +#define LED_FUNCTION_SD "sd"
> +#define LED_FUNCTION_STANDBY "standby"
> +#define LED_FUNCTION_STATUS "status"
> +#define LED_FUNCTION_TORCH "torch"
> +#define LED_FUNCTION_TV "tv"
> +#define LED_FUNCTION_TX "tx"
> +#define LED_FUNCTION_USB "usb"
> +#define LED_FUNCTION_WAN "wan"
> +#define LED_FUNCTION_WLAN "wlan"
> +#define LED_FUNCTION_WPS "wps"
> +
>  #endif /* __DT_BINDINGS_LEDS_H */
> 

Reviewed-by: Dan Murphy <dmurphy@ti.com>

-- 
------------------
Dan Murphy
