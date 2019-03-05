Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C83BDC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 00:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98892206B8
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 00:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbfCEAJL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 19:09:11 -0500
Received: from gloria.sntech.de ([185.11.138.130]:54322 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbfCEAJK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 19:09:10 -0500
Received: from ip5f5a6320.dynamic.kabel-deutschland.de ([95.90.99.32] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1h0xdn-00049J-4N; Tue, 05 Mar 2019 01:09:03 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Alexis Ballier <aballier@gentoo.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Add support for the Orange Pi RK3399 board.
Date:   Tue, 05 Mar 2019 01:09:02 +0100
Message-ID: <6883364.SkcVJV222b@phil>
In-Reply-To: <20190222184419.14469-1-aballier@gentoo.org>
References: <20190222184419.14469-1-aballier@gentoo.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 22. Februar 2019, 19:44:19 CET schrieb Alexis Ballier:
> This adds basic support for the Orange Pi RK3399 board.
> What works:
> - SD card / emmc.
> - Debug UART
> - Ethernet
> - USB: Type C, internal USB3 for SATA, 4 USB 2.0 ports
> - Sensors: All of them but the Hall sensor.
> - Buttons
> - Wifi, Bluetooth
> - HDMI out
> 
> Signed-off-by: Alexis Ballier <aballier@gentoo.org>

I did reorder some nodes and properties and also moved the binding
entry to its correct alphabetical position and applied the patch for 5.2

Thanks
Heiko


