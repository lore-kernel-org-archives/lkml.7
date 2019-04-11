Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D6F7C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 11:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 095F7217D4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 11:36:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbfDKLgr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 07:36:47 -0400
Received: from gloria.sntech.de ([185.11.138.130]:57232 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbfDKLgr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 07:36:47 -0400
Received: from wf0380.dip.tu-dresden.de ([141.76.181.124] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hEY0X-0007Va-Kj; Thu, 11 Apr 2019 13:36:41 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH] ARM: dts: rockchip: Remove unnecessary setting of UART0 SCLK rate on veyron
Date:   Thu, 11 Apr 2019 13:36:41 +0200
Message-ID: <1607560.o8nNNBouYe@phil>
In-Reply-To: <20190410183010.21307-1-mka@chromium.org>
References: <20190410183010.21307-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 10. April 2019, 20:30:10 CEST schrieb Matthias Kaehlcke:
> Some veyron devices have a Bluetooth controller connected on UART0.
> The UART needs to operate at a high speed, however setting the clock
> rate at initialization has no practical effect. During initialization
> user space adjusts the UART baudrate multiple times, which ends up
> changing the SCLK rate. After a successful initiatalization the clk
> is running at the desired speed (48MHz).
> 
> Remove the unnecessary clock rate configuration from the DT.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>

applied for 5.2 with Doug's RB.

Thanks
Heiko


