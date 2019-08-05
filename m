Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69428C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 22:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CFA42147A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 22:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565043566;
	bh=DAJwXEw19Gb3M6Oq5kBaOup970MTSVSAKhmz3GBuXtk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0bQHqUFXWkfE3OyKs+76BWkV2kMTJmqEFtY9mu6+mtU0oD0Z1EvKCHkf1pAOo4yZT
	 TBZfRN/dxTNFcAcloRHJr0pi7xZ8fMp8ER7HGBQmmeGVoFaDRxH4kbk5D8vLt/aHC/
	 LRTvl7xzBDOFJIV8CQwkrbBk4cQHnMMS0Q3+K+LI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730804AbfHEWTY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 18:19:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:58364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727928AbfHEWTY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 18:19:24 -0400
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C08E4216B7;
        Mon,  5 Aug 2019 22:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565043562;
        bh=DAJwXEw19Gb3M6Oq5kBaOup970MTSVSAKhmz3GBuXtk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MMsu+oJbyvDnQfp/3Sqw52yu3oTmDrGx7JSFykZCahzUkH1ZG3cT518XVsjvF2OJS
         wrJNhvBMBvhL9qo5jubI/JdMWLyhn0H3wjlPddG0iWsyQSXDXUnV4AH+eFK/e+qLSz
         sptjIsYR7y1qbYOgBXVRxXn+5b/AmGXSWCHqWxuM=
Received: by mail-qk1-f182.google.com with SMTP id t8so61388163qkt.1;
        Mon, 05 Aug 2019 15:19:22 -0700 (PDT)
X-Gm-Message-State: APjAAAV5L2M6cZynI7nqUFJSxmF53hSWoKW8wQctT+skutIaF1Ro1MTy
        aUZQEagcA7H+ooLd0tNiKaGwBa67cJrr4z4+7w==
X-Google-Smtp-Source: APXvYqwz4pf25c01K6WX65UF5AuzkCcAaP6sAPVUCXeRy75ZDEAzBFtayvGaJ/BvtVIeahMI898URW4gNOpYlM5mhJY=
X-Received: by 2002:a37:a010:: with SMTP id j16mr575745qke.152.1565043561946;
 Mon, 05 Aug 2019 15:19:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190805134319.737-1-narmstrong@baylibre.com> <20190805134319.737-3-narmstrong@baylibre.com>
In-Reply-To: <20190805134319.737-3-narmstrong@baylibre.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 5 Aug 2019 16:19:10 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLMS2y5ZR4SH6TVwnaTDhnGwk2_C_81DTz9J=ypDdBd4w@mail.gmail.com>
Message-ID: <CAL_JsqLMS2y5ZR4SH6TVwnaTDhnGwk2_C_81DTz9J=ypDdBd4w@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: display: amlogic,meson-vpu: convert to yaml
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     devicetree@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-amlogic@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 5, 2019 at 7:43 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Now that we have the DT validation in place, let's convert the device tree
> bindings for the Amlogic Display Controller over to YAML schemas.
>
> The original example has a leftover "dmc" memory cell, that has been
> removed in the yaml rewrite.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../bindings/display/amlogic,meson-vpu.txt    | 121 --------------
>  .../bindings/display/amlogic,meson-vpu.yaml   | 153 ++++++++++++++++++
>  2 files changed, 153 insertions(+), 121 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/amlogic,meson-vpu.txt
>  create mode 100644 Documentation/devicetree/bindings/display/amlogic,meson-vpu.yaml


