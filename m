Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB310C282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 13:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A96B920872
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 13:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555508921;
	bh=NO/y6ghYS3bcm/EBh0oVsR+r32vzDNtTg2pQBGtkCWg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=xnpXOFKe1vGQ6BehlOsmxPhFYo6+jOgpv1p41m8En30HySN2zCqBI8XDLK8sGp1r1
	 RjMRHgIQx+wGCMyBtca2JswgUkTsBfxhkrY+5SRrLEkQMjH1ENaSH9lwe3HZWwz8At
	 769jSpw6L4ycyM2T9Xt0sEAUt6MeAgyogtEPChYw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732340AbfDQNsk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 09:48:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:50308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732233AbfDQNsk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 09:48:40 -0400
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2019E217F4;
        Wed, 17 Apr 2019 13:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555508919;
        bh=NO/y6ghYS3bcm/EBh0oVsR+r32vzDNtTg2pQBGtkCWg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=INlZa0D49dxyNqoX7u6UnzkJ9vvTPXT26vu1DMyASeADtTLvehx5+gjGpu9YH5pYs
         GLhC8IcKczCZjTtbmaL/A2z+V2VaxLc6jHCB6GMLdzm5acpm/wxbpd7ocC1wS3RX8n
         lxz9XPbpVHnpahPl6QCOmqwHZc3rT/RXS6baxfdE=
Received: by mail-qt1-f178.google.com with SMTP id x12so27354678qts.7;
        Wed, 17 Apr 2019 06:48:39 -0700 (PDT)
X-Gm-Message-State: APjAAAXHYQnwJOANgY8DWVOSJZHe5EndPMURqdvp1TW4Xz36syqvUXpL
        lRyksLyBvjkEdjcU1n9M9pots3yebM/rTfWDaw==
X-Google-Smtp-Source: APXvYqycatSphEF0B6ixOStXtIDoes4JwEYO/vpsqJex2P9Vluev60CGrIARRQv94ymo/JD9IrYamo+ZX8+Kwvk2Xcc=
X-Received: by 2002:ac8:33cf:: with SMTP id d15mr73439780qtb.149.1555508918386;
 Wed, 17 Apr 2019 06:48:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190414200824.28348-1-paul@crapouillou.net>
In-Reply-To: <20190414200824.28348-1-paul@crapouillou.net>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 17 Apr 2019 08:48:26 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJk1qdKzeM+1n3ve65S43-B4Q93ns7Z7mOKidbFPA7KWw@mail.gmail.com>
Message-ID: <CAL_JsqJk1qdKzeM+1n3ve65S43-B4Q93ns7Z7mOKidbFPA7KWw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: Add doc for the ingenic-drm driver
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, od@zcrc.me,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 14, 2019 at 3:08 PM Paul Cercueil <paul@crapouillou.net> wrote:
>
> Add documentation for the devicetree bindings of the DRM driver for the

DRM is a Linuxism. What is the LCD controller h/w block called?

> JZ47xx family of SoCs from Ingenic.
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Tested-by: Artur Rojek <contact@artur-rojek.eu>
> ---
>
> Notes:
>     v2: Remove ingenic,panel property.
>
>     v3: - Rename compatible strings from ingenic,jz47XX-drm to ingenic,jz47XX-lcd
>         - The ingenic,lcd-mode property is now read from the panel node instead
>           of from the driver node
>
>  .../devicetree/bindings/display/ingenic,drm.txt    | 53 ++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/ingenic,drm.txt
>
> diff --git a/Documentation/devicetree/bindings/display/ingenic,drm.txt b/Documentation/devicetree/bindings/display/ingenic,drm.txt
> new file mode 100644
> index 000000000000..9de47db8a515
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/ingenic,drm.txt
> @@ -0,0 +1,53 @@
> +Ingenic JZ47xx DRM driver
> +
> +Required properties:
> +- compatible: one of:
> +  * ingenic,jz4740-lcd
> +  * ingenic,jz4725b-lcd
> +- reg: LCD registers location and length
> +- clocks: LCD pixclock and device clock specifiers.
> +          The device clock is only required on the JZ4740.
> +- clock-names: "lcd_pclk" and "lcd"
> +- interrupts: Specifies the interrupt line the LCD controller is connected to.
> +
> +Optional properties in the panel mode:
> +- ingenic,lcd-mode: LCD mode to use with the display panel.
> +                   See <dt-bindings/display/ingenic,drm.h> for all the
> +                   possible values.
> +
> +Example:
> +
> +#include <dt-bindings/display/ingenic,drm.h>
> +
> +panel {
> +       compatible = "sharp,ls020b1dd01d", "simple-panel";

'simple-panel' is not a valid compatible string.


> +
> +       backlight = <&backlight>;
> +       power-supply = <&vcc>;
> +
> +       ingenic,lcd-mode = <JZ_LCD_SPECIAL_TFT_2>;
> +
> +       port {
> +               panel_input: endpoint {
> +                       remote-endpoint = <&panel_output>;
> +               };
> +       };
> +};
> +
> +
> +lcd: lcd-controller@13050000 {
> +       compatible = "ingenic,jz4725b-lcd";
> +       reg = <0x13050000 0x1000>;
> +
> +       interrupt-parent = <&intc>;
> +       interrupts = <31>;
> +
> +       clocks = <&cgu JZ4725B_CLK_LCD>;
> +       clock-names = "lcd";
> +
> +       port {
> +               panel_output: endpoint {
> +                       remote-endpoint = <&panel_input>;
> +               };
> +       };
> +};
> --
> 2.11.0
>
