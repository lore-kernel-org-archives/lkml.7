Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC45EC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5D1B21900
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563816918;
	bh=CeA/7mZokk1eeVc1IHTL3CzQtzkfvvbsLIB9WVks+o4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=I/LGZYlgl5Af4c6TYhYHJLAE4MuMDpwZ1J+vXl9xSgywJrI/Ns8Rhy1hK3qlmzzvS
	 QySiC64dZ+/HqS6iDB0FgYMtsnrS+xlin6OfjEDTCHNTi/B7l3BvxSihSJ1YsiAK5C
	 UfiZEfPO6t6UaCAuowqCDr6SRpSjKd31pZTaZ8sk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728917AbfGVRfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 13:35:17 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44860 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbfGVRfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 13:35:16 -0400
Received: by mail-io1-f65.google.com with SMTP id s7so75649971iob.11;
        Mon, 22 Jul 2019 10:35:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JDuSuormHl6OlHvlYCfUiBnX10uM4EHPmxZlZ0DJuLM=;
        b=NbtgMx2pmw3LLISszZ6yDxnJDiOVGbIYSrsz20jVLrQji8iL/xKjU9p/FmzA9i1dtk
         7StGzPRa+RNk01alJOYSy7qQaQx7PRbKP+HiiPBX0p0m7MeDsaiZ75AmyOY6ntLWwBOx
         g21wL8+ArwnJRblNQOWhyb5VZIR3/ZhJZJiqUlz31u5tp6CP8+GBLWZ0VEH32m4A/UbY
         M1iH2tSnvZmG33pl++zD/fjR7hbgZgCT+FO7BaajTX5jRi/OH/1tVAIuE3r7INdmRHRj
         /Wy25u3gY8tcUQZIMP2P0q2mntiNRwuJ6yFcW+G4sEMCwZRm6dE315Z1zunXrhEOJxea
         BKyg==
X-Gm-Message-State: APjAAAXvCrAZY0Bsus+bsQRDgmCRcebddvg2mtA2qQaChiQiAk25uq5B
        jNLmCCDyIHVtkwRPwIl5Qg==
X-Google-Smtp-Source: APXvYqyWMPwtJ+fjv9YN4BZ+3w441rytWHI9dIcL/oM+b4pL1at9VQEAaRQ/tD4QGzJqUPpWA3ZK5w==
X-Received: by 2002:a6b:f910:: with SMTP id j16mr38510368iog.256.1563816915872;
        Mon, 22 Jul 2019 10:35:15 -0700 (PDT)
Received: from localhost ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id z19sm52070846ioh.12.2019.07.22.10.35.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 10:35:15 -0700 (PDT)
Date:   Mon, 22 Jul 2019 11:35:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Brian Masney <masneyb@onstation.org>
Cc:     agross@kernel.org, robdclark@gmail.com, sean@poorly.run,
        bjorn.andersson@linaro.org, airlied@linux.ie, daniel@ffwll.ch,
        mark.rutland@arm.com, jonathan@marek.ca,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, jcrouse@codeaurora.org
Subject: Re: [PATCH v3 1/6] dt-bindings: soc: qcom: add On Chip MEMory
 (OCMEM) bindings
Message-ID: <20190722173514.GA11931@bogus>
References: <20190626022148.23712-1-masneyb@onstation.org>
 <20190626022148.23712-2-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626022148.23712-2-masneyb@onstation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 10:21:43PM -0400, Brian Masney wrote:
> Add device tree bindings for the On Chip Memory (OCMEM) that is present
> on some Qualcomm Snapdragon SoCs.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---
> Changes since v2:
> - Add *-sram node and gmu-sram to example.
> 
> Changes since v1:
> - Rename qcom,ocmem-msm8974 to qcom,msm8974-ocmem
> - Renamed reg-names to ctrl and mem
> - update hardware description
> - moved from soc to sram namespace in the device tree bindings
> 
>  .../bindings/sram/qcom/qcom,ocmem.yaml        | 84 +++++++++++++++++++
>  1 file changed, 84 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sram/qcom/qcom,ocmem.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sram/qcom/qcom,ocmem.yaml b/Documentation/devicetree/bindings/sram/qcom/qcom,ocmem.yaml
> new file mode 100644
> index 000000000000..a0bf0af4860a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sram/qcom/qcom,ocmem.yaml
> @@ -0,0 +1,84 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sram/qcom/qcom,ocmem.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: On Chip Memory (OCMEM) that is present on some Qualcomm Snapdragon SoCs.
> +
> +maintainers:
> +  - Brian Masney <masneyb@onstation.org>
> +
> +description: |
> +  The On Chip Memory (OCMEM) is typically used by the GPU, camera/video, and
> +  audio components on some Snapdragon SoCs.
> +
> +properties:
> +  compatible:
> +    const: qcom,msm8974-ocmem
> +
> +  reg:
> +    items:
> +      - description: Control registers
> +      - description: OCMEM address range
> +
> +  reg-names:
> +    items:
> +      - const: ctrl
> +      - const: mem
> +
> +  clocks:
> +    items:
> +      - description: Core clock
> +      - description: Interface clock
> +
> +  clock-names:
> +    items:
> +      - const: core
> +      - const: iface
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - clocks
> +  - clock-names
> +
> +patternProperties:
> +  "^.+-sram$":
> +    type: object
> +    description: |

You don't need this to be a literal block (i.e. drop the '|').

> +      A region of reserved memory.
> +
> +    properties:
> +      reg:
> +        maxItems: 1
> +
> +    required:
> +      - reg
> +
> +examples:
> +  - |
> +      #include <dt-bindings/clock/qcom,rpmcc.h>
> +      #include <dt-bindings/clock/qcom,mmcc-msm8974.h>
> +
> +      ocmem: ocmem@fdd00000 {
> +        compatible = "qcom,msm8974-ocmem";
> +
> +        reg = <0xfdd00000 0x2000>,
> +              <0xfec00000 0x180000>;
> +        reg-names = "ctrl",
> +                    "mem";
> +
> +        clocks = <&rpmcc RPM_SMD_OCMEMGX_CLK>,
> +                 <&mmcc OCMEMCX_OCMEMNOC_CLK>;
> +        clock-names = "core",
> +                      "iface";
> +
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +
> +        gmu-sram@0 {
> +                reg = <0x0 0x100000>;

This is at 0xfec00000? If so you should have a 'ranges' to translate 0 
to that.

Rob
