Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3584EC3B1AA
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65BDF246C0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576269506;
	bh=2MyY3e3C9u668NDTd1DHUO0Wkkl4xB75lFFN94drrjE=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=A08qZwqKW6mr1HOHvudSjXGAEbmygU1SG6AwDA7QzEZqTgC9OMSkJOt5EoK2FSY5s
	 muIZdfoaHkwskyYzNWX+1tEm5Hg19W1gMr+drzXP/Lbamzg/KYjajmk93AgLwv4sJF
	 NzHfc5mYFvd/a+1yuZAVHwgN68ZKsfhNQNM/fGzo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbfLMPfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 10:35:34 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41673 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727831AbfLMPfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 10:35:33 -0500
Received: by mail-oi1-f196.google.com with SMTP id i1so1225633oie.8;
        Fri, 13 Dec 2019 07:35:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=miXIJmEni/sWO257xPSeM4sPbQdvnjyyfE6aO/Df5fU=;
        b=btTV4N4sYfeV5Hp21HpbZz0eOfLgWc5pt/9CoVwNViPDPOZefatHRN4pJQFwWmrTP9
         ZoI5NDTg+j85KlQxhigqy045KGk8+0AeXDH4+uH5sUOqZ/coUY9pQxRMJPCMTyo/Btyo
         PhB9ZvIvdhOp5u0nQoz9VoDpRs+1Eh4P14m3KYMMYfCQMLn1ZM36nFDqfpRrDFMKZpwD
         aSnTyXqO33dMrS2JfoRI+JDXEK1g3FL6jqMttDHxf99b5KnxvttT6095xMMtwV4ASrhk
         2QvPr/DUh0YTYHdCOGR19p6GOBhG2xR1DG2TRgk/JS1YaACsioyrb79r5i4ITJDB3NID
         1cBw==
X-Gm-Message-State: APjAAAW7htRgxpgOOrHZNzEKEp3vpWwV0/PGOokcqdjsnV2TmRhy3IGY
        pTD2zKTTgsZ7lqp85+Z8vw==
X-Google-Smtp-Source: APXvYqzQdO0+IZGU0PtRT3ojxNaVaPt66HS9HFU9wyKE3Z5KKQCi/6+OZuWad52eDCwt3fplOQDA5A==
X-Received: by 2002:aca:5ad4:: with SMTP id o203mr7232580oib.73.1576251332537;
        Fri, 13 Dec 2019 07:35:32 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p24sm3416096oth.28.2019.12.13.07.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 07:35:31 -0800 (PST)
Date:   Fri, 13 Dec 2019 09:35:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Subject: [GIT PULL] Devicetree fixes for v5.5
Message-ID: <20191213153531.GA28973@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull a couple of DT fixes for v5.5.

Rob


The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:

  Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.5

for you to fetch changes up to ee9b280e17dce51c44e1d04d11eb0a4acd0ee1a9:

  of/platform: Unconditionally pause/resume sync state during kernel init (2019-12-12 18:39:52 -0600)

----------------------------------------------------------------
Devicetree fixes for v5.5:

- Fix for dependency tracking caused by unittest interaction

- Fix some schema errors in Tegra memory controller schema

- Update Maxime Ripard's email address

- Review fixes to TI cpsw-switch

- Add wakeup-source prop for STM32 rproc. Got dropped in the schema
  conversion.

----------------------------------------------------------------
Arnaud Pouliquen (1):
      dt-bindings: remoteproc: stm32: add wakeup-source property

Grygorii Strashko (1):
      dt-bindings: net: ti: cpsw-switch: update to fix comments

Maxime Ripard (1):
      dt-bindings: Change maintainer address

Rob Herring (1):
      dt-bindings: memory-controllers: tegra: Fix type references

