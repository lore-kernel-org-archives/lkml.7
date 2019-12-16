Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A2BC2D0CF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 06:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E23622522
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 06:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Z0gKGAM/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbfLPG2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 01:28:30 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:8291 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbfLPG2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 01:28:30 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5df724030000>; Sun, 15 Dec 2019 22:28:19 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 15 Dec 2019 22:28:27 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 15 Dec 2019 22:28:27 -0800
Received: from [10.24.193.46] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 16 Dec
 2019 06:28:24 +0000
Subject: Re: [PATCH 02/18] dt-bindings: usb: Add NVIDIA Tegra XUSB device mode
 controller binding
To:     Rob Herring <robh@kernel.org>
CC:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mark.rutland@arm.com>, <kishon@ti.com>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1575629421-7039-1-git-send-email-nkristam@nvidia.com>
 <1575629421-7039-3-git-send-email-nkristam@nvidia.com>
 <20191213184552.GA2133@bogus>
X-Nvconfidentiality: public
From:   Nagarjuna Kristam <nkristam@nvidia.com>
Message-ID: <d78fe56f-4ad2-085d-ba10-174fd1b53107@nvidia.com>
Date:   Mon, 16 Dec 2019 12:00:09 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191213184552.GA2133@bogus>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1576477699; bh=zMJg7pOlVNQuvjr7hzUODavsNLTw1Fqs1KEUhAruvWE=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Z0gKGAM/qIslQHc6Hd2xCG8gNzW7+9QzaAupOEK+/ei5AihEYR7KNylxeym89vOwk
         W434yKwjoKpgUgmuQfFRyXxEVW+XbuD++UR5ktqcGrpCF+n0BdaIUJ8HXFzTkU6060
         Ox0sdoM0gmDdXsdHRDRpAoP6uvhQVq57rkThH1HUxshV+0kkqaGZTiQCS/mpaGdfPA
         ZAGbeV71Yk2CP5dJiHqCHsHd2AFA4ehfXlGYP5PzKb+cZWMCrqfTyDLGcbe9cPD1pK
         iD+mLsIeTiT4a0gmcgATb5Ijxa2ct61iis0qW/P9nig1ubb75SUdX2BjeaAqo7wUmO
         xostv4ViR02pQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> 
> On Fri, Dec 06, 2019 at 04:20:05PM +0530, Nagarjuna Kristam wrote:
>> Add device-tree binding documentation for the XUSB device mode controller
>> present on Tegra210 and Tegra186 SoC. This controller supports the USB 3.0
>> specification.
>>
>> Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
>> ---
> Next time version your patches correctly and include version history
> here so I don't have to go look up why my R-by is missing.
> 
Since this was a new series, i didnot add version history. But considering that this
was reviewed in different series, i will take a note to include the reviewed link
for quick reference.
>>  .../devicetree/bindings/usb/nvidia,tegra-xudc.yaml | 204 +++++++++++++++++++++
>>  1 file changed, 204 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/usb/nvidia,tegra-xudc.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/usb/nvidia,tegra-xudc.yaml b/Documentation/devicetree/bindings/usb/nvidia,tegra-xudc.yaml
>> new file mode 100644
>> index 0000000..b23c451
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/usb/nvidia,tegra-xudc.yaml
>> @@ -0,0 +1,204 @@
>> +# SPDX-License-Identifier: GPL-2.0
> Dual license new bindings please:
> 
> (GPL-2.0-only OR BSD-2-Clause)
> 
Will update accordingly.
>> +%YAML 1.2
>> +---
>> +$id: "http://devicetree.org/schemas/usb/nvidia,tegra-xudc.yaml#"
>> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
>> +
>> +title: Device tree binding for NVIDIA Tegra XUSB device mode controller (XUDC)
>> +
>> +description:
>> +  The Tegra XUDC controller supports both USB 2.0 HighSpeed/FullSpeed and
>> +  USB 3.0 SuperSpeed protocols.
>> +
>> +maintainers:
>> +  - Nagarjuna Kristam <nkristam@nvidia.com>
>> +  - JC Kuo <jckuo@nvidia.com>
>> +  - Thierry Reding <treding@nvidia.com>
>> +
>> +properties:
>> +  compatible:
>> +    oneOf:
>> +      - items:
>> +        - const: nvidia,tegra210-xudc # For Tegra210
>> +      - items:
>> +        - const: nvidia,tegra186-xudc # For Tegra186
> Use 'enum' instead of oneOf+const.
> 
Will update
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +    description: Must contain the XUSB device interrupt.
> Don't need a description for a single interrupt line.
> 
Will remove
>> +
>> +  power-domains:
>> +    maxItems: 2
>> +    description:
>> +      A list of PM domain specifiers that reference each power-domain
>> +      used by the XUSB device mode controller. This list must comprise of a
>> +      specifier for the XUSBA and XUSBB power-domains.
>> +      See ../power/power_domain.txt and ../arm/tegra/nvidia,tegra20-pmc.txt
>> +      for details.
> Just need:
> 
> items:
>   - description: XUSBA power-domain
>   - description: XUSBB power-domain
> 
Will update including below coments to update as below
   - description: XUSBA(superSpeed) power-domain
   - description: XUSBB(device) power-domain
