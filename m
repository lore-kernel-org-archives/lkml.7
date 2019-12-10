Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBEE8C2D0C4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 07:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CC56206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 07:44:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfLJHoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 02:44:08 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:40189 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbfLJHoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 02:44:08 -0500
Received: from marcel-macbook.fritz.box (p4FF9F0D1.dip0.t-ipconnect.de [79.249.240.209])
        by mail.holtmann.org (Postfix) with ESMTPSA id 9618DCED2A;
        Tue, 10 Dec 2019 08:53:16 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: [PATCH v2 1/1] ARM: dts: rockchip: Add brcm bluetooth for
 rk3288-veyron
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1788857.Va9C3Z3akr@diego>
Date:   Tue, 10 Dec 2019 08:44:05 +0100
Cc:     Douglas Anderson <dianders@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>,
        linux-rockchip@lists.infradead.org,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Message-Id: <B42F187B-C289-4140-841D-D1BF219E72D7@holtmann.org>
References: <20191127223909.253873-1-abhishekpandit@chromium.org>
 <20191127223909.253873-2-abhishekpandit@chromium.org>
 <61639BAF-5AA0-4264-906F-E24E2A30088D@holtmann.org>
 <1788857.Va9C3Z3akr@diego>
To:     =?utf-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
X-Mailer: Apple Mail (2.3601.0.10)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

>>> This enables the Broadcom uart bluetooth driver on uart0 and gives it
>>> ownership of its gpios. In order to use this, you must enable the
>>> following kconfig options:
>>> - CONFIG_BT_HCIUART_BCM
>>> - CONFIG_SERIAL_DEV
>>> 
>>> This is applicable to rk3288-veyron series boards that use the bcm43540
>>> wifi+bt chips.
>>> 
>>> As part of this change, also refactor the pinctrl across the various
>>> boards. All the boards using broadcom bluetooth shouldn't touch the
>>> bt_dev_wake pin.
>> 
>> so have these changes being merged?
> 
> not yet
> 
> Doug wanted to give a Reviewed-by, once the underlying bluetooth
> changes got merged - not sure what the status is though.

the Bluetooth changes have been merged into net-next.

Regards

Marcel

