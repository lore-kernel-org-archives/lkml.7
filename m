Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EEEEC3F68F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 00:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5136020721
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 00:03:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfLIADG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 19:03:06 -0500
Received: from gloria.sntech.de ([185.11.138.130]:37214 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726845AbfLIADG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 19:03:06 -0500
Received: from ip5f5a6266.dynamic.kabel-deutschland.de ([95.90.98.102] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1ie6Vy-0005fW-Tm; Mon, 09 Dec 2019 01:03:02 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Douglas Anderson <dianders@chromium.org>
Cc:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>,
        linux-rockchip@lists.infradead.org,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/1] ARM: dts: rockchip: Add brcm bluetooth for rk3288-veyron
Date:   Mon, 09 Dec 2019 01:03:00 +0100
Message-ID: <1788857.Va9C3Z3akr@diego>
In-Reply-To: <61639BAF-5AA0-4264-906F-E24E2A30088D@holtmann.org>
References: <20191127223909.253873-1-abhishekpandit@chromium.org> <20191127223909.253873-2-abhishekpandit@chromium.org> <61639BAF-5AA0-4264-906F-E24E2A30088D@holtmann.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 9. Dezember 2019, 00:48:31 CET schrieb Marcel Holtmann:
> > This enables the Broadcom uart bluetooth driver on uart0 and gives it
> > ownership of its gpios. In order to use this, you must enable the
> > following kconfig options:
> > - CONFIG_BT_HCIUART_BCM
> > - CONFIG_SERIAL_DEV
> > 
> > This is applicable to rk3288-veyron series boards that use the bcm43540
> > wifi+bt chips.
> > 
> > As part of this change, also refactor the pinctrl across the various
> > boards. All the boards using broadcom bluetooth shouldn't touch the
> > bt_dev_wake pin.
> 
> so have these changes being merged?

not yet

Doug wanted to give a Reviewed-by, once the underlying bluetooth
changes got merged - not sure what the status is though.

Heiko


