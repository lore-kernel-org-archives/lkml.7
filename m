Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0455DC282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 11:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDC522184B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 11:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfDKLmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 07:42:55 -0400
Received: from gloria.sntech.de ([185.11.138.130]:57334 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726264AbfDKLmy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 07:42:54 -0400
Received: from wf0380.dip.tu-dresden.de ([141.76.181.124] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hEY6Q-0007YA-Et; Thu, 11 Apr 2019 13:42:46 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     linux-rockchip@lists.infradead.org,
        Caesar Wang <caesar.wang@rock-chips.com>, mka@chromium.org,
        ryandcase@chromium.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: rockchip: Set the proper PWM for rk3288
Date:   Thu, 11 Apr 2019 13:42:45 +0200
Message-ID: <2577047.PMfDAGTXrs@phil>
In-Reply-To: <20190409204905.152432-1-dianders@chromium.org>
References: <20190409204905.152432-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 9. April 2019, 22:49:05 CEST schrieb Douglas Anderson:
> The rk3288 SoC has two PWM implementations available, the "old"
> implementation and the "new" one.  You can switch between the two of
> them by flipping a bit in the grf.
> 
> The "old" implementation is the default at chip power up but isn't the
> one that's officially supposed to be used.  ...and, in fact, the
> driver that gets selected in Linux using the rk3288 device tree only
> supports the "new" implementation.
> 
> Long ago I tried to get a switch to the right IP block landed in the
> PWM driver (search for "rk3288: Switch to use the proper PWM IP") but
> that got rejected.  In the mean time the grf has grown a full-fledged
> driver that already sets other random bits like this.  That means we
> can now get the fix landed.
> 
> For those wondering how things could have possibly worked for the last
> 4.5 years, folks have mostly been relying on the bootloader to set
> this bit.  ...but occasionally folks have pointed back to my old patch
> series [1] in downstream kernels.
> 
> [1] https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1391597.html
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

applied for 5.2

Thanks
Heiko


