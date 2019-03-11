Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCEC6C10F06
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 21:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D0032087C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 21:21:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbfCKVV2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 17:21:28 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:50377 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbfCKVV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 17:21:28 -0400
X-Originating-IP: 86.202.231.219
Received: from localhost (lfbn-lyo-1-149-219.w86-202.abo.wanadoo.fr [86.202.231.219])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 4A16420005;
        Mon, 11 Mar 2019 21:21:23 +0000 (UTC)
Date:   Mon, 11 Mar 2019 22:21:23 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Alessandro Zummo <a.zummo@towertech.it>
Subject: Re: [PATCH v2 0/9] Add Support for MediaTek PMIC MT6358
Message-ID: <20190311212123.GD1637@piout.net>
References: <1552275991-34648-1-git-send-email-hsin-hsiung.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1552275991-34648-1-git-send-email-hsin-hsiung.wang@mediatek.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 11/03/2019 11:46:22+0800, Hsin-Hsiung Wang wrote:
> This patchset including refactoring interrupt add support to MT6358 PMIC.
> MT6358 is the primary PMIC for MT8183 platform.
> 
> changes since v1:
> - refine for better code quality.
> - remove of_match_table in the MT6358 regulator driver.
> - some minor bug fix of mfd driver, like getting pmic id flow.
> - add support for the MediaTek MT6358 RTC.
> 
> Hsin-Hsiung Wang (7):
>   mfd: mt6397: clean up code
>   mfd: mt6397: extract irq related code from core driver
>   dt-bindings: mfd: Add compatible for the MediaTek MT6358 PMIC
>   regulator: Add document for MT6358 regulator
>   mfd: Add support for the MediaTek MT6358 PMIC
>   regulator: mt6358: Add support for MT6358 regulator
>   arm64: dts: mt6358: add PMIC MT6358 related nodes
> 
> Ran Bi (2):
>   rtc: mt6397: fix alarm register overwrite
>   rtc: Add support for the MediaTek MT6358 RTC
> 

It seems that those two patches are quite independent from the other
changes. How do you expect those to be merged?


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