>> +
>> +  power-domains-names:
>> +    maxItems: 2
>> +    description:
>> +       A list of names that represent each of the specifiers in
>> +       the 'power-domains' property.
> That's every 'power-domains-names'.
> 
>> +    items:
>> +      - const: ss
>> +      - const: dev
> Okay, but those names don't match up with XUSBA and XUSBB. Names should
> be meaningful or local to the module, not the provider if that helps.
> 
>> +
>> +  nvidia,xusb-padctl:
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>> +    description:
>> +      phandle to the XUSB pad controller that is used to configure the USB pads
>> +      used by the XUDC controller.
>> +
>> +  phys:
>> +    minItems: 1
>> +    description:
>> +      Must contain an entry for each entry in phy-names.
>> +      See ../phy/phy-bindings.txt for details.
>> +
>> +  phy-names:
>> +    minItems: 1
>> +    items:
>> +      - const: usb2-0
>> +      - const: usb2-1
>> +      - const: usb2-2
>> +      - const: usb2-3
>> +      - const: usb3-0
>> +      - const: usb3-1
>> +      - const: usb3-2
>> +      - const: usb3-3
>> +
>> +  avddio-usb-supply:
>> +    description: PCIe/USB3 analog logic power supply. Must supply 1.05 V.
>> +
>> +  hvdd-usb-supply:
>> +    description: USB controller power supply. Must supply 3.3 V.
>> +
>> +required:
>> +  - compatible
>> +  - power-domains
>> +  - power-domain-names
>> +  - nvidia,xusb-padctl
>> +  - phys
>> +  - phy-names
>> +
>> +allOf:
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          items:
>> +            const: nvidia,tegra210-xudc
>> +
>> +    then:
>> +      properties:
>> +        reg:
>> +          maxItems: 3
>> +          items:
>> +          - description: XUSB device controller registers
>> +          - description: XUSB device PCI Config registers
>> +          - description: XUSB device registers.
>> +        reg-names:
>> +          maxItems: 3
>> +          items:
>> +            - const: base
>> +            - const: fpci
>> +            - const: ipfs
> As these are a superset of tegra186, you can move this up and tegra186
> just needs to define 'maxItems: 2'.
> 
Will move Main definitions up and update these sections with minItems and maxItems
accordingly.
>> +        clocks:
>> +          description:
>> +            Must contain an entry for all clocks used. See ../clock/clock-bindings.txt
>> +            for details.
>> +          maxItems: 5
>> +          items:
>> +            - description: Clock to enable core XUSB dev clock.
>> +            - description: Clock to enable XUSB super speed clock.
>> +            - description: Clock to enable XUSB super speed dev clock.
>> +            - description: Clock to enable XUSB high speed dev clock.
>> +            - description: Clock to enable XUSB full speed dev clock.
>> +        clock-names:
>> +          items:
>> +           - const: dev
>> +           - const: ss
>> +           - const: ss_src
>> +           - const: hs_src
>> +           - const: fs_src
> I would re-order the last 2 entries so that you can do the same thing as
> I said for 'reg'.
> 
>> +      required:
>> +        - reg
>> +        - reg-names
>> +        - clocks
>> +        - clock-names
> No need for these to be under the if. They are always required and
> don't have to be where defined by 'properties'.
> 
Will move to main "required" section.
>> +        - avddio-usb-supply
>> +        - hvdd-usb-supply
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: nvidia,tegra186-xudc
>> +
>> +    then:
>> +      properties:
>> +        reg:
>> +          maxItems: 2
>> +          items:
>> +          - description: XUSB device controller registers
>> +          - description: XUSB device PCI Config registers
>> +        reg-names:
>> +          maxItems: 2
>> +          items:
>> +            - const: base
>> +            - const: fpci
>> +        clocks:
>> +          description:
>> +            Must contain an entry for all clocks used. See ../clock/clock-bindings.txt
>> +            for details.
>> +          maxItems: 4
>> +          items:
>> +            - description: Clock to enable core XUSB dev clock.
>> +            - description: Clock to enable XUSB super speed clock.
>> +            - description: Clock to enable XUSB super speed dev clock.
>> +            - description: Clock to enable XUSB full speed dev clock.
>> +        clock-names:
>> +          items:
>> +           - const: dev
>> +           - const: ss
>> +           - const: ss_src
>> +           - const: fs_src
>> +      required:
>> +        - reg
>> +        - reg-names
>> +        - clocks
>> +        - clock-names
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/tegra210-car.h>
>> +    #include <dt-bindings/gpio/tegra-gpio.h>
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +
>> +    usb@700d0000 {
>> +        compatible = "nvidia,tegra210-xudc";
>> +        reg = <0x0 0x700d0000 0x0 0x8000>,
>> +              <0x0 0x700d8000 0x0 0x1000>,
>> +              <0x0 0x700d9000 0x0 0x1000>;
>> +        reg-names = "base", "fpci", "ipfs";
>> +
>> +        interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
>> +
>> +        clocks = <&tegra_car TEGRA210_CLK_XUSB_DEV>,
>> +                 <&tegra_car TEGRA210_CLK_XUSB_SS>,
>> +                 <&tegra_car TEGRA210_CLK_XUSB_SSP_SRC>,
>> +                 <&tegra_car TEGRA210_CLK_XUSB_HS_SRC>,
>> +                 <&tegra_car TEGRA210_CLK_XUSB_FS_SRC>;
>> +        clock-names = "dev", "ss", "ss_src", "hs_src", "fs_src";
>> +
>> +        power-domains = <&pd_xusbdev>, <&pd_xusbss>;
>> +        power-domain-names = "dev", "ss";
>> +
>> +        nvidia,xusb-padctl = <&padctl>;
>> +
>> +        phys = <&micro_b>;
>> +        phy-names = "usb2-0";
>> +
>> +        avddio-usb-supply = <&vdd_pex_1v05>;
>> +        hvdd-usb-supply = <&vdd_3v3_sys>;
>> +    };
>> --
>> 2.7.4
>>
