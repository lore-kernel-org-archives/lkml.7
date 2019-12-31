Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E048EC3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 12:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F82A20730
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 12:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LcH9pTEa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbfLaMYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 07:24:24 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:37498 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbfLaMYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 07:24:24 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBVCOFdk005450;
        Tue, 31 Dec 2019 06:24:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1577795055;
        bh=PZA9GhYhs8LarFiwfTzIjeNL5AGq7okLWWyVj0WmWXc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=LcH9pTEa2a2DfgafJRun+2PEBDdaCh6cIG9rv3sQGmPZUssxV4gvGvBDCBPslcZZM
         M7dxlIe6BJnMJhKttUMBm2GEUtgUtmuG3RY7e8f3WP6Kz5WhZj5Ucnv4qsYPW1VRQd
         aSXaYX7V1Z3z3AqWn/L3GHnS7yGHSvKuwTjetCkM=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBVCOFLf025948;
        Tue, 31 Dec 2019 06:24:15 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 31
 Dec 2019 06:24:10 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 31 Dec 2019 06:24:10 -0600
Received: from [10.1.3.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBVCO833121376;
        Tue, 31 Dec 2019 06:24:08 -0600
Subject: Re: [PATCH v2 01/14] dt-bindings: phy: Convert Cadence MHDP PHY
 bindings to YAML.
To:     Yuti Amonkar <yamonkar@cadence.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <kishon@ti.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <maxime@cerno.tech>
CC:     <tomi.valkeinen@ti.com>, <praneeth@ti.com>, <mparab@cadence.com>,
        <sjakhade@cadence.com>
References: <1577114139-14984-1-git-send-email-yamonkar@cadence.com>
 <1577114139-14984-2-git-send-email-yamonkar@cadence.com>
From:   Jyri Sarha <jsarha@ti.com>
Autocrypt: addr=jsarha@ti.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <a96aef7e-7c6d-5152-2e14-bb803d206cba@ti.com>
Date:   Tue, 31 Dec 2019 14:24:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1577114139-14984-2-git-send-email-yamonkar@cadence.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/12/2019 17:15, Yuti Amonkar wrote:
> - Convert the MHDP PHY devicetree bindings to yaml schemas.
> - Rename DP PHY to have generic Torrent PHY nomrnclature.
> - Rename compatible string from "cdns,dp-phy" to "cdns,torrent-phy".
>   This will not affect ABI as the driver has never been functional,
>   and therefore do not exist in any active use case
> 
> Signed-off-by: Yuti Amonkar <yamonkar@cadence.com>
> ---
>  .../devicetree/bindings/phy/phy-cadence-dp.txt     | 30 ----------
>  .../bindings/phy/phy-cadence-torrent.yaml          | 64 ++++++++++++++++++++++
>  2 files changed, 64 insertions(+), 30 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/phy/phy-cadence-dp.txt
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-cadence-dp.txt b/Documentation/devicetree/bindings/phy/phy-cadence-dp.txt
> deleted file mode 100644
> index 7f49fd54e..0000000
> --- a/Documentation/devicetree/bindings/phy/phy-cadence-dp.txt
> +++ /dev/null
> @@ -1,30 +0,0 @@
> -Cadence MHDP DisplayPort SD0801 PHY binding
> -===========================================
> -
> -This binding describes the Cadence SD0801 PHY hardware included with
> -the Cadence MHDP DisplayPort controller.
> -
> --------------------------------------------------------------------------------
> -Required properties (controller (parent) node):
> -- compatible	: Should be "cdns,dp-phy"
> -- reg		: Defines the following sets of registers in the parent
> -		  mhdp device:
> -			- Offset of the DPTX PHY configuration registers
> -			- Offset of the SD0801 PHY configuration registers
> -- #phy-cells	: from the generic PHY bindings, must be 0.
> -
> -Optional properties:
> -- num_lanes	: Number of DisplayPort lanes to use (1, 2 or 4)
> -- max_bit_rate	: Maximum DisplayPort link bit rate to use, in Mbps (2160,
> -		  2430, 2700, 3240, 4320, 5400 or 8100)
> --------------------------------------------------------------------------------
> -
> -Example:
> -	dp_phy: phy@f0fb030a00 {
> -		compatible = "cdns,dp-phy";
> -		reg = <0xf0 0xfb030a00 0x0 0x00000040>,
> -		      <0xf0 0xfb500000 0x0 0x00100000>;
> -		num_lanes = <4>;
> -		max_bit_rate = <8100>;
> -		#phy-cells = <0>;
> -	};
> diff --git a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
> new file mode 100644
> index 0000000..3587312
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
> @@ -0,0 +1,64 @@
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/phy/phy-cadence-torrent.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Cadence Torrent SD0801 PHY binding for DisplayPort
> +
> +description:
> +  This binding describes the Cadence SD0801 PHY hardware included with
> +  the Cadence MHDP DisplayPort controller.
> +
> +maintainers:
> +  - Swapnil Jakhade <sjakhade@cadence.com>
> +  - Yuti Amonkar <yamonkar@cadence.com>
> +
> +properties:
> +  compatible:
> +    const: cdns,torrent-phy
> +
> +  reg:
> +    items:
> +      - description: Offset of the DPTX PHY configuration registers.

Isn't it possible to use torrent-phy in a configuration that does not
have dptx? Shouldn't the "dptx_phy" reg entry be optional?

BTW, I have no idea how to indicate in a yaml binding that some named
reg-entry is mandatory, and another is optional... anybody? Or is it
just something to explain in the description?

> +      - description: Offset of the SD0801 PHY configuration registers.
> +
> +  reg-names:
> +    items:
> +      - const: dptx_phy
> +      - const: sd0801_phy
> +
> +  "#phy-cells":
> +    const: 0
> +
> +  num_lanes:
> +    description:
> +      Number of DisplayPort lanes.
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - enum: [1, 2, 4]
> +
> +  max_bit_rate:
> +    description:
> +      Maximum DisplayPort link bit rate to use, in Mbps
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - enum: [2160, 2430, 2700, 3240, 4320, 5400, 8100]
> +
> +required:
> +  - compatible
> +  - reg

Shouldn't the reg-names be mandatory too?

> +  - "#phy-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    dp_phy: phy@f0fb030a00 {
> +          compatible = "cdns,torrent-phy";
> +          reg = <0xf0 0xfb030a00 0x0 0x00000040>,
> +                <0xf0 0xfb500000 0x0 0x00100000>;

There are no reg-names here?

> +          num_lanes = <4>;
> +          max_bit_rate = <8100>;
> +          #phy-cells = <0>;
> +    };
> +...
> 


-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
