Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D92B1C3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 07:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3C3F2077B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 07:53:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbfH3HxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 03:53:20 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:45343 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727417AbfH3HxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 03:53:20 -0400
Received: from [172.20.10.2] (tmo-106-216.customers.d1-online.com [80.187.106.216])
        by mail.holtmann.org (Postfix) with ESMTPSA id B6BBBCECD9;
        Fri, 30 Aug 2019 10:02:03 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [RESEND PATCH 0/5] Add bluetooth support for Orange Pi 3
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190823103139.17687-1-megous@megous.com>
Date:   Fri, 30 Aug 2019 09:53:16 +0200
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <5524D5E9-FA82-4244-A91F-78CF1C3FB3FB@holtmann.org>
References: <20190823103139.17687-1-megous@megous.com>
To:     megous@megous.com
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ondrej,

> (Resend to add missing lists, sorry for the noise.)
> 
> This series implements bluetooth support for Xunlong Orange Pi 3 board.
> 
> The board uses AP6256 WiFi/BT 5.0 chip.
> 
> Summary of changes:
> 
> - add more delay to let initialize the chip
> - let the kernel detect firmware file path
> - add new compatible and update dt-bindings
> - update Orange Pi 3 / H6 DTS
> 
> Please take a look.
> 
> thank you and regards,
>  Ondrej Jirman
> 
> Ondrej Jirman (5):
>  dt-bindings: net: Add compatible for BCM4345C5 bluetooth device
>  bluetooth: bcm: Add support for loading firmware for BCM4345C5
>  bluetooth: hci_bcm: Give more time to come out of reset
>  arm64: dts: allwinner: h6: Add pin configs for uart1
>  arm64: dts: allwinner: orange-pi-3: Enable UART1 / Bluetooth
> 
> .../bindings/net/broadcom-bluetooth.txt       |  1 +
> .../dts/allwinner/sun50i-h6-orangepi-3.dts    | 19 +++++++++++++++++++
> arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  | 10 ++++++++++
> drivers/bluetooth/btbcm.c                     |  3 +++
> drivers/bluetooth/hci_bcm.c                   |  3 ++-
> 5 files changed, 35 insertions(+), 1 deletion(-)

all 5 patches have been applied to bluetooth-next tree.

Regards

Marcel

