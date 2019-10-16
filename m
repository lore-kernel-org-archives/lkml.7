Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0726AFA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 09:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D25B020854
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 09:51:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HeMkc98q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392112AbfJPJvS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 05:51:18 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:53734 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729546AbfJPJvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 05:51:18 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9G9pB1C025774;
        Wed, 16 Oct 2019 04:51:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571219471;
        bh=P0xrDOLVQ/vankA69ekSgNkW1nIAIUG0Uxb4YWDc/OA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=HeMkc98qTYxa1FlugAOz1mMMT13HSrf0hBGKgz5ZkDkIxYz7Os/2IAWQKauxxTMwd
         UtNG5GuUyLAWf4J6+jfM5CPAkFGhLZlGMq7YQquY4MgfJjR5CI2UvT3xIhk4j3u2IY
         lLW8cwlaceIfW9Er8nKaJ6mhyBW8vbWT16l7OlAI=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9G9pBn1027303
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Oct 2019 04:51:11 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 16
 Oct 2019 04:51:03 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 16 Oct 2019 04:51:09 -0500
Received: from [192.168.2.14] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9G9p70c116258;
        Wed, 16 Oct 2019 04:51:08 -0500
Subject: Re: [PATCH 1/2] dt-bindings: usb: Add binding for the TI wrapper for
 Cadence USB3 controller
To:     Rob Herring <robh@kernel.org>
CC:     <felipe.balbi@linux.intel.com>, <gregkh@linuxfoundation.org>,
        <pawell@cadence.com>, <nsekhar@ti.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20191007114142.5182-1-rogerq@ti.com>
 <20191007114142.5182-2-rogerq@ti.com> <20191015212931.GA8031@bogus>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <06c2ecb0-74ce-5b34-9b71-d734706739d7@ti.com>
Date:   Wed, 16 Oct 2019 12:51:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191015212931.GA8031@bogus>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 16/10/2019 00:29, Rob Herring wrote:
> On Mon, Oct 07, 2019 at 02:41:41PM +0300, Roger Quadros wrote:
>> TI platforms have a wrapper module around the Cadence USB3
>> controller. Add binding information for that.
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
>> ---
>>   .../devicetree/bindings/usb/cdns-usb3-ti.txt  | 59 +++++++++++++++++++
>>   1 file changed, 59 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/usb/cdns-usb3-ti.txt
> 
> Please convert to DT schema.
> 
>> diff --git a/Documentation/devicetree/bindings/usb/cdns-usb3-ti.txt b/Documentation/devicetree/bindings/usb/cdns-usb3-ti.txt
>> new file mode 100644
>> index 000000000000..12c7c903e6da
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/usb/cdns-usb3-ti.txt
>> @@ -0,0 +1,59 @@
>> +Binding for the TI specific wrapper for the Cadence USBSS-DRD controller
>> +
>> +Required properties:
>> +  - compatible: Should contain "ti,j721e-usb"
>> +  - reg: Physical base address and size of the wrappers register area.
>> +  - power-domains: Should contain a phandle to a PM domain provider node
>> +                   and an args specifier containing the USB device id
>> +                   value. This property is as per the binding documentation:
>> +                   Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
>> +  - clocks: Clock phandles to usb2_refclk and lpm_clk
>> +  - clock-names: Should contain "usb2_refclk" and "lpm_clk"
> 
> _clk is redundant. 'ref' amd 'lpm' is sufficient.
> 
>> +
>> +Optional properties:
>> + - ti,usb2-only: If present, it restricts the controller to USB2.0 mode of
>> +		 operation. Must be present if USB3 PHY is not available
>> +		 for USB.
> 
> Seems like this should be discoverable based on describing the phy
> connections.

I don't think so. the PHY connections are in the child node.

> 
>> + - ti,modestrap-host: Set controller modestrap to HOST mode.
>> + - ti,modestrap-peripheral: Set controller modestrap to PERIPHERAL mode.
> 
> What does modestrap mean? Fixed to the mode or that's the default? For
> default, John Stultz sent a similar binding. Seems we need something
> common.

It means if the controller needs to be hard-wired (using a register bit)
to be either host or peripheral.

I think that this will not really be used so I'll get rid of it. It was mostly
used for initial debug.

The controller is dual-role and the role can be set to either host or peripheral
using the operational registers.

> 
>> + - ti,vbus-divider: Should be present if USB VBUS line is connected to the
>> +		 VBUS pin of the SoC via a 1/3 voltage divider.
>> +
>> +Sub-nodes:
>> +The USB2 PHY and the Cadence USB3 controller should be the sub-nodes.
>> +
>> +Example:
>> +
>> +	ti_usb0: cdns_usb@4104000 {
>> +		compatible = "ti,j721e-usb";
>> +		reg = <0x00 0x4104000 0x00 0x100>;
>> +		power-domains = <&k3_pds 288 TI_SCI_PD_EXCLUSIVE>;
>> +		clocks = <&k3_clks 288 15>, <&k3_clks 288 3>;
>> +		clock-names = "usb2_refclk", "lpm_clk";
>> +		assigned-clocks = <&k3_clks 288 15>;	/* USB2_REFCLK */
>> +		assigned-clock-parents = <&k3_clks 288 16>; /* HFOSC0 */
>> +		#address-cells = <2>;
>> +		#size-cells = <2>;
>> +		ranges;
>> +
>> +		phy@4108000 {
>> +			compatible = "ti,j721e-usb2-phy";
>> +			reg = <0x00 0x4108000 0x00 0x400>;
>> +		};
> 
> Why is this a child node? Use the phy binding.
> 

This is a USB2 PHY that physically sits within the ti_usb0 wrapper module that
controls power and clock to it.

There isn't a device driver required for it so should I just get rid of it?
Or can it just live there? what can the compatible be?
Or we can add it later if at all a driver is needed.

>> +
>> +		usb0: usb@6000000 {
>> +			compatible = "cdns,usb3-1.0.1";
> 
> Not documented.

should be
	compatible = "cdns,usb3";
> 
>> +			reg = <0x00 0x6000000 0x00 0x10000>,
>> +			      <0x00 0x6010000 0x00 0x10000>,
>> +			      <0x00 0x6020000 0x00 0x10000>;
>> +			reg-names = "otg", "xhci", "dev";
>> +			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,	/* irq.0 */
>> +				     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,	/* irq.6 */
>> +				     <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;	/* otgirq.0 */
>> +			interrupt-names = "host",
>> +					  "peripheral",
>> +					  "otg";
>> +			maximum-speed = "super-speed";
>> +			dr_mode = "otg";
>> +		};
>> +	};

-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
