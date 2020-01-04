Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3EC7C33C99
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 21:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 772C824650
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 21:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgADVTp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 16:19:45 -0500
Received: from gloria.sntech.de ([185.11.138.130]:56008 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbgADVTp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 16:19:45 -0500
Received: from p508fd2bb.dip0.t-ipconnect.de ([80.143.210.187] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1inqpb-00046u-FL; Sat, 04 Jan 2020 22:19:35 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Markus Reichl <m.reichl@fivetechno.de>
Cc:     linux-rockchip@lists.infradead.org,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        devicetree@vger.kernel.org,
        Jagan Teki <jagan@amarulasolutions.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: Re: [PATCH 0/5] regulator: mp8859: add driver for DC/DC converter used on rk3399-roc-pc board
Date:   Sat, 04 Jan 2020 22:19:34 +0100
Message-ID: <9349117.str0dnau1D@phil>
In-Reply-To: <20200104153321.6584-1-m.reichl@fivetechno.de>
References: <20200104153321.6584-1-m.reichl@fivetechno.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Markus,

I've only gotten patches 3+5 of this series (vendor-prefix+dts patch), so
maybe you could teach your git-send-email to include all patches to all
recipients.

Am Samstag, 4. Januar 2020, 16:32:44 CET schrieb Markus Reichl:
> On rk3399-roc-pc board a voltage regulator MP8859 from Monolithic Power Systems
> is used to supply the 12V power line. This delivers 5V as a default value after
> boot. The voltage is controllable via I2C.
> Add a basic driver to set and get the voltage of the MP8859 and add a matching
> node with fixed 12V in the DT of the board. 
> 
> Markus Reichl (5):
>   regulator: mp8859: add driver
>   regulator: mp8859: add config option and build entry

I think these two should only need one patch together.

Heiko

>   dt-bindings: add vendor Monolithic Power Systems
>   dt-bindings: regulator: add MPS mp8859 voltage regulator
>   arm64: dts: rockchip: Enable mp8859 regulator on rk3399-roc-pc
> 
>  .../devicetree/bindings/regulator/mp8859.txt  |  22 +++
>  .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
>  .../boot/dts/rockchip/rk3399-roc-pc.dtsi      |  32 ++--
>  drivers/regulator/Kconfig                     |  11 ++
>  drivers/regulator/Makefile                    |   1 +
>  drivers/regulator/mp8859.c                    | 156 ++++++++++++++++++
>  6 files changed, 210 insertions(+), 14 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/regulator/mp8859.txt
>  create mode 100644 drivers/regulator/mp8859.c
> 
> 




