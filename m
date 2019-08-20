Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3FAAC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 15:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7D9D205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 15:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566316472;
	bh=K8yW+xYCQIIvZaPUVrPLDL0/nQ7cDz12rR0ZSD9Uut8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=hPdVJCVHPV21UURduMbrQzAs1ThS99lpksdPU4uBT7KeNMLskFPJyx4EBw5Ibombi
	 SSIqj7Z2oI+5KnC/Kt19V7axvoEZNbIYU4kcAZKI8bMB9ahfI5xnNVJEILIfAffbxG
	 iCJZPbhFkY6FGC7h6ED6C8x4dQBCcbkUPL52zcNU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730567AbfHTPyb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 11:54:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:60386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727246AbfHTPyb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 11:54:31 -0400
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87B7D205ED;
        Tue, 20 Aug 2019 15:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566316470;
        bh=K8yW+xYCQIIvZaPUVrPLDL0/nQ7cDz12rR0ZSD9Uut8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YcK07XtglPgBpab3DgEUMK4mVuNiEoKFYliG/e4zwRHBAjxqCQ040vr+ge8R2r3Xw
         duRuCLIzw49sFiVVufmfsbSCLAFBEQoGsuC9a3ytIGqXAbvE77POrI6/mm7Mu0tVnn
         XgjUgTjOo8T9bgvgr54iqtR3P2CSfFT7UOZm+1c8=
Received: by mail-qt1-f182.google.com with SMTP id l9so6577764qtu.6;
        Tue, 20 Aug 2019 08:54:30 -0700 (PDT)
X-Gm-Message-State: APjAAAWVgL1F1OSt/cHkHoIK3vtn8UniW7yWU0Tl+tVZYIdDQeYs8NPg
        M/iW6bACJ+tl/k3/W4SI0iKZYICPXXTQe+Lhaw==
X-Google-Smtp-Source: APXvYqwBR2pYMoI+DjMdrv/v5DE3g3hejD4lmJtNYgBTjKUgCs1IiH/3ww6gaUj6zNGAjYQb3cdrlb9/Rx5G3rW4NQE=
X-Received: by 2002:ac8:44c4:: with SMTP id b4mr26574552qto.224.1566316469752;
 Tue, 20 Aug 2019 08:54:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190820103133.53776-1-vadivel.muruganx.ramuthevar@linux.intel.com>
In-Reply-To: <20190820103133.53776-1-vadivel.muruganx.ramuthevar@linux.intel.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 20 Aug 2019 10:54:18 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKvzogi9969fx9j6v58V5+EH-06tDx7-qy7xu84pGRSRA@mail.gmail.com>
Message-ID: <CAL_JsqKvzogi9969fx9j6v58V5+EH-06tDx7-qy7xu84pGRSRA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: phy: intel-emmc-phy: Add YAML schema
 for LGM eMMC PHY
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

On Tue, Aug 20, 2019 at 5:31 AM Ramuthevar,Vadivel MuruganX
<vadivel.muruganx.ramuthevar@linux.intel.com> wrote:
>
> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>
> Add a YAML schema to use the host controller driver with the
> eMMC PHY on Intel's Lightning Mountain SoC.
>
> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> ---
> changes in v2:
>   As per Rob Herring review comments, the following updates
>  - change GPL-2.0 -> (GPL-2.0-only OR BSD-2-Clause)
>  - filename is the compatible string plus .yaml
>  - LGM: Lightning Mountain
>  - update maintainer
>  - add intel,syscon under property list
>  - keep one example instead of two
> ---
>  .../bindings/phy/intel,lgm-emmc-phy.yaml           | 72 ++++++++++++++++++++++
>  1 file changed, 72 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml
>
> diff --git a/Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml b/Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml
> new file mode 100644
> index 000000000000..ec177573aca6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml
> @@ -0,0 +1,72 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/intel,lgm-emmc-phy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Intel Lightning Mountain(LGM) eMMC PHY Device Tree Bindings
> +
> +maintainers:
> +  - Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> +
> +
> +description:
> +  -  Add a new compatible to use the host controller driver with the
> +     eMMC PHY on Intel's Lightning Mountain SoC.
> +
> +$ref: /schemas/types.yaml#definitions/phandle
> +  description:
> +    - It also requires a "syscon" node with compatible = "intel,lgm-chiptop",
> +      "syscon" to access the eMMC PHY register.

Not valid schema. Please build 'make dt_binding_check' and fix any warnings.

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
> +  intel,syscon:
> +    items:
> +      - description:
> +         - |
> +           e-MMC phy module should include the following properties
> +           * reg, Access the e-MMC, get the base address from syscon.
> +           * reset, reset the e-MMC module.
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
> +    emmc_phy: emmc_phy {
> +        compatible = "intel,lgm-emmc-phy";
> +        reg = <0xe0020000 0x100>;
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
