Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B654DC04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 10:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C73D2083E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 10:46:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbfFFKqI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 06:46:08 -0400
Received: from gloria.sntech.de ([185.11.138.130]:37648 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725784AbfFFKqH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 06:46:07 -0400
Received: from we0305.dip.tu-dresden.de ([141.76.177.49] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hYpuG-0003im-27; Thu, 06 Jun 2019 12:46:04 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH 2/2] ARM: dts: rockchip: Configure BT_HOST_WAKE as wake-up signal on veyron
Date:   Thu, 06 Jun 2019 12:46:03 +0200
Message-ID: <3394571.WlNFeu2Orz@phil>
In-Reply-To: <2828678.vPWIEPrON5@diego>
References: <20190605204320.22343-1-mka@chromium.org> <20190605212427.GP40515@google.com> <2828678.vPWIEPrON5@diego>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 5. Juni 2019, 23:52:00 CEST schrieb Heiko Stübner:
> Am Mittwoch, 5. Juni 2019, 23:24:27 CEST schrieb Matthias Kaehlcke:
> > On Wed, Jun 05, 2019 at 11:11:12PM +0200, Heiko Stübner wrote:
> > > Am Mittwoch, 5. Juni 2019, 22:43:20 CEST schrieb Matthias Kaehlcke:
> > > > This enables wake up on Bluetooth activity when the device is
> > > > suspended. The BT_HOST_WAKE signal is only connected on devices
> > > > with BT module that are connected through UART.
> > > > 
> > > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > > 
> > > Housekeeping question, with the two Signed-off-by lines, is Doug the
> > > original author, or was this Co-developer-by?
> > 
> > Good question, it's derived from Doug's patch for CrOS 3.14 and
> > https://crrev.com/c/1575556 also from Doug. Let's say I did the
> > porting to upstream, but I'm pretty sure Doug spent more time on it.
> > 
> > Maybe I should resend it with Doug as author and include the original
> > commit message, which has more information.
> 
> It's just that the first Signed-off should be from the original author.
> (And the sender the second)
> In the co-developed-by case (see Kernel documentation) the order
> doesn't matter.

Holding off on this patch till we could clarify the authorship.


Heiko


