Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D792AC3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 21:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B05D623439
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 21:17:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbfH3VRa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 17:17:30 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:42088 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728122AbfH3VR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 17:17:29 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id E0D70154FE29B;
        Fri, 30 Aug 2019 14:17:28 -0700 (PDT)
Date:   Fri, 30 Aug 2019 14:17:28 -0700 (PDT)
Message-Id: <20190830.141728.336807562506579224.davem@davemloft.net>
To:     wens@kernel.org
Cc:     peppe.cavallaro@st.com, alexandre.torgue@st.com,
        joabreu@synopsys.com, heiko@sntech.de, wens@csie.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH netdev] net: stmmac: dwmac-rk: Don't fail if phy
 regulator is absent
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190829031724.20865-1-wens@kernel.org>
References: <20190829031724.20865-1-wens@kernel.org>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 30 Aug 2019 14:17:29 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@kernel.org>
Date: Thu, 29 Aug 2019 11:17:24 +0800

> From: Chen-Yu Tsai <wens@csie.org>
> 
> The devicetree binding lists the phy phy as optional. As such, the
> driver should not bail out if it can't find a regulator. Instead it
> should just skip the remaining regulator related code and continue
> on normally.
> 
> Skip the remainder of phy_power_on() if a regulator supply isn't
> available. This also gets rid of the bogus return code.
> 
> Fixes: 2e12f536635f ("net: stmmac: dwmac-rk: Use standard devicetree property for phy regulator")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Applied and queued up for -stable.

> On a separate note, maybe we should add this file to the Rockchip
> entry in MAINTAINERS?

Yes, probably.

Thanks.
