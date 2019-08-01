Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5EF0C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 16:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9871420B7C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 16:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564676740;
	bh=1OdO8PtlSvZqG/aStuRTcmQ3s4kH8OwmNMrOayJ17nM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ivGF2fzwL1bqMJJKcILLVCP1qzlwEFAhXx3Yjgdcl+08Fr3pQ7kqu8z/pQenmUdSL
	 ZDaczVYrT0rdjO5azL2ymZ4mu2JHmuqurMqdBpWDLllHN0ovHwR17EdB8FUyRtafxr
	 A98K4CwGj6rPzUH7oPcFiLRiThvGMWOxSPMG4IQ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732941AbfHAQZj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 12:25:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:34698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732082AbfHAQZj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 12:25:39 -0400
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 418472173E;
        Thu,  1 Aug 2019 16:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564676737;
        bh=1OdO8PtlSvZqG/aStuRTcmQ3s4kH8OwmNMrOayJ17nM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bCHEblo7ICFupz1B9SWCkeZLeIlIBMctBKcYkRbZlOyel0jtvvfx9RCzBrcAzhzEt
         B7t1FMzy7tN4ewE7wwMtunveMQarLqox4OZczSKSGK/FvgKXfShNnAb7OiYLlh7r4U
         lLMxCPlufn1y2iflC7yR/60+3f4tlbNThXVS1RpE=
Received: by mail-qt1-f178.google.com with SMTP id y26so70847161qto.4;
        Thu, 01 Aug 2019 09:25:37 -0700 (PDT)
X-Gm-Message-State: APjAAAVfLMB/OxaP0ijiXxWPrrvcu/n1EGLKBRuewAnazJvJmOGToLxr
        tpJoWel/sa+RIun43ORJrIZGDNtuWIoLvCiCcg==
X-Google-Smtp-Source: APXvYqzebiTo13KU9xtKMFxc68fL1CGPrz24VArBmLH/HoKq+KwLz9YSBnDFQOB5Q+HZLjuEIG7Fklaupz4VvQWO50Q=
X-Received: by 2002:a0c:b786:: with SMTP id l6mr93641646qve.148.1564676736342;
 Thu, 01 Aug 2019 09:25:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190730165618.10122-1-digetx@gmail.com> <20190730165618.10122-10-digetx@gmail.com>
In-Reply-To: <20190730165618.10122-10-digetx@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 1 Aug 2019 10:25:23 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL_LA+cW2GbCMdzRTFuv2oKE3pzyOm2UwdzLVLyVTnmNw@mail.gmail.com>
Message-ID: <CAL_JsqL_LA+cW2GbCMdzRTFuv2oKE3pzyOm2UwdzLVLyVTnmNw@mail.gmail.com>
Subject: Re: [PATCH v9 09/15] dt-bindings: memory: tegra30: Convert to
 Tegra124 YAML
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 10:58 AM Dmitry Osipenko <digetx@gmail.com> wrote:
>
> The Tegra30 binding will actually differ from the Tegra124 a tad, in
> particular the EMEM configuration description. Hence rename the binding
> to Tegra124 during of the conversion to YAML.
>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../nvidia,tegra124-mc.yaml                   | 158 ++++++++++++++++++
>  .../memory-controllers/nvidia,tegra30-mc.txt  | 123 --------------
>  2 files changed, 158 insertions(+), 123 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-mc.yaml
>  delete mode 100644 Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-mc.txt
>
> diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-mc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-mc.yaml
> new file mode 100644
> index 000000000000..2e2a116f1911
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-mc.yaml
> @@ -0,0 +1,158 @@
> +# SPDX-License-Identifier: (GPL-2.0)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/memory-controllers/nvidia,tegra124-mc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NVIDIA Tegra124 SoC Memory Controller
> +
> +maintainers:
> +  - Jon Hunter <jonathanh@nvidia.com>
> +  - Thierry Reding <thierry.reding@gmail.com>
> +
> +description: |
> +  Tegra124 SoC features a hybrid 2x32-bit / 1x64-bit memory controller.
> +  These are interleaved to provide high performance with the load shared across
> +  two memory channels. The Tegra124 Memory Controller handles memory requests
> +  from internal clients and arbitrates among them to allocate memory bandwidth
> +  for DDR3L and LPDDR3 SDRAMs.
> +
> +properties:
> +  compatible:
> +    const: nvidia,tegra124-mc
> +
> +  reg:
> +    maxItems: 1
> +    description:
> +      Physical base address.

