Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29983C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 12:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E72F32070B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 12:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="r1DfGkAV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbfFFMJk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 08:09:40 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:52876 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726581AbfFFMJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 08:09:40 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x56C91JO022739;
        Thu, 6 Jun 2019 07:09:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1559822941;
        bh=qcyIk2SJUn0ZdZwR3JN8S2jqhxldDWKzw9rcIaBM9CY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=r1DfGkAVMqtciddhXYiHl8QMDCTU/qQpAicziLVILpa8KpKMbqfJui+zeGvjT4GhI
         SRIUt7L4kK40Egrm6VBGerre2yXhaPVNVfse9pVcPFFgH48VDmZQS81BByHg2rQ+AW
         Ur+7hqcX1lzzJRn97RNTxSDJFv61OFNPHcT3PnlA=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x56C910S073346
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 6 Jun 2019 07:09:01 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 6 Jun
 2019 07:09:00 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 6 Jun 2019 07:09:00 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x56C8u4P076209;
        Thu, 6 Jun 2019 07:08:56 -0500
Subject: Re: [PATCH v7 1/6] dt-bindings: add binding for USBSS-DRD controller.
To:     Pawel Laszczak <pawell@cadence.com>, <devicetree@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <felipe.balbi@linux.intel.com>,
        <linux-usb@vger.kernel.org>, <hdegoede@redhat.com>,
        <heikki.krogerus@linux.intel.com>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <jbergsagel@ti.com>,
        <nsekhar@ti.com>, <nm@ti.com>, <sureshp@cadence.com>,
        <peter.chen@nxp.com>, <jpawar@cadence.com>, <kurahul@cadence.com>
References: <1559729030-16390-1-git-send-email-pawell@cadence.com>
 <1559729030-16390-2-git-send-email-pawell@cadence.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <f032b3f3-409d-b0fc-8d5f-01c898b4c7a7@ti.com>
Date:   Thu, 6 Jun 2019 15:08:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1559729030-16390-2-git-send-email-pawell@cadence.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pawel,

On 05/06/2019 13:03, Pawel Laszczak wrote:
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

Since we are requesting 3 separate named interrupts in code we need to
mention them here.

> +
> +Optional properties:
> + - maximum-speed : valid arguments are "super-speed", "high-speed" and
> +                   "full-speed"; refer to usb/generic.txt
> + - dr_mode: Should be one of "host", "peripheral" or "otg".
> + - phys: reference to the USB PHY
> +
> +Example:
> +	usb@f3000000 {
> +		compatible = "cdns,usb3-1.0.1";
> +		interrupts = <USB_IRQ  7 IRQ_TYPE_LEVEL_HIGH>;

This example won't work as code requests for 3 separate interrupts.

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
