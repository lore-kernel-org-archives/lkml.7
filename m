Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A903BC28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 12:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D48C206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 12:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="jFQJ8sWW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbfFEMsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 08:48:06 -0400
Received: from node.akkea.ca ([192.155.83.177]:42086 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727771AbfFEMsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 08:48:06 -0400
Received: by node.akkea.ca (Postfix, from userid 33)
        id 845294E204B; Wed,  5 Jun 2019 12:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1559738885; bh=4G8drEWVDsSUxde1v/aWuPz/7AuCPQhGSOON2KqYldk=;
        h=To:Subject:Date:From:Cc:In-Reply-To:References;
        b=jFQJ8sWWVPCGuuW1hRarwNc71Ru0ltSSMcPhNDMGafPukBNxobGa/Wu3rNqnYq7Y5
         8OY2bpF5/RSBgxKes0C1GdxbehX0TI8GFOaeJfbI0mMQJz8m+TAp1IFvVZirOxCftB
         iIC5UnAfmCCrXMf/yM4RCrZm4gwhrckIT0fahs+s=
To:     Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v15 0/3] Add support for the Purism Librem5 devkit
X-PHP-Originating-Script: 1000:rcube.php
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 05 Jun 2019 06:48:05 -0600
From:   Angus Ainslie <angus@akkea.ca>
Cc:     Pavel Machek <pavel@ucw.cz>, angus.ainslie@puri.sm,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Carlo Caione <ccaione@baylibre.com>,
        =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190605090315.GJ29853@dragon>
References: <20190528125747.1047-1-angus@akkea.ca>
 <20190605090315.GJ29853@dragon>
Message-ID: <db174b0173d0bcdb9ab5ff4e2e1cc4bc@www.akkea.ca>
X-Sender: angus@akkea.ca
User-Agent: Roundcube Webmail/1.1.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-06-05 03:03, Shawn Guo wrote:
> On Tue, May 28, 2019 at 05:57:44AM -0700, Angus Ainslie (Purism) wrote:
>> The Librem5 devkit is based on the imx8mq from NXP. This is a default
>> devicetree to boot the board to a command prompt.
>> 
>> Changes since v14:
>> 
>> Add regulator-always-on for the SNVS regulators.
>> Added pgc nodes.
>> Fixed charger pre-current.
> 
> Since Pavel was reviewing your patches, you should copy him on the new
> version.  Has this version addressed all his review comments?
> 

Sorry I had meant to include him in the CC.

I believe so but don't want to speak for him so we should see if he has 
anymore.

Angus

> Shawn
> 
>> 
>> Changes since v13:
>> 
>> Moved haptic motor from pwm-led to gpio-vibrator.
>> Cleaned up regulator node naming.
>> Whitescpace cleanup.
>> Re-indent pinmux stanzas.
>> Drop pwm2 node.
>> Drop MAINTAINERS patch.
>> 
>> Changes since v12:
>> 
>> Updated patch to vendor-prefixes.yaml.
>> Dropped always on from regulators.
>> 
>> Changes since v11:
>> 
>> Added reviewed-by tags.
>> Fixed subject typo.
>> 
>> Changes since v10:
>> 
>> Moved MAINTAINERS entry to "ARM/FREESCALE IMX" section
>> 
>> Changes since v9:
>> 
>> Added a MAINTAINERS entry for arm64 imx devicetree files.
>> 
>> Changes since v8:
>> 
>> Fixed license comment.
>> Changed regulators to all lower case.
>> Changed clock frequency for NXP errata e7805.
>> Dropped blank line.
>> 
>> Changes since v7:
>> 
>> More regulators always on for USB.
>> Add vbus regulator.
>> Drop vbat regulator.
>> Replace legacy "gpio-key,wakeup" with "wakeup-source".
>> Add vbus-supply to get rid of warning
>> imx8mq-usb-phy 382f0040.usb-phy: 382f0040.usb-phy supply vbus not 
>> found,
>> using dummy regulator
>> 
>> Changes since v6:
>> 
>> Dropped unused regulators.
>> Fix regulator phandles case.
>> Dropped extra whitespace.
>> 
>> Changes since v5:
>> 
>> Added reviewed-by tags.
>> Moved USB port links to USB controller node.
>> 
>> Changes since v4:
>> 
>> Compiled against linux-next next-20190415.
>> Added imx8mq to the arm yaml file.
>> Re-arrange regulator nodes to drop undefined supplies.
>> Additional ordering for aesthetics.
>> Split some long lines.
>> Added lots of blank lines.
>> Moved pinctl muxes to where they are used.
>> Cleaned out reg defintions from regulator nodes.
>> 
>> Changes since v3:
>> 
>> Freshly sorted and pressed nodes.
>> Change the backlight to an interpolated scale.
>> Dropped i2c2.
>> Dropped devkit version number to match debian MR.
>> 
>> Changes since v2:
>> 
>> Fixed incorrect phy-supply for the fsl-fec.
>> Dropped unused regulator property.
>> Fixup Makefile for linux-next.
>> 
>> Changes since v1:
>> 
>> Dropped config file.
>> Updated the board compatible label.
>> Changed node names to follow naming conventions.
>> Added a more complete regulator hierachy.
>> Removed unused nodes.
>> Removed unknown devices.
>> Fixed comment style.
>> Dropped undocumented properties.
>> 
>> Angus Ainslie (Purism) (3):
>>   arm64: dts: fsl: librem5: Add a device tree for the Librem5 devkit
>>   dt-bindings: Add an entry for Purism SPC
>>   dt-bindings: arm: fsl: Add the imx8mq boards
>> 
>>  .../devicetree/bindings/arm/fsl.yaml          |   7 +
>>  .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
>>  arch/arm64/boot/dts/freescale/Makefile        |   1 +
>>  .../dts/freescale/imx8mq-librem5-devkit.dts   | 806 
>> ++++++++++++++++++
>>  4 files changed, 816 insertions(+)
>>  create mode 100644 
>> arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
>> 
>> --
>> 2.17.1
>> 

