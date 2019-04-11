Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF2E4C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 12:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95C9421852
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 12:46:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbfDKMqT convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 08:46:19 -0400
Received: from gloria.sntech.de ([185.11.138.130]:58096 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726676AbfDKMqS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 08:46:18 -0400
Received: from wf0380.dip.tu-dresden.de ([141.76.181.124] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hEZ5r-0007ws-Or; Thu, 11 Apr 2019 14:46:15 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] arm64: dts: rockchip: add rk3399 UART DMAs
Date:   Thu, 11 Apr 2019 14:46:15 +0200
Message-ID: <2463729.IUJ8mRE5Ts@phil>
In-Reply-To: <69d5d0fd-00c3-36ae-596e-1b9f9452a07a@arm.com>
References: <20190321162244.10080-1-katsuhiro@katsuster.net> <14265087.Gbs4YZABJo@phil> <69d5d0fd-00c3-36ae-596e-1b9f9452a07a@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

Am Samstag, 30. März 2019, 00:24:16 CEST schrieb Robin Murphy:
> On 2019-03-27 12:00 pm, Heiko Stuebner wrote:
> > Hi,
> > 
> > Am Dienstag, 26. März 2019, 14:49:16 CET schrieb Katsuhiro Suzuki:
> >> Hello Robin,
> >>
> >> Sorry for inconvenience. Since I don't adhere enabling DMA for UARTs,
> >> please revert my patch if you need.
> > 
> > I've dropped the patch from my queue now.
> > 
> >> BTW, there are DMA properties in RK3328 device-tree like as this patch.
> >> RK3328 UART DMA could not work correctly too...??
> > 
> > I remember Rockcihip dma-controllers having issues with burst-sizes
> > and flushing (there is a no-flushp option in pl330), so it's
> > possible that all share the same error up to rk3399 and rk3328
> > 
> > But so far no-one has shouted regarding the rk3328.
> 
> Let me be the first, then, I guess :)
> 
> I found an easy way to observe the problem on my 3399, and I've just 
> fired up my 3328 box with a 5.0 distro kernel to find that it behaves 
> the same. Basically just dump a large pile of text into 'less' on the 
> serial console, and scroll through line-by-line - certain lines get 
> dropped except for a few characters at the end.
> 
> I'll see if I can narrow it down a bit, starting with trying 
> broken-flushp...

did you manage to find time for that test you wanted to do?

Heiko