Saravana Kannan (1):
      of/platform: Unconditionally pause/resume sync state during kernel init

 Documentation/devicetree/bindings/arm/sunxi.yaml   |  2 +-
 .../bindings/bus/allwinner,sun50i-a64-de2.yaml     |  2 +-
 .../bindings/bus/allwinner,sun8i-a23-rsb.yaml      |  2 +-
 .../bindings/clock/allwinner,sun4i-a10-ccu.yaml    |  2 +-
 .../crypto/allwinner,sun4i-a10-crypto.yaml         |  2 +-
 .../display/allwinner,sun6i-a31-mipi-dsi.yaml      |  2 +-
 .../bindings/display/panel/ronbo,rb070d30.yaml     |  2 +-
 .../bindings/dma/allwinner,sun4i-a10-dma.yaml      |  2 +-
 .../bindings/dma/allwinner,sun50i-a64-dma.yaml     |  2 +-
 .../bindings/dma/allwinner,sun6i-a31-dma.yaml      |  2 +-
 .../bindings/i2c/allwinner,sun6i-a31-p2wi.yaml     |  2 +-
 .../bindings/iio/adc/allwinner,sun8i-a33-ths.yaml  |  2 +-
 .../input/allwinner,sun4i-a10-lradc-keys.yaml      |  2 +-
 .../allwinner,sun4i-a10-ic.yaml                    |  2 +-
 .../allwinner,sun7i-a20-sc-nmi.yaml                |  2 +-
 .../bindings/media/allwinner,sun4i-a10-csi.yaml    |  2 +-
 .../bindings/media/allwinner,sun4i-a10-ir.yaml     |  2 +-
 .../memory-controllers/nvidia,tegra124-mc.yaml     |  3 ++-
 .../memory-controllers/nvidia,tegra30-emc.yaml     |  9 ++++++---
 .../memory-controllers/nvidia,tegra30-mc.yaml      |  3 ++-
 .../bindings/mfd/allwinner,sun4i-a10-ts.yaml       |  2 +-
 .../bindings/mmc/allwinner,sun4i-a10-mmc.yaml      |  2 +-
 .../bindings/mtd/allwinner,sun4i-a10-nand.yaml     |  2 +-
 .../bindings/net/allwinner,sun4i-a10-emac.yaml     |  2 +-
 .../bindings/net/allwinner,sun4i-a10-mdio.yaml     |  2 +-
 .../bindings/net/allwinner,sun7i-a20-gmac.yaml     |  2 +-
 .../bindings/net/allwinner,sun8i-a83t-emac.yaml    |  2 +-
 .../bindings/net/can/allwinner,sun4i-a10-can.yaml  |  2 +-
 .../devicetree/bindings/net/ti,cpsw-switch.yaml    | 22 +++++++---------------
 .../bindings/nvmem/allwinner,sun4i-a10-sid.yaml    |  2 +-
 .../phy/allwinner,sun6i-a31-mipi-dphy.yaml         |  2 +-
 .../pinctrl/allwinner,sun4i-a10-pinctrl.yaml       |  2 +-
 .../bindings/pwm/allwinner,sun4i-a10-pwm.yaml      |  2 +-
 .../bindings/remoteproc/st,stm32-rproc.yaml        |  2 ++
 .../bindings/rtc/allwinner,sun4i-a10-rtc.yaml      |  2 +-
 .../bindings/rtc/allwinner,sun6i-a31-rtc.yaml      |  2 +-
 .../bindings/serio/allwinner,sun4i-a10-ps2.yaml    |  2 +-
 .../bindings/sound/allwinner,sun4i-a10-codec.yaml  |  2 +-
 .../bindings/sound/allwinner,sun4i-a10-i2s.yaml    |  2 +-
 .../bindings/sound/allwinner,sun4i-a10-spdif.yaml  |  2 +-
 .../sound/allwinner,sun50i-a64-codec-analog.yaml   |  2 +-
 .../sound/allwinner,sun8i-a23-codec-analog.yaml    |  2 +-
 .../bindings/sound/allwinner,sun8i-a33-codec.yaml  |  2 +-
 .../bindings/spi/allwinner,sun4i-a10-spi.yaml      |  2 +-
 .../bindings/spi/allwinner,sun6i-a31-spi.yaml      |  2 +-
 .../bindings/timer/allwinner,sun4i-a10-timer.yaml  |  2 +-
 .../timer/allwinner,sun5i-a13-hstimer.yaml         |  2 +-
 .../bindings/usb/allwinner,sun4i-a10-musb.yaml     |  2 +-
 .../bindings/watchdog/allwinner,sun4i-a10-wdt.yaml |  2 +-
 drivers/of/platform.c                              |  6 +++---
 50 files changed, 66 insertions(+), 67 deletions(-)
