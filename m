Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 645FDC32771
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 10:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 389912081E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 10:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="hTOhuySw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgAFKLy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 05:11:54 -0500
Received: from mail-io1-f47.google.com ([209.85.166.47]:45140 "EHLO
        mail-io1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbgAFKLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 05:11:53 -0500
Received: by mail-io1-f47.google.com with SMTP id i11so47997586ioi.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 02:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BM5QMsP0AbZFoP/y14rM3kVBayTcxH4QJqPjuJIFHqM=;
        b=hTOhuySw6rVzMQXpbeRI1b4riYgYNv9nSHA24LrY6vw32Aaydw9rut6jpnDig03XNS
         dGQQdNXySoRhgyugLGobTaaEF2yTpPJYXSfZQGzAHwqmS/Sv0Eg9qALfxRBvpNNQB/LH
         oLBGtGQpCCpoJ94TQP7K+G8pwBgvLCRSsop1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BM5QMsP0AbZFoP/y14rM3kVBayTcxH4QJqPjuJIFHqM=;
        b=t2CZj27JHPZuSJG5L5CsbWG4bAChjxLHuEX2klSNGR9a89pvxSzTKgo4vT29Eq4WL/
         cY5ufWDrCLx6qACX3gUSZt9K9cfoqdZJwwoOVFrI5qRnT1XPp1mokGXdFPlRtR/454dT
         uQEvGwg4atAkcFR1l0uSpGZvdileK61H/Bmgiw3sGlxT6ZB9NCezX1kx9j9/sB4X/pz3
         TnSIuvm1CofWsBqLIPz9p3I0NHxIbv6xBVpFlMRfXAC1oi+aVJMKIJFK2OPCh0CnTRig
         19F/RqzhfK6wun8r1UUOd1usW9rqAdCtWkvZmmEYoiDY3PN4pTItXsOfHk4gP9/Bnh9T
         kbtw==
X-Gm-Message-State: APjAAAWPY1lB92hWTnoPqF4l1ffZUbPnrocCB2EEtjXf4M2d2S0xq6AG
        V/33E/qPP6VB/LC+HJQypz0ESkTUKNi6pSFki2xngw==
X-Google-Smtp-Source: APXvYqzUirMUBMW0xxRJzNQkXJ6BFIkz9VVTNKPR3lN6QCD/Fd3IwAFCUoeqyShL+FgsbSIMx5prGQgOon0oVw7bq2c=
X-Received: by 2002:a02:b893:: with SMTP id p19mr10064623jam.103.1578305512006;
 Mon, 06 Jan 2020 02:11:52 -0800 (PST)
MIME-Version: 1.0
References: <20200101112444.16250-1-jagan@amarulasolutions.com> <20200104151702.GC17768@ravnborg.org>
In-Reply-To: <20200104151702.GC17768@ravnborg.org>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Mon, 6 Jan 2020 15:41:40 +0530
Message-ID: <CAMty3ZDbDf6YovrEdG0pACQAwMQidjKr6BJvx-FPXqyT11G05w@mail.gmail.com>
Subject: Re: [PATCH 0/6] dt-bindings: display: Update few panel bindings with YAML
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-amarula <linux-amarula@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

On Sat, Jan 4, 2020 at 8:47 PM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi Jagan.
> On Wed, Jan 01, 2020 at 04:54:38PM +0530, Jagan Teki wrote:
> > These panel bindings are owned by me, so updated all of them into
> > YAML DT schema.
> >
> > Any inputs?
> Thanks for doing the conversion.
>
> dt_binding_check was not happy:
> Documentation/devicetree/bindings/display/panel/rocktech,rk070er9427.exam=
ple.dt.yaml: panel: 'backlight', 'port' do not match any of the regexes: 'p=
inctrl-[0-9]+'
>   DTC     Documentation/devicetree/bindings/display/panel/friendlyarm,hd7=
02e.example.dt.yaml
>   CHECK   Documentation/devicetree/bindings/display/panel/friendlyarm,hd7=
02e.example.dt.yaml
> Documentation/devicetree/bindings/display/panel/friendlyarm,hd702e.exampl=
e.dt.yaml: panel: 'backlight', 'port' do not match any of the regexes: 'pin=
ctrl-[0-9]+'
> Documentation/devicetree/bindings/display/panel/friendlyarm,hd702e.exampl=
e.dt.yaml: panel: compatible: Additional items are not allowed ('simple-pan=
el' was unexpected)
> Documentation/devicetree/bindings/display/panel/friendlyarm,hd702e.exampl=
e.dt.yaml: panel: compatible: ['friendlyarm,hd702e', 'simple-panel'] is too=
 long
>   DTC     Documentation/devicetree/bindings/display/panel/sitronix,st7701=
.example.dt.yaml
> Error: Documentation/devicetree/bindings/display/panel/sitronix,st7701.ex=
ample.dts:22.42-43 syntax error
> FATAL ERROR: Unable to parse input tree
>
> Please fix and check the bindings using dt_binding_check before
> resubmit.
>
> I had to install libyaml-dev (as least I recall this was the name)
> before dt_binding_check worked OK for me.

I did check dt_binfing_check with this series. Here is the complete
build log and you can see the panels related to this series are
checked fine. Let me know if I miss anything here?

=E2=82=B9 make dt_binding_check
arch/x86/Makefile:147: CONFIG_X86_X32 enabled but no binutils support
  SCHEMA  Documentation/devicetree/bindings/processed-schema.yaml
/home/jagan/work/code/drm-misc/Documentation/devicetree/bindings/firmware/i=
ntel,ixp4xx-network-processing-engine.yaml:
ignoring, error in schema: properties: reg: minItems
warning: no schema found in file:
Documentation/devicetree/bindings/firmware/intel,ixp4xx-network-processing-=
engine.yaml
/home/jagan/work/code/drm-misc/Documentation/devicetree/bindings/interrupt-=
controller/arm,gic-v3.yaml:
ignoring, error in schema: properties: ppi-partitions:
patternProperties: ^interrupt-partition-[0-9]+$
warning: no schema found in file:
Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
/home/jagan/work/code/drm-misc/Documentation/devicetree/bindings/net/snps,d=
wmac.yaml:
ignoring, error in schema: allOf: 2: then
warning: no schema found in file:
Documentation/devicetree/bindings/net/snps,dwmac.yaml
/home/jagan/work/code/drm-misc/Documentation/devicetree/bindings/regulator/=
fixed-regulator.yaml:
ignoring, error in schema: properties: compatible: enum: 0
warning: no schema found in file:
Documentation/devicetree/bindings/regulator/fixed-regulator.yaml
/home/jagan/work/code/drm-misc/Documentation/devicetree/bindings/riscv/cpus=
.yaml:
ignoring, error in schema: properties: timebase-frequency: type
warning: no schema found in file:
Documentation/devicetree/bindings/riscv/cpus.yaml
  CHKDT   Documentation/devicetree/bindings/arm/pmu.yaml
  CHKDT   Documentation/devicetree/bindings/arm/rockchip.yaml
  CHKDT   Documentation/devicetree/bindings/arm/sirf.yaml
  CHKDT   Documentation/devicetree/bindings/arm/vt8500.yaml
  CHKDT   Documentation/devicetree/bindings/arm/calxeda.yaml
  CHKDT   Documentation/devicetree/bindings/arm/atmel-at91.yaml
  CHKDT   Documentation/devicetree/bindings/arm/sunxi.yaml
  CHKDT   Documentation/devicetree/bindings/arm/xilinx.yaml
  CHKDT   Documentation/devicetree/bindings/arm/moxart.yaml
  CHKDT   Documentation/devicetree/bindings/arm/stm32/stm32.yaml
  CHKDT   Documentation/devicetree/bindings/arm/spear.yaml
  CHKDT   Documentation/devicetree/bindings/arm/al,alpine.yaml
  CHKDT   Documentation/devicetree/bindings/arm/digicolor.yaml
  CHKDT   Documentation/devicetree/bindings/arm/altera/socfpga-clk-manager.=
yaml
  CHKDT   Documentation/devicetree/bindings/arm/altera.yaml
  CHKDT   Documentation/devicetree/bindings/arm/bitmain.yaml
  CHKDT   Documentation/devicetree/bindings/arm/nxp/lpc32xx.yaml
  CHKDT   Documentation/devicetree/bindings/arm/fsl.yaml
  CHKDT   Documentation/devicetree/bindings/arm/axxia.yaml
  CHKDT   Documentation/devicetree/bindings/arm/psci.yaml
  CHKDT   Documentation/devicetree/bindings/arm/qcom.yaml
  CHKDT   Documentation/devicetree/bindings/arm/zte.yaml
  CHKDT   Documentation/devicetree/bindings/arm/intel-ixp4xx.yaml
  CHKDT   Documentation/devicetree/bindings/arm/mediatek.yaml
  CHKDT   Documentation/devicetree/bindings/arm/socionext/milbeaut.yaml
  CHKDT   Documentation/devicetree/bindings/arm/ti/nspire.yaml
  CHKDT   Documentation/devicetree/bindings/arm/ti/ti,davinci.yaml
  CHKDT   Documentation/devicetree/bindings/arm/realtek.yaml
  CHKDT   Documentation/devicetree/bindings/arm/rda.yaml
  CHKDT   Documentation/devicetree/bindings/arm/actions.yaml
  CHKDT   Documentation/devicetree/bindings/arm/l2c2x0.yaml
  CHKDT   Documentation/devicetree/bindings/arm/renesas.yaml
  CHKDT   Documentation/devicetree/bindings/arm/tegra.yaml
  CHKDT   Documentation/devicetree/bindings/arm/amlogic.yaml
  CHKDT   Documentation/devicetree/bindings/arm/amlogic/amlogic,meson-gx-ao=
-secure.yaml
  CHKDT   Documentation/devicetree/bindings/arm/sti.yaml
  CHKDT   Documentation/devicetree/bindings/arm/primecell.yaml
  CHKDT   Documentation/devicetree/bindings/arm/cpus.yaml
  CHKDT   Documentation/devicetree/bindings/bus/allwinner,sun50i-a64-de2.ya=
ml
  CHKDT   Documentation/devicetree/bindings/bus/allwinner,sun8i-a23-rsb.yam=
l
  CHKDT   Documentation/devicetree/bindings/clock/fixed-factor-clock.yaml
  CHKDT   Documentation/devicetree/bindings/clock/milbeaut-clock.yaml
  CHKDT   Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-ccu.y=
aml
  CHKDT   Documentation/devicetree/bindings/clock/imx8mn-clock.yaml
  CHKDT   Documentation/devicetree/bindings/clock/fixed-clock.yaml
  CHKDT   Documentation/devicetree/bindings/crypto/allwinner,sun4i-a10-cryp=
to.yaml
  CHKDT   Documentation/devicetree/bindings/display/panel/ampire,am-480272h=
3tmqw-t01h.yaml
  CHKDT   Documentation/devicetree/bindings/display/panel/innolux,ee101ia-0=
1d.yaml
  CHKDT   Documentation/devicetree/bindings/display/panel/pda,91-00156-a0.y=
aml
  CHKDT   Documentation/devicetree/bindings/display/panel/sitronix,st7701.y=
aml
  CHKDT   Documentation/devicetree/bindings/display/panel/nec,nl8048hl11.ya=
ml
  CHKDT   Documentation/devicetree/bindings/display/panel/friendlyarm,hd702=
e.yaml
  CHKDT   Documentation/devicetree/bindings/display/panel/bananapi,s070wv20=
-ct16.yaml
  CHKDT   Documentation/devicetree/bindings/display/panel/feiyang,fy07024di=
26a30d.yaml
  CHKDT   Documentation/devicetree/bindings/display/panel/dlc,dlc0700yzg-1.=
yaml
  CHKDT   Documentation/devicetree/bindings/display/panel/koe,tx31d200vm0ba=
a.yaml
  CHKDT   Documentation/devicetree/bindings/display/panel/mitsubishi,aa121t=
d01.yaml
  CHKDT   Documentation/devicetree/bindings/display/panel/sony,acx424akp.ya=
ml
  CHKDT   Documentation/devicetree/bindings/display/panel/logicpd,type28.ya=
ml
  CHKDT   Documentation/devicetree/bindings/display/panel/tfc,s9700rtwv43tr=
-01b.yaml
  CHKDT   Documentation/devicetree/bindings/display/panel/ti,nspire.yaml
  CHKDT   Documentation/devicetree/bindings/display/panel/tpo,tpg110.yaml
  CHKDT   Documentation/devicetree/bindings/display/panel/rocktech,rk070er9=
427.yaml
  CHKDT   Documentation/devicetree/bindings/display/panel/armadeus,st0700-a=
dapt.yaml
  CHKDT   Documentation/devicetree/bindings/display/panel/raspberrypi,7inch=
-touchscreen.yaml
  CHKDT   Documentation/devicetree/bindings/display/panel/lvds.yaml
  CHKDT   Documentation/devicetree/bindings/display/panel/panel-common.yaml
  CHKDT   Documentation/devicetree/bindings/display/panel/sgd,gktw70sdae4se=
.yaml
  CHKDT   Documentation/devicetree/bindings/display/panel/mitsubishi,aa104x=
d12.yaml
  CHKDT   Documentation/devicetree/bindings/display/panel/ronbo,rb070d30.ya=
ml
  CHKDT   Documentation/devicetree/bindings/display/amlogic,meson-vpu.yaml
  CHKDT   Documentation/devicetree/bindings/display/dsi-controller.yaml
  CHKDT   Documentation/devicetree/bindings/display/bridge/lvds-codec.yaml
  CHKDT   Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.y=
aml
  CHKDT   Documentation/devicetree/bindings/display/simple-framebuffer.yaml
  CHKDT   Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mip=
i-dsi.yaml
  CHKDT   Documentation/devicetree/bindings/dma/dma-router.yaml
  CHKDT   Documentation/devicetree/bindings/dma/dma-controller.yaml
  CHKDT   Documentation/devicetree/bindings/dma/allwinner,sun50i-a64-dma.ya=
ml
  CHKDT   Documentation/devicetree/bindings/dma/allwinner,sun4i-a10-dma.yam=
l
  CHKDT   Documentation/devicetree/bindings/dma/dma-common.yaml
  CHKDT   Documentation/devicetree/bindings/dma/allwinner,sun6i-a31-dma.yam=
l
  CHKDT   Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
  CHKDT   Documentation/devicetree/bindings/example-schema.yaml
  CHKDT   Documentation/devicetree/bindings/firmware/intel,ixp4xx-network-p=
rocessing-engine.yaml
/home/jagan/work/code/drm-misc/Documentation/devicetree/bindings/firmware/i=
ntel,ixp4xx-network-processing-engine.yaml:
properties:reg:minItems: False schema does not allow 3
/home/jagan/work/code/drm-misc/Documentation/devicetree/bindings/firmware/i=
ntel,ixp4xx-network-processing-engine.yaml:
properties:reg:maxItems: False schema does not allow 3
Documentation/devicetree/bindings/Makefile:12: recipe for target
'Documentation/devicetree/bindings/firmware/intel,ixp4xx-network-processing=
-engine.example.dts'
failed
make[1]: *** [Documentation/devicetree/bindings/firmware/intel,ixp4xx-netwo=
rk-processing-engine.example.dts]
Error 1
Makefile:1263: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2
