Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C1FEC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB651206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xXSi99xc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbfDZJWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 05:22:18 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:41616 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbfDZJWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 05:22:18 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3Q9LmIR001986;
        Fri, 26 Apr 2019 04:21:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1556270508;
        bh=VyXYxD4fbj7rUbLL6lHmAhTf/6H+ZPPErE3fxz6npcI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=xXSi99xcdMMx6X3LYTYTXC/vX9tJ88qT+YIr46bs2dVLy3wOUATYhC7UheCKWYN8e
         dFwwSfp2JUvzhUflNeTDaMSXqjp7aGGrqWqgV4USwS9hXekQyIaG0ZscJ2wdCwQ5ES
         pG5BFVhrYDYJTNj3MQp6psRxgIqKCnm5ORtZuBKY=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3Q9LmMl115912
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 26 Apr 2019 04:21:48 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 26
 Apr 2019 04:21:47 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 26 Apr 2019 04:21:47 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3Q9Lhd7124413;
        Fri, 26 Apr 2019 04:21:44 -0500
Subject: Re: [PATCH v6 1/6] dt-bindings: add binding for USBSS-DRD controller.
To:     Pawel Laszczak <pawell@cadence.com>, <devicetree@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <felipe.balbi@linux.intel.com>,
        <mark.rutland@arm.com>, <linux-usb@vger.kernel.org>,
        <hdegoede@redhat.com>, <heikki.krogerus@linux.intel.com>,
        <andy.shevchenko@gmail.com>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <jbergsagel@ti.com>,
        <nsekhar@ti.com>, <nm@ti.com>, <sureshp@cadence.com>,
        <peter.chen@nxp.com>, <kurahul@cadence.com>
References: <1554882504-9010-1-git-send-email-pawell@cadence.com>
 <1554882504-9010-2-git-send-email-pawell@cadence.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <d7ca7260-9337-0779-459b-bfed15113db0@ti.com>
Date:   Fri, 26 Apr 2019 12:21:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1554882504-9010-2-git-send-email-pawell@cadence.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pawel,

On 10/04/2019 10:48, Pawel Laszczak wrote:
> This patch aim at documenting USB related dt-bindings for the
> Cadence USBSS-DRD controller.
> 
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> 
> ---
>  .../devicetree/bindings/usb/cdns-usb3.txt     | 30 +++++++++++++++++++
>  1 file changed, 30 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/cdns-usb3.txt
> 
> diff --git a/Documentation/devicetree/bindings/usb/cdns-usb3.txt b/Documentation/devicetree/bindings/usb/cdns-usb3.txt
> new file mode 100644
> index 000000000000..1d2b449e3cb4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/cdns-usb3.txt
> @@ -0,0 +1,30 @@
> +Binding for the Cadence USBSS-DRD controller
> +
> +Required properties:
> +  - reg: Physical base address and size of the controller's register areas.
> +	 Controller has 3 different regions:
> +	 region 1 - HOST registers area
> +	 region 2 - DEVICE registers area
> +	 region 3 - OTG/DRD registers area
> +  - reg-names - register memory area names:
> +	"xhci" - for HOST registers space
> +	"dev" - for DEVICE registers space
> +	"otg" - for OTG/DRD registers space
> +  - compatible: Should contain: "cdns,usb3-1.0.0" or "cdns,usb3-1.0.1"
> +  - interrupts: Interrupts used by cdns3 controller.
> +
> +Optional properties:
> + - maximum-speed : valid arguments are "super-speed", "high-speed" and
> +                   "full-speed"; refer to usb/generic.txt
> + - dr_mode: Should be one of "host", "peripheral" or "otg".
> + - phys: reference to the USB PHY

In your test platform is this a 2.0PHY or 3.0PHY? Typical platforms will have both.
Is there any power-on sequencing requirements for powering up these PHYs vs powering up the controller?

> +
> +Example:
> +	usb@f3000000 {
> +		compatible = "cdns,usb3-1.0.1";
> +		interrupts = <USB_IRQ  7 IRQ_TYPE_LEVEL_HIGH>;
> +		reg = <0xf3000000 0x10000	/* memory area for HOST registers */
> +			0xf3010000 0x10000	/* memory area for DEVICE registers */
> +			0xf3020000 0x10000>;	/* memory area for OTG/DRD registers */
> +		reg-names = "xhci", "dev", "otg";
> +	};
> 

-- 
cheers,
-roger
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
