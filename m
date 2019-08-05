Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF53C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 09:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 606872067D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 09:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564996308;
	bh=gnyC2hoSvEsXyEk+9SVSQxo8bU7dRT/umXsVQnWKG4A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=YriXl3o/mvrRbrdbeDMZOyRhtPHgHOJDLJpaOK9lx5wMiXQdya+83Qzblp4yfEgqg
	 oiS/5DltKV7TX50/7LSmFJMvPZFRjv8Z/Orw9e6I1R+McSpEaZ44/V/qpdJ5dOz46I
	 X0D5PVYmai3w9cafdQ6Varu3NX7sg+Rx8v8urdn4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbfHEJLr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 05:11:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:58378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727225AbfHEJLq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 05:11:46 -0400
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA22421842;
        Mon,  5 Aug 2019 09:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564996305;
        bh=gnyC2hoSvEsXyEk+9SVSQxo8bU7dRT/umXsVQnWKG4A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nruL27Rg7q7HfEkQNzU7wJ2xV9lrNztfc282jziQkjXRJ9CNrcLDC/LI+hxtgOjOF
         KDmh4tg6QH6idPdzDqZfUwEMmPHV+UTpmew2eKSIJHqIYGM6mUSsAb11Gjtxsf7TPF
         NZNC1kKTfnhszQnie0vz/V0TEadyb0BAIytVD9rc=
Received: by mail-lf1-f41.google.com with SMTP id h28so57284631lfj.5;
        Mon, 05 Aug 2019 02:11:44 -0700 (PDT)
X-Gm-Message-State: APjAAAWZZtOAL2sMfPqHBzgZe2QcY3NXzT/5Ga9sUyjtzUPFiqM2XpWh
        ASqFL4SISX0Fuhw4QG0QYAXf3qmsuDms23dRx5g=
X-Google-Smtp-Source: APXvYqwDlSml+qhxESCbGwIQMsZLOK8jHk11V3FXbMlZ3kbLC+2Wzk3e+sJqtEqsgY34UAHDeCL2JkUH8Mp8EQwF5DU=
X-Received: by 2002:a19:48c5:: with SMTP id v188mr69385360lfa.69.1564996303019;
 Mon, 05 Aug 2019 02:11:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190729172007.3275-1-krzk@kernel.org> <20190729172007.3275-2-krzk@kernel.org>
 <20190803154724.GS8870@X250.getinternet.no>
In-Reply-To: <20190803154724.GS8870@X250.getinternet.no>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 5 Aug 2019 11:11:31 +0200
X-Gmail-Original-Message-ID: <CAJKOXPc347ffPmwjtNWBwurEOip+0-8xoxoAJS6cw6JP4b4w-w@mail.gmail.com>
Message-ID: <CAJKOXPc347ffPmwjtNWBwurEOip+0-8xoxoAJS6cw6JP4b4w-w@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] ARM: dts: imx6ul-kontron-n6310: Add Kontron
 i.MX6UL N6310 SoM and boards
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Schrempf Frieder <frieder.schrempf@kontron.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Aug 2019 at 17:47, Shawn Guo <shawnguo@kernel.org> wrote:
>
> On Mon, Jul 29, 2019 at 07:20:07PM +0200, Krzysztof Kozlowski wrote:
> > Add support for i.MX6UL modules from Kontron Electronics GmbH (before
> > acquisition: Exceet Electronics) and evalkit boards based on it:
> >
> > 1. N6310 SOM: i.MX6 UL System-on-Module, a 25x25 mm solderable module
> >    (LGA pads and pin castellations) with 256 MB RAM, 1 MB NOR-Flash,
> >    256 MB NAND and other interfaces,
> > 2. N6310 S: evalkit, w/wo eMMC, without display,
> > 3. N6310 S 43: evalkit with 4.3" display,
> > 4. N6310 S 50: evalkit with 5.0" display.
> >
> > This includes device nodes for unsupported displays (Admatec
> > T043C004800272T2A and T070P133T0S301).
>
> Do not include unsupported devices.
>
> >
> > The work is based on Exceet/Kontron source code (GPLv2) with numerous
> > changes:
> > 1. Reorganize files,
> > 2. Rename Exceet -> Kontron,
> > 3. Rename models/compatibles to match newest Kontron product naming,
> > 4. Fix coding style errors and adjust to device tree coding guidelines,
> > 5. Fix DTC warnings,
> > 6. Extend compatibles so eval boards inherit the SoM compatible,
> > 7. Use defines instead of GPIO and interrupt flag values,
> > 8. Use proper vendor compatible for Macronix SPI NOR,
> > 9. Sort nodes alphabetically.
> >
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> >
> > ---
> >
> > Changes since v2, after Fabio's review:
> > 1. Add "imx6ul" compatible to board name (that's what I understood from
> >    review),
> > 2. Add vendor/device prefix to eeprom and document the compatible,
> > 3. Use "admatecde" as vendor compatible to avoid confusion with Admatec
> >    AG in Switzerland (also making LCD panels),
> > 4. Use generic names for nodes,
> > 5. Use IRQ_TYPE_LEVEL_LOW,
> > 6. Move iomux to the end of files,
> > 7. Remove regulators node (include regulators in top level),
> > 8. Remove cpu clock-frequency,
> > 9. Other minor fixes pointed by Fabio.
> >
> > Changes since v1, after Frieder's review:
> > 1. Remove unneeded license notes,
> > 2. Add Kontron copyright (2018),
> > 3. Rename the files/models/compatibles to new naming - N6310,
> > 4. Remove unneeded CPU operating points override,
> > 5. Switch regulator nodes into simple children nodes without addresses
> >    (so not simple bus),
> > 6. Use proper vendor compatible for Macronix SPI NOR.
> > ---
> >  .../devicetree/bindings/arm/fsl.yaml          |   4 +
> >  .../devicetree/bindings/eeprom/at25.txt       |   1 +
>
> Please make them two separate patches.

You mean split at25 change to separate patch? or split both - at25 and
fsl bindings - to separate patches?

Best regards,
Krzysztof
