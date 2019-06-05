Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1713C282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 09:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E32220866
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 09:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559725419;
	bh=7oQg41xcoj3dVt4T0jDLoKl6UKw+TwF7gFJVO8yYM2Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=x9I0gkqUlJg46iLPcqyTRq2NmcIY7+Zy4a7Wp4bqlCNeo+IHq05johmQhT0Y7cz6c
	 RNh5ZZ3Rrn6gYzm42qO2jRJqnGMxTynJoSjwffSstbMtFY+PiMjq5Vj/APw6xktBWl
	 nBdWFL2o4Iotkqr2930sg7zqgoaIzuLOCAe20BGM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbfFEJDi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 05:03:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:33246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726823AbfFEJDi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 05:03:38 -0400
Received: from dragon (li1264-180.members.linode.com [45.79.165.180])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3040D2075C;
        Wed,  5 Jun 2019 09:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559725417;
        bh=7oQg41xcoj3dVt4T0jDLoKl6UKw+TwF7gFJVO8yYM2Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Uda6dfzApaEOc6glLrFxNX04FrsXa228DHOmHCZKa5g2jB0yJIgdCfsk3qeKfPJxb
         DhqgFJc/VX40B205oj92vcNpBHaGWqO53DcrWCY5YUk0D9CkGg8z0KlROlsHjim1m4
         NuwxUqRx3jlIp0nPlfuFgNDa2ftIs4IT183v+lCM=
Date:   Wed, 5 Jun 2019 17:03:17 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Pavel Machek <pavel@ucw.cz>
Cc:     angus.ainslie@puri.sm, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Carlo Caione <ccaione@baylibre.com>,
        Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v15 0/3] Add support for the Purism Librem5 devkit
Message-ID: <20190605090315.GJ29853@dragon>
References: <20190528125747.1047-1-angus@akkea.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528125747.1047-1-angus@akkea.ca>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 05:57:44AM -0700, Angus Ainslie (Purism) wrote:
> The Librem5 devkit is based on the imx8mq from NXP. This is a default
> devicetree to boot the board to a command prompt.
> 
> Changes since v14:
> 
> Add regulator-always-on for the SNVS regulators.
> Added pgc nodes.
> Fixed charger pre-current.

Since Pavel was reviewing your patches, you should copy him on the new
version.  Has this version addressed all his review comments?

Shawn

> 
> Changes since v13:
> 
> Moved haptic motor from pwm-led to gpio-vibrator.
> Cleaned up regulator node naming.
> Whitescpace cleanup.
> Re-indent pinmux stanzas.
> Drop pwm2 node.
> Drop MAINTAINERS patch.
> 
> Changes since v12:
> 
> Updated patch to vendor-prefixes.yaml.
> Dropped always on from regulators.
> 
> Changes since v11:
> 
> Added reviewed-by tags.
> Fixed subject typo.
> 
> Changes since v10:
> 
> Moved MAINTAINERS entry to "ARM/FREESCALE IMX" section
> 
> Changes since v9:
> 
> Added a MAINTAINERS entry for arm64 imx devicetree files.
> 
> Changes since v8:
> 
> Fixed license comment.
> Changed regulators to all lower case.
> Changed clock frequency for NXP errata e7805.
> Dropped blank line.
> 
> Changes since v7:
> 
> More regulators always on for USB.
> Add vbus regulator.
> Drop vbat regulator.
> Replace legacy "gpio-key,wakeup" with "wakeup-source".
> Add vbus-supply to get rid of warning
> imx8mq-usb-phy 382f0040.usb-phy: 382f0040.usb-phy supply vbus not found,
> using dummy regulator
> 
> Changes since v6:
> 
> Dropped unused regulators.
> Fix regulator phandles case.
> Dropped extra whitespace.
> 
> Changes since v5:
> 
> Added reviewed-by tags.
> Moved USB port links to USB controller node.
> 
> Changes since v4:
> 
> Compiled against linux-next next-20190415.
> Added imx8mq to the arm yaml file.
> Re-arrange regulator nodes to drop undefined supplies.
> Additional ordering for aesthetics.
> Split some long lines.
> Added lots of blank lines.
> Moved pinctl muxes to where they are used.
> Cleaned out reg defintions from regulator nodes.
> 
> Changes since v3:
> 
> Freshly sorted and pressed nodes.
> Change the backlight to an interpolated scale.
> Dropped i2c2.
> Dropped devkit version number to match debian MR.
> 
> Changes since v2:
> 
> Fixed incorrect phy-supply for the fsl-fec.
> Dropped unused regulator property.
> Fixup Makefile for linux-next.
> 
> Changes since v1:
> 
> Dropped config file.
> Updated the board compatible label.
> Changed node names to follow naming conventions.
> Added a more complete regulator hierachy.
> Removed unused nodes.
> Removed unknown devices.
> Fixed comment style.
> Dropped undocumented properties.
> 
> Angus Ainslie (Purism) (3):
>   arm64: dts: fsl: librem5: Add a device tree for the Librem5 devkit
>   dt-bindings: Add an entry for Purism SPC
>   dt-bindings: arm: fsl: Add the imx8mq boards
> 
>  .../devicetree/bindings/arm/fsl.yaml          |   7 +
>  .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
>  arch/arm64/boot/dts/freescale/Makefile        |   1 +
>  .../dts/freescale/imx8mq-librem5-devkit.dts   | 806 ++++++++++++++++++
>  4 files changed, 816 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
> 
> -- 
> 2.17.1
> 