> diff --git a/Documentation/devicetree/bindings/display/amlogic,meson-vpu.yaml b/Documentation/devicetree/bindings/display/amlogic,meson-vpu.yaml
> new file mode 100644
> index 000000000000..9eba13031998
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/amlogic,meson-vpu.yaml
> @@ -0,0 +1,153 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2019 BayLibre, SAS
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/display/amlogic,meson-vpu.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Amlogic Meson Display Controller
> +
> +maintainers:
> +  - Neil Armstrong <narmstrong@baylibre.com>
> +
> +description: |
> +  The Amlogic Meson Display controller is composed of several components
> +  that are going to be documented below
> +
> +  DMC|---------------VPU (Video Processing Unit)----------------|------HHI------|
> +     | vd1   _______     _____________    _________________     |               |
> +  D  |-------|      |----|            |   |                |    |   HDMI PLL    |
> +  D  | vd2   | VIU  |    | Video Post |   | Video Encoders |<---|-----VCLK      |
> +  R  |-------|      |----| Processing |   |                |    |               |
> +     | osd2  |      |    |            |---| Enci ----------|----|-----VDAC------|
> +  R  |-------| CSC  |----| Scalers    |   | Encp ----------|----|----HDMI-TX----|
> +  A  | osd1  |      |    | Blenders   |   | Encl ----------|----|---------------|
> +  M  |-------|______|----|____________|   |________________|    |               |
> +  ___|__________________________________________________________|_______________|
> +
> +
> +  VIU: Video Input Unit
> +  ---------------------
> +
> +  The Video Input Unit is in charge of the pixel scanout from the DDR memory.
> +  It fetches the frames addresses, stride and parameters from the "Canvas" memory.
> +  This part is also in charge of the CSC (Colorspace Conversion).
> +  It can handle 2 OSD Planes and 2 Video Planes.
> +
> +  VPP: Video Post Processing
> +  --------------------------
> +
> +  The Video Post Processing is in charge of the scaling and blending of the
> +  various planes into a single pixel stream.
> +  There is a special "pre-blending" used by the video planes with a dedicated
> +  scaler and a "post-blending" to merge with the OSD Planes.
> +  The OSD planes also have a dedicated scaler for one of the OSD.
> +
> +  VENC: Video Encoders
> +  --------------------
> +
> +  The VENC is composed of the multiple pixel encoders
> +   - ENCI : Interlace Video encoder for CVBS and Interlace HDMI
> +   - ENCP : Progressive Video Encoder for HDMI
> +   - ENCL : LCD LVDS Encoder
> +  The VENC Unit gets a Pixel Clocks (VCLK) from a dedicated HDMI PLL and clock
> +  tree and provides the scanout clock to the VPP and VIU.
> +  The ENCI is connected to a single VDAC for Composite Output.
> +  The ENCI and ENCP are connected to an on-chip HDMI Transceiver.
> +
> +  The following table lists for each supported model the port number
> +  corresponding to each VPU output.
> +
> +                  Port 0       Port 1
> +  -----------------------------------------
> +   S905 (GXBB)   CVBS VDAC        HDMI-TX
> +   S905X (GXL)   CVBS VDAC        HDMI-TX
> +   S905D (GXL)   CVBS VDAC        HDMI-TX
> +   S912 (GXM)      CVBS VDAC      HDMI-TX
> +   S905X2 (G12A)       CVBS VDAC          HDMI-TX
> +   S905Y2 (G12A)       CVBS VDAC          HDMI-TX
> +   S905D2 (G12A)       CVBS VDAC          HDMI-TX
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - amlogic,meson-gxbb-vpu # GXBB (S905)
> +              - amlogic,meson-gxl-vpu # GXL (S905X, S905D)
> +              - amlogic,meson-gxm-vpu # GXM (S912)
> +          - const: amlogic,meson-gx-vpu
> +      - enum:
> +          - amlogic,meson-g12a-vpu # G12A (S905X2, S905Y2, S905D2)
> +
> +  reg:
> +    maxItems: 2
> +
> +  reg-names:
> +   items:
> +     - const: vpu
> +     - const: hhi
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  power-domains:
> +    description: phandle to the associated power domain
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/phandle

Common properties don't need a type definition. As this can be an
array, you just need 'maxItems: 1'.

Same comments on patch 1 apply here too.

Rob
