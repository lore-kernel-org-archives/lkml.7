Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 627FEC282CE
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 11:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3247C206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 11:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbfDLLfV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 07:35:21 -0400
Received: from gloria.sntech.de ([185.11.138.130]:38992 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726711AbfDLLfV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 07:35:21 -0400
Received: from ip5f5a6320.dynamic.kabel-deutschland.de ([95.90.99.32] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hEuSj-0005BW-LA; Fri, 12 Apr 2019 13:35:17 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Elaine Zhang <zhangqing@rock-chips.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        xxx@rock-chips.com, xf@rock-chips.com, huangtao@rock-chips.com,
        Finley Xiao <finley.xiao@rock-chips.com>
Subject: Re: [PATCH v1 3/6] clk: rockchip: add a COMPOSITE_DIV_OFFSET clock-type
Date:   Fri, 12 Apr 2019 13:35:17 +0200
Message-ID: <1678572.C0kpQ7EGxA@diego>
In-Reply-To: <1554284549-24916-4-git-send-email-zhangqing@rock-chips.com>
References: <1554284549-24916-1-git-send-email-zhangqing@rock-chips.com> <1554284549-24916-4-git-send-email-zhangqing@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 3. April 2019, 11:42:26 CEST schrieb Elaine Zhang:
> From: Finley Xiao <finley.xiao@rock-chips.com>
> 
> The div offset of some clocks are different from their mux offset
> and the COMPOSITE clock-type require that div and mux offset are
> the same, so add a new COMPOSITE_DIV_OFFSET clock-type to handle that.
> 
> Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>

applied for 5.2

Thanks
Heiko


