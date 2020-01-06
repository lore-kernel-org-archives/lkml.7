Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E2EFC33C9A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 05:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15D392467E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 05:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Su0gWFZw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgAFFa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 00:30:58 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:46734 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgAFFa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 00:30:57 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0065UmVp123951;
        Sun, 5 Jan 2020 23:30:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1578288648;
        bh=l3SBppAnhj+nCRQvU2uA5pxuogA04+AgYwbbsVVv9EM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Su0gWFZwb1VAtWnyYa8HXAL1JszTInCplgf/dDL9xJPzE7pH17mZ4oM/r/leuMq66
         zVbFl+Xt5DO/OIyDsfr/QW1sNISV8QDFE5w3oOf30WW4gRBjpBg2A7qPO/1WUwL4mS
         yI19JtuZ88IHVI1KWSddXZicOL2BILYM02NnlBpI=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0065Ump6048897
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 5 Jan 2020 23:30:48 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Sun, 5 Jan
 2020 23:30:48 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Sun, 5 Jan 2020 23:30:48 -0600
Received: from [10.24.69.159] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0065Uiu9120958;
        Sun, 5 Jan 2020 23:30:45 -0600
Subject: Re: [PATCH v2 01/14] dt-bindings: phy: Convert Cadence MHDP PHY
 bindings to YAML.
To:     Yuti Amonkar <yamonkar@cadence.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>, <maxime@cerno.tech>
CC:     <jsarha@ti.com>, <tomi.valkeinen@ti.com>, <praneeth@ti.com>,
        <mparab@cadence.com>, <sjakhade@cadence.com>
References: <1577114139-14984-1-git-send-email-yamonkar@cadence.com>
 <1577114139-14984-2-git-send-email-yamonkar@cadence.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <5b1c3157-2584-c9c2-0823-ce4a5c709492@ti.com>
Date:   Mon, 6 Jan 2020 11:02:50 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1577114139-14984-2-git-send-email-yamonkar@cadence.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 23/12/19 8:45 PM, Yuti Amonkar wrote:
> - Convert the MHDP PHY devicetree bindings to yaml schemas.
> - Rename DP PHY to have generic Torrent PHY nomrnclature.
> - Rename compatible string from "cdns,dp-phy" to "cdns,torrent-phy".
>   This will not affect ABI as the driver has never been functional,
>   and therefore do not exist in any active use case

Since the Torrent SERDES is similar in design to Sierra SERDES, can we
make the binding look similar too.

For example, with the current binding here, it might not be possible to
specify multi-link. Sierra has a subnode for every link.

Thanks
Kishon

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
> +          num_lanes = <4>;
> +          max_bit_rate = <8100>;
> +          #phy-cells = <0>;
> +    };
> +...
> 
