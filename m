Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54831C00454
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 22:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32E0120828
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 22:32:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729672AbfLJWcp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 17:32:45 -0500
Received: from gloria.sntech.de ([185.11.138.130]:33624 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728109AbfLJWcm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 17:32:42 -0500
Received: from ip5f5a6266.dynamic.kabel-deutschland.de ([95.90.98.102] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1ieo3b-0001KO-MX; Tue, 10 Dec 2019 23:32:39 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Cc:     dianders@chromium.org, linux-bluetooth@vger.kernel.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/1] ARM: dts: rockchip: Add brcm bluetooth for rk3288-veyron
Date:   Tue, 10 Dec 2019 23:32:38 +0100
Message-ID: <4093066.yl7jOIBBcd@phil>
In-Reply-To: <20191127223909.253873-2-abhishekpandit@chromium.org>
References: <20191127223909.253873-1-abhishekpandit@chromium.org> <20191127223909.253873-2-abhishekpandit@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 27. November 2019, 23:39:09 CET schrieb Abhishek Pandit-Subedi:
> This enables the Broadcom uart bluetooth driver on uart0 and gives it
> ownership of its gpios. In order to use this, you must enable the
> following kconfig options:
> - CONFIG_BT_HCIUART_BCM
> - CONFIG_SERIAL_DEV
> 
> This is applicable to rk3288-veyron series boards that use the bcm43540
> wifi+bt chips.
> 
> As part of this change, also refactor the pinctrl across the various
> boards. All the boards using broadcom bluetooth shouldn't touch the
> bt_dev_wake pin.
> 
> Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>

applied for 5.6 with Matthias' Rb.

Thanks
Heiko


