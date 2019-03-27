Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E77C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 12:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3FDB2087C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 12:00:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728726AbfC0MAV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 08:00:21 -0400
Received: from gloria.sntech.de ([185.11.138.130]:46164 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726241AbfC0MAV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 08:00:21 -0400
Received: from we0652.dip.tu-dresden.de ([141.76.178.140] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1h97E9-0003Oi-By; Wed, 27 Mar 2019 13:00:17 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Katsuhiro Suzuki <katsuhiro@katsuster.net>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] arm64: dts: rockchip: add rk3399 UART DMAs
Date:   Wed, 27 Mar 2019 13:00:16 +0100
Message-ID: <14265087.Gbs4YZABJo@phil>
In-Reply-To: <e7bcf8b9-123e-eb30-f47d-7f8855f30ccb@katsuster.net>
References: <20190321162244.10080-1-katsuhiro@katsuster.net> <f2d0a95f-33c0-cdeb-80e3-0cd04bd0871d@arm.com> <e7bcf8b9-123e-eb30-f47d-7f8855f30ccb@katsuster.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Dienstag, 26. März 2019, 14:49:16 CET schrieb Katsuhiro Suzuki:
> Hello Robin,
> 
> Sorry for inconvenience. Since I don't adhere enabling DMA for UARTs,
> please revert my patch if you need.

I've dropped the patch from my queue now.

> BTW, there are DMA properties in RK3328 device-tree like as this patch.
> RK3328 UART DMA could not work correctly too...??

I remember Rockcihip dma-controllers having issues with burst-sizes
and flushing (there is a no-flushp option in pl330), so it's
possible that all share the same error up to rk3399 and rk3328

But so far no-one has shouted regarding the rk3328.


Heiko

> On 2019/03/26 20:48, Robin Murphy wrote:
> > On 25/03/2019 12:34, Heiko Stuebner wrote:
> >> Am Donnerstag, 21. März 2019, 17:22:44 CET schrieb Katsuhiro Suzuki:
> >>> Add UART dma channels as specified by the rk3399 TRM.
> >>>
> >>> Refer:
> >>> RK3399 TRM V1.4: Chapter 12 DMA Controller
> >>>
> >>> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
> >>
> >> applied for 5.2
> > 
> > As a heads-up, I did manage to try my board with this patch applied over 
> > the weekend, and it makes probing the bluetooth adapter fail with 
> > communication errors, so I'm not sure the 8250 and pl330 drivers are 
> > really cooperating well enough :(
> > 
> > Robin.
> > 
> 
> 




