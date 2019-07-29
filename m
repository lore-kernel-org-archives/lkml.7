Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA45C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 23:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 710032073F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 23:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564444663;
	bh=dMiQ9UZlmg1wAHtxio42rSqa++EhjehVjqhzpIB6zHk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=x0yqowkx2S9huxdcD/L8UtPj1uaPSlFaypCvAxh6dUDYaGpYG1Gr6kkVBGSBJJkme
	 8Dsicffp1gNFtjo4VNe+YT04+hwOmwNIt3Q6cnCcT4HTHOoAaM1mJAOVBlzbjfmP6A
	 x+XO+G4kI8ZBbHSJk9TRsp59YDWbxvB+e+yhqe+0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730038AbfG2X5m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 19:57:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:41850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728269AbfG2X5l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 19:57:41 -0400
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8F8A217D4;
        Mon, 29 Jul 2019 23:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564444661;
        bh=dMiQ9UZlmg1wAHtxio42rSqa++EhjehVjqhzpIB6zHk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tKJEyXgGfBY7H7BKIxmTMYPwSAO/utvz0nwSAmkPn9BOCrT+8tPV6iDr3Y+a2MSYF
         krQwN/QZrnIeeM/nei5mKyMdM+b9GIqvxwm8PS5zSSyqjViHgY1xOxK1d0G/HGhYBl
         oFc+99SD6JCHllpal1bVJU1aigfRUCnJItPHlh3c=
Received: by mail-qt1-f170.google.com with SMTP id 44so30255074qtg.11;
        Mon, 29 Jul 2019 16:57:40 -0700 (PDT)
X-Gm-Message-State: APjAAAUHbEnCw9GArcUYHfx7C7yQWOdvCoGmBuHR6MC8FcJq82eX+UD/
        zsB2RAh1JGVyhTLLxEpAnhogtyUpCnr0QiVEDA==
X-Google-Smtp-Source: APXvYqzqIx+OqBWGwJWFZkq/JHh6Bxb7CsxEjHR4Kg/yXnpoIkeGjg7iAKxv2ArGd8DHDR4pOnjB+vnRMW9wKJdyBN0=
X-Received: by 2002:ac8:3908:: with SMTP id s8mr33747911qtb.224.1564444659990;
 Mon, 29 Jul 2019 16:57:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190729172007.3275-1-krzk@kernel.org> <20190729172007.3275-2-krzk@kernel.org>
In-Reply-To: <20190729172007.3275-2-krzk@kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 29 Jul 2019 17:57:28 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKzsWQoc_xYXxkWa2eUdVwvCvxH-8g-2F90-_YmfU5_fg@mail.gmail.com>
Message-ID: <CAL_JsqKzsWQoc_xYXxkWa2eUdVwvCvxH-8g-2F90-_YmfU5_fg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] ARM: dts: imx6ul-kontron-n6310: Add Kontron
 i.MX6UL N6310 SoM and boards
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Schrempf Frieder <frieder.schrempf@kontron.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 11:20 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> Add support for i.MX6UL modules from Kontron Electronics GmbH (before
> acquisition: Exceet Electronics) and evalkit boards based on it:
>
> 1. N6310 SOM: i.MX6 UL System-on-Module, a 25x25 mm solderable module
>    (LGA pads and pin castellations) with 256 MB RAM, 1 MB NOR-Flash,
>    256 MB NAND and other interfaces,
> 2. N6310 S: evalkit, w/wo eMMC, without display,
> 3. N6310 S 43: evalkit with 4.3" display,
> 4. N6310 S 50: evalkit with 5.0" display.
>
> This includes device nodes for unsupported displays (Admatec
> T043C004800272T2A and T070P133T0S301).
>
> The work is based on Exceet/Kontron source code (GPLv2) with numerous
> changes:
> 1. Reorganize files,
> 2. Rename Exceet -> Kontron,
> 3. Rename models/compatibles to match newest Kontron product naming,
> 4. Fix coding style errors and adjust to device tree coding guidelines,
> 5. Fix DTC warnings,
> 6. Extend compatibles so eval boards inherit the SoM compatible,
> 7. Use defines instead of GPIO and interrupt flag values,
> 8. Use proper vendor compatible for Macronix SPI NOR,
> 9. Sort nodes alphabetically.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>
> ---
>
> Changes since v2, after Fabio's review:
> 1. Add "imx6ul" compatible to board name (that's what I understood from
>    review),
> 2. Add vendor/device prefix to eeprom and document the compatible,
> 3. Use "admatecde" as vendor compatible to avoid confusion with Admatec
>    AG in Switzerland (also making LCD panels),
> 4. Use generic names for nodes,
> 5. Use IRQ_TYPE_LEVEL_LOW,
> 6. Move iomux to the end of files,
> 7. Remove regulators node (include regulators in top level),
> 8. Remove cpu clock-frequency,
> 9. Other minor fixes pointed by Fabio.
>
> Changes since v1, after Frieder's review:
> 1. Remove unneeded license notes,
> 2. Add Kontron copyright (2018),
> 3. Rename the files/models/compatibles to new naming - N6310,
> 4. Remove unneeded CPU operating points override,
> 5. Switch regulator nodes into simple children nodes without addresses
>    (so not simple bus),
> 6. Use proper vendor compatible for Macronix SPI NOR.
> ---
>  .../devicetree/bindings/arm/fsl.yaml          |   4 +
>  .../devicetree/bindings/eeprom/at25.txt       |   1 +
>  arch/arm/boot/dts/Makefile                    |   3 +
>  .../boot/dts/imx6ul-kontron-n6310-s-43.dts    | 119 +++++
>  .../boot/dts/imx6ul-kontron-n6310-s-50.dts    | 119 +++++
>  arch/arm/boot/dts/imx6ul-kontron-n6310-s.dts  | 420 ++++++++++++++++++
>  .../boot/dts/imx6ul-kontron-n6310-som.dtsi    | 134 ++++++
>  7 files changed, 800 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx6ul-kontron-n6310-s-43.dts
>  create mode 100644 arch/arm/boot/dts/imx6ul-kontron-n6310-s-50.dts
>  create mode 100644 arch/arm/boot/dts/imx6ul-kontron-n6310-s.dts
>  create mode 100644 arch/arm/boot/dts/imx6ul-kontron-n6310-som.dtsi

Reviewed-by: Rob Herring <robh@kernel.org>
