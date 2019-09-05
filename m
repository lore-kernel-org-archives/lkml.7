Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34204C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 11:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 146EC20820
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 11:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388347AbfIELWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 07:22:51 -0400
Received: from gloria.sntech.de ([185.11.138.130]:39612 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732810AbfIELWu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 07:22:50 -0400
Received: from wf0413.dip.tu-dresden.de ([141.76.181.157] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1i5pqe-0003VI-2X; Thu, 05 Sep 2019 13:22:44 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Finley Xiao <finley.xiao@rock-chips.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        zhangqing@rock-chips.com, huangtao@rock-chips.com,
        tony.xie@rock-chips.com, andy.yan@rock-chips.com
Subject: Re: [PATCH v1 0/3] clk: rockchip: support clock controller for rk3308 SoC
Date:   Thu, 05 Sep 2019 13:22:43 +0200
Message-ID: <8098861.lOb4sKEy6F@phil>
In-Reply-To: <20190903115947.26618-1-finley.xiao@rock-chips.com>
References: <20190903115947.26618-1-finley.xiao@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Finley,

Am Dienstag, 3. September 2019, 13:59:44 CEST schrieb Finley Xiao:
> Finley Xiao (3):
>   dt-bindings: Add bindings for rk3308 clock controller
>   clk: rockchip: Add dt-binding header for rk3308
>   clk: rockchip: Add clock controller for the RK3308

applied for (hopefully still) 5.4.

I did change the binding patch to name the i2s mclk inputs explicitly
as you can see in [0] as placeholders in dt-bindings do not necessarily
work that great.


Heiko

[0] https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git/commit/?h=v5.4-clk/next&id=2d1fb8e983dc0669f276b176142798a228dc0f38