You don't really need a description when there's only 1 item. Same on
the others below.

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

> +
> +  clocks:
> +    maxItems: 1
> +    description:
> +      Memory Controller clock.
> +
> +  clock-names:
> +    items:
> +      - const: mc
> +
> +  interrupts:
> +    maxItems: 1
> +    description:
> +      Memory Controller interrupt.
> +
> +  "#reset-cells":
> +    const: 1
> +
> +  "#iommu-cells":
> +    const: 1
> +
> +patternProperties:
> +  "^emc-timings-[0-9]+$":
> +    type: object
> +    properties:
> +      nvidia,ram-code:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description:
> +          Value of RAM_CODE this timing set is used for.
> +
> +    patternProperties:
> +      "^timing-[0-9]+$":
> +        type: object
> +        properties:
> +          clock-frequency:
> +            description:
> +              Memory clock rate in Hz.
> +            minimum: 1000000
> +            maximum: 1066000000
> +
> +          nvidia,emem-configuration:
> +            $ref: /schemas/types.yaml#/definitions/uint32-array
> +            description: |
> +              Values to be written to the EMEM register block. See section
> +              "15.6.1 MC Registers" in the TRM.
> +            items:
> +              - description: MC_EMEM_ARB_CFG
> +              - description: MC_EMEM_ARB_OUTSTANDING_REQ
> +              - description: MC_EMEM_ARB_TIMING_RCD
> +              - description: MC_EMEM_ARB_TIMING_RP
> +              - description: MC_EMEM_ARB_TIMING_RC
> +              - description: MC_EMEM_ARB_TIMING_RAS
> +              - description: MC_EMEM_ARB_TIMING_FAW
> +              - description: MC_EMEM_ARB_TIMING_RRD
> +              - description: MC_EMEM_ARB_TIMING_RAP2PRE
> +              - description: MC_EMEM_ARB_TIMING_WAP2PRE
> +              - description: MC_EMEM_ARB_TIMING_R2R
> +              - description: MC_EMEM_ARB_TIMING_W2W
> +              - description: MC_EMEM_ARB_TIMING_R2W
> +              - description: MC_EMEM_ARB_TIMING_W2R
> +              - description: MC_EMEM_ARB_DA_TURNS
> +              - description: MC_EMEM_ARB_DA_COVERS
> +              - description: MC_EMEM_ARB_MISC0
> +              - description: MC_EMEM_ARB_MISC1
> +              - description: MC_EMEM_ARB_RING1_THROTTLE
> +
> +        required:
> +          - clock-frequency
> +          - nvidia,emem-configuration
> +
> +        additionalProperties: false
> +
> +    required:
> +      - nvidia,ram-code
> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - "#reset-cells"
> +  - "#iommu-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    memory-controller@70019000 {
> +        compatible = "nvidia,tegra124-mc";
> +        reg = <0x0 0x70019000 0x0 0x1000>;
> +        clocks = <&tegra_car 32>;
> +        clock-names = "mc";
> +
> +        interrupts = <0 77 4>;
> +
> +        #iommu-cells = <1>;
> +        #reset-cells = <1>;
> +
> +        emc-timings-3 {
> +            nvidia,ram-code = <3>;
> +
> +            timing-12750000 {
> +                clock-frequency = <12750000>;
> +
> +                nvidia,emem-configuration = <
> +                    0x40040001 /* MC_EMEM_ARB_CFG */
> +                    0x8000000a /* MC_EMEM_ARB_OUTSTANDING_REQ */
> +                    0x00000001 /* MC_EMEM_ARB_TIMING_RCD */
> +                    0x00000001 /* MC_EMEM_ARB_TIMING_RP */
> +                    0x00000002 /* MC_EMEM_ARB_TIMING_RC */
> +                    0x00000000 /* MC_EMEM_ARB_TIMING_RAS */
> +                    0x00000002 /* MC_EMEM_ARB_TIMING_FAW */
> +                    0x00000001 /* MC_EMEM_ARB_TIMING_RRD */
> +                    0x00000002 /* MC_EMEM_ARB_TIMING_RAP2PRE */
> +                    0x00000008 /* MC_EMEM_ARB_TIMING_WAP2PRE */
> +                    0x00000003 /* MC_EMEM_ARB_TIMING_R2R */
> +                    0x00000002 /* MC_EMEM_ARB_TIMING_W2W */
> +                    0x00000003 /* MC_EMEM_ARB_TIMING_R2W */
> +                    0x00000006 /* MC_EMEM_ARB_TIMING_W2R */
> +                    0x06030203 /* MC_EMEM_ARB_DA_TURNS */
> +                    0x000a0402 /* MC_EMEM_ARB_DA_COVERS */
> +                    0x77e30303 /* MC_EMEM_ARB_MISC0 */
> +                    0x70000f03 /* MC_EMEM_ARB_MISC1 */
> +                    0x001f0000 /* MC_EMEM_ARB_RING1_THROTTLE */
> +                >;
> +            };
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-mc.txt b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-mc.txt
> deleted file mode 100644
> index a878b5908a4d..000000000000
> --- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-mc.txt
> +++ /dev/null
> @@ -1,123 +0,0 @@
> -NVIDIA Tegra Memory Controller device tree bindings
> -===================================================
> -
> -memory-controller node
> -----------------------
> -
> -Required properties:
> -- compatible: Should be "nvidia,tegra<chip>-mc"
> -- reg: Physical base address and length of the controller's registers.
> -- clocks: Must contain an entry for each entry in clock-names.
> -  See ../clocks/clock-bindings.txt for details.
> -- clock-names: Must include the following entries:
> -  - mc: the module's clock input
> -- interrupts: The interrupt outputs from the controller.
> -- #reset-cells : Should be 1. This cell represents memory client module ID.
> -  The assignments may be found in header file <dt-bindings/memory/tegra30-mc.h>
> -  or in the TRM documentation.
> -
> -Required properties for Tegra30, Tegra114, Tegra124, Tegra132 and Tegra210:
> -- #iommu-cells: Should be 1. The single cell of the IOMMU specifier defines
> -  the SWGROUP of the master.
> -
> -This device implements an IOMMU that complies with the generic IOMMU binding.
> -See ../iommu/iommu.txt for details.
> -
> -emc-timings subnode
> --------------------
> -
> -The node should contain a "emc-timings" subnode for each supported RAM type (see field RAM_CODE in
> -register PMC_STRAPPING_OPT_A).
> -
> -Required properties for "emc-timings" nodes :
> -- nvidia,ram-code : Should contain the value of RAM_CODE this timing set is used for.
> -
> -timing subnode
> ---------------
> -
> -Each "emc-timings" node should contain a subnode for every supported EMC clock rate.
> -
> -Required properties for timing nodes :
> -- clock-frequency : Should contain the memory clock rate in Hz.
> -- nvidia,emem-configuration : Values to be written to the EMEM register block. For the Tegra124 SoC
> -(see section "15.6.1 MC Registers" in the TRM), these are the registers whose values need to be
> -specified, according to the board documentation:
> -
> -       MC_EMEM_ARB_CFG
> -       MC_EMEM_ARB_OUTSTANDING_REQ
> -       MC_EMEM_ARB_TIMING_RCD
> -       MC_EMEM_ARB_TIMING_RP
> -       MC_EMEM_ARB_TIMING_RC
> -       MC_EMEM_ARB_TIMING_RAS
> -       MC_EMEM_ARB_TIMING_FAW
> -       MC_EMEM_ARB_TIMING_RRD
> -       MC_EMEM_ARB_TIMING_RAP2PRE
> -       MC_EMEM_ARB_TIMING_WAP2PRE
> -       MC_EMEM_ARB_TIMING_R2R
> -       MC_EMEM_ARB_TIMING_W2W
> -       MC_EMEM_ARB_TIMING_R2W
> -       MC_EMEM_ARB_TIMING_W2R
> -       MC_EMEM_ARB_DA_TURNS
> -       MC_EMEM_ARB_DA_COVERS
> -       MC_EMEM_ARB_MISC0
> -       MC_EMEM_ARB_MISC1
> -       MC_EMEM_ARB_RING1_THROTTLE
> -
> -Example SoC include file:
> -
> -/ {
> -       mc: memory-controller@70019000 {
> -               compatible = "nvidia,tegra124-mc";
> -               reg = <0x0 0x70019000 0x0 0x1000>;
> -               clocks = <&tegra_car TEGRA124_CLK_MC>;
> -               clock-names = "mc";
> -
> -               interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
> -
> -               #iommu-cells = <1>;
> -               #reset-cells = <1>;
> -       };
> -
> -       sdhci@700b0000 {
> -               compatible = "nvidia,tegra124-sdhci";
> -               ...
> -               iommus = <&mc TEGRA_SWGROUP_SDMMC1A>;
> -               resets = <&mc TEGRA124_MC_RESET_SDMMC1>;
> -       };
> -};
> -
> -Example board file:
> -
> -/ {
> -       memory-controller@70019000 {
> -               emc-timings-3 {
> -                       nvidia,ram-code = <3>;
> -
> -                       timing-12750000 {
> -                               clock-frequency = <12750000>;
> -
> -                               nvidia,emem-configuration = <
> -                                       0x40040001 /* MC_EMEM_ARB_CFG */
> -                                       0x8000000a /* MC_EMEM_ARB_OUTSTANDING_REQ */
> -                                       0x00000001 /* MC_EMEM_ARB_TIMING_RCD */
> -                                       0x00000001 /* MC_EMEM_ARB_TIMING_RP */
> -                                       0x00000002 /* MC_EMEM_ARB_TIMING_RC */
> -                                       0x00000000 /* MC_EMEM_ARB_TIMING_RAS */
> -                                       0x00000002 /* MC_EMEM_ARB_TIMING_FAW */
> -                                       0x00000001 /* MC_EMEM_ARB_TIMING_RRD */
> -                                       0x00000002 /* MC_EMEM_ARB_TIMING_RAP2PRE */
> -                                       0x00000008 /* MC_EMEM_ARB_TIMING_WAP2PRE */
> -                                       0x00000003 /* MC_EMEM_ARB_TIMING_R2R */
> -                                       0x00000002 /* MC_EMEM_ARB_TIMING_W2W */
> -                                       0x00000003 /* MC_EMEM_ARB_TIMING_R2W */
> -                                       0x00000006 /* MC_EMEM_ARB_TIMING_W2R */
> -                                       0x06030203 /* MC_EMEM_ARB_DA_TURNS */
> -                                       0x000a0402 /* MC_EMEM_ARB_DA_COVERS */
> -                                       0x77e30303 /* MC_EMEM_ARB_MISC0 */
> -                                       0x70000f03 /* MC_EMEM_ARB_MISC1 */
> -                                       0x001f0000 /* MC_EMEM_ARB_RING1_THROTTLE */
> -                               >;
> -                       };
> -               };
> -       };
> -};
> --
> 2.22.0
>
