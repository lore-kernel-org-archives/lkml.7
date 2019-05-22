Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF45C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 12:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C2362173C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 12:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729295AbfEVMfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 08:35:03 -0400
Received: from gloria.sntech.de ([185.11.138.130]:45732 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728438AbfEVMfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 08:35:02 -0400
Received: from we0524.dip.tu-dresden.de ([141.76.178.12] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hTQSR-0000lq-OK; Wed, 22 May 2019 14:34:59 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Enric Balletbo Serra <eballetbo@gmail.com>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        huangtao@rock-chips.com, Linux PM list <linux-pm@vger.kernel.org>,
        xxx@rock-chips.com, xf@rock-chips.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Doug Anderson <dianders@chromium.org>, vicencb@gmail.com
Subject: Re: [PATCH v3 1/3] thermal: rockchip: fix up the tsadc pinctrl setting error
Date:   Wed, 22 May 2019 14:34:58 +0200
Message-ID: <1805430.MCm2xJzUXA@phil>
In-Reply-To: <f0581341-126a-5733-3c4b-8e6f67bfc32e@linaro.org>
References: <1556618986-18923-1-git-send-email-zhangqing@rock-chips.com> <2174314.1vfUlvne1O@phil> <f0581341-126a-5733-3c4b-8e6f67bfc32e@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 22. Mai 2019, 14:30:16 CEST schrieb Daniel Lezcano:
> On 22/05/2019 14:27, Heiko Stuebner wrote:
> 
> [ ... ]
> 
> >> As this change is now in mainline and is causing veyron to hang I'd
> >> suggest reverting this change for now. Even fixing the root cause
> >> (maybe the one I pointed above) after this patch we will have the
> >> thermal driver to fail because "gpio" and "otpout" states are not
> >> defined nor documented (a change on this will need some reviews and
> >> acks and time I guess).
> > 
> > I definitly agree here. Handling + checking the binding change
> > as well as needed fallback code is definitly not material for -rc-kernels
> > so we should just revert for now and let Elaine fix the issues for 5.3.
> > 
> > Anyone volunteering for sending a revert-patch to Eduardo? :-)
> 
> I can't right now :/

ok, I'll do the revert patch then, so that we get this sorted.


Heiko


