Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43BCC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 19:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D4EF22D6D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 19:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566242845;
	bh=FF7jXADl84/ZQ3CFgtiednouzYk9TDZ2FJb5brLwjMA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=gT0s13ZumS+rs99Z0i82O633Aqqa2Tcs2DMQ8BJvIaLiyEPwNjW4kgX3h20LMXjFs
	 cVHNYyfgwxoJug2WAw98nt0Ifhn0nY37tTsViMD53JoQYdyT7o7jma1SKkgrNSFZRs
	 40VMILtZWMipGc2/NLCTCsyhVEs78P3d31PX8aVY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728886AbfHST1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 15:27:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:43334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728545AbfHST1V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 15:27:21 -0400
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C050B22CF8;
        Mon, 19 Aug 2019 19:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566242840;
        bh=FF7jXADl84/ZQ3CFgtiednouzYk9TDZ2FJb5brLwjMA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oDhAYrrHJn9W/xjZigWqHbp3pAjlyPSiIZ+wMSAmClpjErlDU92gJfu5ZtVblU0vm
         AZKL2bXeEoM4hi5dxSThm9D1o6XPFvsW9yysClIH20DK4sdB2VWk7eDTQxdrM+UX2s
         YreNUFl40iqFlh5518gwvt+Vin7uP9zJZ6FnvWGQ=
Received: by mail-qk1-f169.google.com with SMTP id s145so2408909qke.7;
        Mon, 19 Aug 2019 12:27:20 -0700 (PDT)
X-Gm-Message-State: APjAAAXdodp6NSYFNfRZoe66cFaF5rsTfMJ8SXlzk87fWeJyZlv+T2+Y
        JVpkqfi2iC21ppbj3+bHcd4nIPHIWYFA5QkaTw==
X-Google-Smtp-Source: APXvYqxeh9qg21yX5D/sPAgYyZyxr9xFfen80p5g2ityS/6nfAGqpJiGY6uk3XwllPd27PeH9GGXmhU7foKmd/CePTw=
X-Received: by 2002:a37:d8f:: with SMTP id 137mr21577181qkn.254.1566242839962;
 Mon, 19 Aug 2019 12:27:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190819034416.45192-1-vadivel.muruganx.ramuthevar@linux.intel.com>
In-Reply-To: <20190819034416.45192-1-vadivel.muruganx.ramuthevar@linux.intel.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 19 Aug 2019 14:27:09 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL2m-3BJHCSg2pwogyPDbp6yADUP1MQEV6QyZMpgta4xw@mail.gmail.com>
Message-ID: <CAL_JsqL2m-3BJHCSg2pwogyPDbp6yADUP1MQEV6QyZMpgta4xw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: phy: intel-emmc-phy: Add new
 compatible for LGM eMMC PHY
To:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        peter.harliman.liem@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 18, 2019 at 10:44 PM Ramuthevar,Vadivel MuruganX
<vadivel.muruganx.ramuthevar@linux.intel.com> wrote:
>
> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>
> Add a new compatible to use the host controller driver with the
> eMMC PHY on Intel's Lightning Mountain SoC.
>
> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> ---
>  .../bindings/phy/intel-lgm-emmc-phy.yaml           | 70 ++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/intel-lgm-emmc-phy.yaml
>
> diff --git a/Documentation/devicetree/bindings/phy/intel-lgm-emmc-phy.yaml b/Documentation/devicetree/bindings/phy/intel-lgm-emmc-phy.yaml
> new file mode 100644
> index 000000000000..52156ff091ad
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/intel-lgm-emmc-phy.yaml
> @@ -0,0 +1,70 @@
> +# SPDX-License-Identifier: GPL-2.0

Preference for new bindings is (GPL-2.0-only OR BSD-2-Clause)

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/intel-lgm-emmc-phy.yaml#

Preferred filename is the compatible string (plus .yaml).

> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Intel LGM e-MMC PHY Device Tree Bindings

LGM is what?

> +
> +maintainers:
> +  - Rob Herring <robh+dt@kernel.org>
> +  - Mark Rutland <mark.rutland@arm.com>

I don't know anything about this h/w. Please put yourself here.

> +
> +intel,syscon:

This will throw an error with 'make dt_binding_check'...

> +   $ref: /schemas/types.yaml#definitions/phandle
> +   description:
> +    - |
> +      e-MMC phy module connected through chiptop. Phandle to a node that can
> +      contain the following properties
> +        * reg, Access the e-MMC, get the base address from syscon.
> +        * reset, reset the e-MMC module.
> +
> +properties:
> +  "#phy-cells":
> +    const: 0
> +
> +  compatible:
> +    const: intel,lgm-emmc-phy
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: e-MMC phy module clock
> +
> +  clock-names:
> +    items:
> +      - const: emmcclk
> +
> +  resets:
> +    maxItems: 1
> +
> +required:
> +  - "#phy-cells"
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - resets
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    sysconf: chiptop@e0020000 {
> +        compatible = "intel,chiptop-lgm", "syscon";
> +        reg = <0xe0020000 0x100>;
> +        #reset-cells = <1>;
> +     };
> +
> +  - |

Looks like 1 example to me, not 2.

> +    emmc_phy: emmc_phy {
> +        compatible = "intel,lgm-emmc-phy";
> +        intel,syscon = <&sysconf>;
> +        clocks = <&emmc>;
> +        clock-names = "emmcclk";
> +        #phy-cells = <0>;
> +    };
> +
> +...
> --
> 2.11.0
>
