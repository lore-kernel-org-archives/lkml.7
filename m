Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7557CC282DA
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 12:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39DA22184E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 12:53:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbfDKMxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 08:53:06 -0400
Received: from gloria.sntech.de ([185.11.138.130]:58202 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbfDKMxG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 08:53:06 -0400
Received: from wf0380.dip.tu-dresden.de ([141.76.181.124] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hEZCC-0007yb-Ce; Thu, 11 Apr 2019 14:52:48 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Tony Xie <tony.xie@rock-chips.com>, broonie@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, chenjh@rock-chips.com,
        xsf@rock-chips.com, zhangqing@rock-chips.com,
        huangtao@rock-chips.com
Subject: Re: [PATCH v7 2/6] mfd: rk808: Add RK817 and RK809 support
Date:   Thu, 11 Apr 2019 14:52:47 +0200
Message-ID: <518340124.P20tlEWT52@phil>
In-Reply-To: <20190402063305.GZ4187@dell>
References: <20190102102002.29245-1-tony.xie@rock-chips.com> <20190102102002.29245-3-tony.xie@rock-chips.com> <20190402063305.GZ4187@dell>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

Am Dienstag, 2. April 2019, 08:33:05 CEST schrieb Lee Jones:
> On Wed, 02 Jan 2019, Tony Xie wrote:
> 
> > The RK809 and RK817 are a Power Management IC (PMIC) for multimedia
> > and handheld devices. They contains the following components:
> >   - Regulators
> >   - RTC
> >   - Clocking
> > 
> > Both RK809 and RK817 chips are using a similar register map,
> > so we can reuse the RTC and Clocking functionality.
> > Most of regulators have a some implementation also.
> > 
> > Signed-off-by: Tony Xie <tony.xie@rock-chips.com>
> > Acked-by: Stephen Boyd <sboyd@kernel.org>
> > ---
> >  drivers/mfd/Kconfig       |   6 +-
> >  drivers/mfd/rk808.c       | 192 +++++++++++++++++++++++++++++++++++++-
> >  include/linux/mfd/rk808.h | 172 ++++++++++++++++++++++++++++++++++
> >  3 files changed, 364 insertions(+), 6 deletions(-)
> 
> For my own reference:
>   Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

do you have some sort of merge plan for this or are you waiting for
specific Acks? I guess if we're waiting for an Ack from Mark Brown,
we'll need a resend of the patch.

All other patches have Acks from their subsystem maintainers (rtc, clk)
so you could pick up all patches except patch3 and I could just resend
this one, which in turn could also go through the regulator tree.

Otherwise we'll probably need a resend of the series, as Mark most of
the time doesn't keep old patch series around.


Heiko


