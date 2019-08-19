Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 430BEC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 14:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16F572082A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 14:44:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbfHSOoU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 10:44:20 -0400
Received: from gloria.sntech.de ([185.11.138.130]:56932 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbfHSOoU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 10:44:20 -0400
Received: from c-73-71-116-68.hsd1.ca.comcast.net ([73.71.116.68] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hzisw-0007Hy-Me; Mon, 19 Aug 2019 16:43:50 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Kever Yang <kever.yang@rock-chips.com>
Cc:     linux-rockchip@lists.infradead.org, Chen-Yu Tsai <wens@csie.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tomohiro Mayama <parly-gh@iris.mystia.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm: dts: rockchip: fix vcc_host_5v regulator for usb3 host
Date:   Mon, 19 Aug 2019 16:43:45 +0200
Message-ID: <3811189.poQrIVWTgf@phil>
In-Reply-To: <208c56e1-bfe0-a982-927d-bdddc3116631@rock-chips.com>
References: <20190815081252.27405-1-kever.yang@rock-chips.com> <2932927.UJgUFA1Pmh@phil> <208c56e1-bfe0-a982-927d-bdddc3116631@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kever,

Am Montag, 19. August 2019, 02:29:31 CEST schrieb Kever Yang:
> Hi Heiko,
> 
> On 2019/8/16 下午8:24, Heiko Stuebner wrote:
> > Hi Kever, TL,
> >
> > [added TL Lim for clarification]
> >
> > Am Donnerstag, 15. August 2019, 10:12:52 CEST schrieb Kever Yang:
> >> According to rock64 schemetic V2 and V3, the VCC_HOST_5V output is
> >> controlled by USB_20_HOST_DRV, which is the same as VCC_HOST1_5V.
> > The v1 schematics I have do reference the GPIO0_A0 as controlling this
> > supply, so the big question would be how to handle the different versions.
> >
> > Because adding this would probably break v1 boards in this function.
> >
> > @TL: where v1 boards also sold or were they only used during development?
> 
> 
> I have check this with TL when I make this patch, the V1 hardware was 
> never sold and only V2/V3
> 
> are available on the market.

Thanks for clearing this up. I've applied this patch for 5.4 now.

Thanks
Heiko



