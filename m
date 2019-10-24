Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C41FCA9EBC
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 10:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 421512084C
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 10:17:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OrB2X0i9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393262AbfJXKRc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 06:17:32 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:56684 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393238AbfJXKRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 06:17:31 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9OAGrZv062102;
        Thu, 24 Oct 2019 05:16:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571912213;
        bh=EDshKvGHmjEvne+M6Hf6EnpsTzXcgkgN/NsvR3Me/fA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=OrB2X0i9vOq6STYWMQhlOd7VV5xFv+QVlwTG1BAPg777P1hzOCNNZhelH9YhXYCOQ
         lg1j5kiGCgOF3IDjWqkCya4vuWdak+qw8hK5rFVOpJyMKx/Kp2NE9XeuzJmbiElybP
         H65Rde5K804+tD8617dKMLFIkhVh6k0S6ftkivYs=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9OAGr9w004417
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Oct 2019 05:16:53 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 24
 Oct 2019 05:16:43 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 24 Oct 2019 05:16:43 -0500
Received: from [192.168.2.14] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9OAGose119563;
        Thu, 24 Oct 2019 05:16:51 -0500
Subject: Re: [PATCH v2 1/2] dt-bindings: usb: Add binding for the TI wrapper
 for Cadence USB3 controller
To:     <felipe.balbi@linux.intel.com>, <gregkh@linuxfoundation.org>
CC:     <pawell@cadence.com>, <peter.chen@nxp.com>, <nsekhar@ti.com>,
        <kurahul@cadence.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Rob Herring <robh@kernel.org>
References: <20191021131305.8689-1-rogerq@ti.com>
 <20191021131305.8689-2-rogerq@ti.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <3fdcbd1f-f9e2-2363-56f4-30d2f8ea4560@ti.com>
Date:   Thu, 24 Oct 2019 13:16:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191021131305.8689-2-rogerq@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 21/10/2019 16:13, Roger Quadros wrote:
> TI platforms have a wrapper module around the Cadence USB3
> controller. Add binding information for that.

Please ignore this. I missed converting this to yaml format.
Will send v3.

cheers,
-roger
> 
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> ---
>   .../devicetree/bindings/usb/ti,j721e-usb.txt  | 52 +++++++++++++++++++
>   1 file changed, 52 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/usb/ti,j721e-usb.txt
> 
> diff --git a/Documentation/devicetree/bindings/usb/ti,j721e-usb.txt b/Documentation/devicetree/bindings/usb/ti,j721e-usb.txt
> new file mode 100644
> index 000000000000..bac57c26b09b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/ti,j721e-usb.txt
> @@ -0,0 +1,52 @@
> +Binding for the TI specific wrapper for the Cadence USBSS-DRD controller
> +
> +Required properties:
> +  - compatible: Should contain "ti,j721e-usb"
> +  - reg: Physical base address and size of the wrappers register area.
> +  - power-domains: Should contain a phandle to a PM domain provider node
> +                   and an args specifier containing the USB device id
> +                   value. This property is as per the binding documentation:
> +                   Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
> +  - clocks: Clock phandles to usb2_refclk and lpm_clk
> +  - clock-names: Should contain "ref" and "lpm"
> +
> +Optional properties:
> + - ti,usb2-only: If present, it restricts the controller to USB2.0 mode of
> +		 operation. Must be present if USB3 PHY is not available
> +		 for USB.
> + - ti,vbus-divider: Should be present if USB VBUS line is connected to the
> +		 VBUS pin of the SoC via a 1/3 voltage divider.
> +
> +Sub-nodes:
> +The USB2 PHY and the Cadence USB3 controller should be the sub-nodes.
> +
> +Example:
> +
> +	ti_usb0: cdns_usb@4104000 {
> +		compatible = "ti,j721e-usb";
> +		reg = <0x00 0x4104000 0x00 0x100>;
> +		power-domains = <&k3_pds 288 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 288 15>, <&k3_clks 288 3>;
> +		clock-names = "ref", "lpm";
> +		assigned-clocks = <&k3_clks 288 15>;	/* USB2_REFCLK */
> +		assigned-clock-parents = <&k3_clks 288 16>; /* HFOSC0 */
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		usb0: usb@6000000 {
> +			compatible = "cdns,usb3";
> +			reg = <0x00 0x6000000 0x00 0x10000>,
> +			      <0x00 0x6010000 0x00 0x10000>,
> +			      <0x00 0x6020000 0x00 0x10000>;
> +			reg-names = "otg", "xhci", "dev";
> +			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,	/* irq.0 */
> +				     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,	/* irq.6 */
> +				     <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;	/* otgirq.0 */
> +			interrupt-names = "host",
> +					  "peripheral",
> +					  "otg";
> +			maximum-speed = "super-speed";
> +			dr_mode = "otg";
> +		};
> +	};
> 

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
