Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA49CC2D0CD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 21:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DF4821582
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 21:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbfLQVs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 16:48:57 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:43314 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726764AbfLQVs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 16:48:57 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1c3::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 42C0114649686;
        Tue, 17 Dec 2019 13:48:56 -0800 (PST)
Date:   Tue, 17 Dec 2019 13:48:55 -0800 (PST)
Message-Id: <20191217.134855.76154724010022162.davem@davemloft.net>
To:     biao.huang@mediatek.com
Cc:     robh+dt@kernel.org, andrew@lunn.ch, mark.rutland@arm.com,
        peppe.cavallaro@st.com, alexandre.torgue@st.com,
        joabreu@synopsys.com, mcoquelin.stm32@gmail.com,
        matthias.bgg@gmail.com, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, yt.shen@mediatek.com
Subject: Re: [v2, PATCH 0/2] net-next: stmmac: dwmac-mediatek: add more
 support for RMII
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191216053958.26130-1-biao.huang@mediatek.com>
References: <20191216053958.26130-1-biao.huang@mediatek.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 17 Dec 2019 13:48:56 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Biao Huang <biao.huang@mediatek.com>
Date: Mon, 16 Dec 2019 13:39:56 +0800

> changes in v2:
>  PATCH 1/2 net-next: stmmac: mediatek: add more support for RMII
>         As Andrew's comments, add the "rmii_internal" clock to the list of clocks.
> 
>  PATCH 2/2 net-next: dt-binding: dwmac-mediatek: add more description for RMII
>         document the "rmii_internal" clock in dt-bindings
>         rewrite the sample dts in dt-bindings.
> 
> v1:
> This series is for support RMII when MT2712 SoC provides the reference clock.

Series applied, thank you.
