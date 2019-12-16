Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 334B5C2D0CF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 09:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05AD0205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 09:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="E6/7j4g+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbfLPJx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 04:53:58 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:54922 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbfLPJx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 04:53:57 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBG9rqdk037242;
        Mon, 16 Dec 2019 03:53:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576490032;
        bh=+KyJuTpjDUe0N/qfxlbS5BhI2naVCWBHF8NYEFKw6CY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=E6/7j4g+rxc/ahxh+wVgMtneVHnMnya3pSbrCQyvFvxNzx5BYkRwgrgISvNdilJ3W
         R0R1LtVnm2dRHKj1m269TGflDY6WmX95eDddxAHMYerGepF1rywMiL2PxjsSKhHFb/
         wxsjGSGgHo0x7MchhcYfkNtxmNkibkH0dHPbMxp0=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBG9rqi3034014;
        Mon, 16 Dec 2019 03:53:52 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 16
 Dec 2019 03:53:51 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 16 Dec 2019 03:53:51 -0600
Received: from [10.24.69.159] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBG9rnZl105367;
        Mon, 16 Dec 2019 03:53:50 -0600
Subject: Re: [PATCH v3 13/14] dt-bindings: phy: Document WIZ (SERDES wrapper)
 bindings
To:     Rob Herring <robh@kernel.org>
CC:     Anil Varughese <aniljoy@cadence.com>,
        Roger Quadros <rogerq@ti.com>, Jyri Sarha <jsarha@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20191128104648.21894-1-kishon@ti.com>
 <20191128104648.21894-14-kishon@ti.com> <20191213210116.GA8975@bogus>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <b7b455b4-8001-a80b-6620-ae1df10e6047@ti.com>
Date:   Mon, 16 Dec 2019 15:25:07 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191213210116.GA8975@bogus>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 14/12/19 2:31 am, Rob Herring wrote:
> On Thu, Nov 28, 2019 at 04:16:47PM +0530, Kishon Vijay Abraham I wrote:
>> Add DT binding documentation for WIZ (SERDES wrapper). WIZ is *NOT* a
>> PHY but a wrapper used to configure some of the input signals to the
>> SERDES. It is used with both Sierra(16G) and Torrent(10G) serdes.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> [jsarha@ti.com: Add separate compatible for Sierra(16G) and Torrent(10G)
>>   SERDES]
>> Signed-off-by: Jyri Sarha <jsarha@ti.com>
>> ---
>>   .../bindings/phy/ti,phy-j721e-wiz.yaml        | 158 ++++++++++++++++++
>>   1 file changed, 158 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
>> new file mode 100644
>> index 000000000000..5cd6f907f6af
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
>> @@ -0,0 +1,158 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +# Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
>> +%YAML 1.2
>> +---
>> +$id: "http://devicetree.org/schemas/phy/ti,phy-j721e-wiz.yaml#"
>> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
>> +
>> +title: TI J721E WIZ (SERDES Wrapper)
>> +
>> +maintainers:
>> +  - Kishon Vijay Abraham I <kishon@ti.com>
>> +
>> +properties:
>> +  compatible:
>> +      enum:
>> +          - ti,j721e-wiz-16g
>> +          - ti,j721e-wiz-10g
>> +
>> +  power-domains:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    maxItems: 3
>> +    description: clock-specifier to represent input to the WIZ
>> +
>> +  clock-names:
>> +    items:
>> +      - const: fck
>> +      - const: core_ref_clk
>> +      - const: ext_ref_clk
>> +
>> +  num-lanes:
>> +    minimum: 1
>> +    maximum: 4
>> +
>> +  "#address-cells":
>> +    const: 1
>> +
>> +  "#size-cells":
>> +    const: 1
>> +
>> +  "#reset-cells":
>> +    const: 1
>> +
>> +  ranges: true
>> +
>> +  assigned-clocks:
>> +    maxItems: 2
>> +
>> +  assigned-clock-parents:
>> +    maxItems: 2
>> +
>> +patternProperties:
>> +  "^pll[0|1]_refclk$":
> 
> Use '-' rather than '_' in node names.
> 
>> +    type: object
>> +    description: |
>> +      WIZ node should have subnodes for each of the PLLs present in
>> +      the SERDES.
> 
> No properties in each of these nodes? They need to be defined.
> 
>> +
>> +  "^cmn_refclk1?_dig_div$":
>> +    type: object
>> +    description: |
>> +      WIZ node should have subnodes for each of the PMA common refclock
>> +      provided by the SERDES.
>> +
>> +  "^refclk_dig$":
>> +    type: object
>> +    description: |
>> +      WIZ node should have subnode for refclk_dig to select the reference
>> +      clock source for the reference clock used in the PHY and PMA digital
>> +      logic.
>> +
>> +  "^serdes@[0-9a-f]+$":
>> +    type: object
>> +    description: |
>> +      WIZ node should have '1' subnode for the SERDES. It could be either
>> +      Sierra SERDES or Torrent SERDES. Sierra SERDES should follow the
>> +      bindings specified in
>> +      Documentation/devicetree/bindings/phy/phy-cadence-sierra.txt
>> +      Torrent SERDES should follow the bindings specified in
>> +      Documentation/devicetree/bindings/phy/phy-cadence-dp.txt
>> +
>> +required:
>> +  - compatible
>> +  - power-domains
>> +  - clocks
>> +  - clock-names
>> +  - num-lanes
>> +  - "#address-cells"
>> +  - "#size-cells"
>> +  - "#reset-cells"
>> +  - ranges
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/soc/ti,sci_pm_domain.h>
>> +
>> +    wiz@5000000 {
>> +           compatible = "ti,j721e-wiz-16g";
>> +           #address-cells = <1>;
>> +           #size-cells = <1>;
>> +           power-domains = <&k3_pds 292 TI_SCI_PD_EXCLUSIVE>;
>> +           clocks = <&k3_clks 292 5>, <&k3_clks 292 11>, <&dummy_cmn_refclk>;
>> +           clock-names = "fck", "core_ref_clk", "ext_ref_clk";
>> +           assigned-clocks = <&k3_clks 292 11>, <&k3_clks 292 0>;
>> +           assigned-clock-parents = <&k3_clks 292 15>, <&k3_clks 292 4>;
>> +           num-lanes = <2>;
>> +           #reset-cells = <1>;
>> +           ranges = <0x5000000 0x0 0x5000000 0x10000>;
>> +
>> +           pll0_refclk {
>> +                  clocks = <&k3_clks 293 13>, <&dummy_cmn_refclk>;
>> +                  clock-output-names = "wiz1_pll0_refclk";
> 
> Kind of pointless with only 1 output.

Okay. I'll fix all your comments in v4.

Thanks
Kishon
