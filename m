Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD39AC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 20:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 920AF2067B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 20:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbfKLUMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 15:12:49 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:49010 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbfKLUMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 15:12:49 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1e2::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 9B4D4154D2519;
        Tue, 12 Nov 2019 12:12:48 -0800 (PST)
Date:   Tue, 12 Nov 2019 12:12:48 -0800 (PST)
Message-Id: <20191112.121248.2279073084494569648.davem@davemloft.net>
To:     yuehaibing@huawei.com
Cc:     richardcochran@gmail.com, vincent.cheng.xh@renesas.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] ptp: ptp_clockmatrix: Fix build error
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191112143514.10784-1-yuehaibing@huawei.com>
References: <20191112143514.10784-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 12 Nov 2019 12:12:48 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>
Date: Tue, 12 Nov 2019 22:35:14 +0800

> When do randbuilding, we got this warning:
> 
> WARNING: unmet direct dependencies detected for PTP_1588_CLOCK
>   Depends on [n]: NET [=y] && POSIX_TIMERS [=n]
>   Selected by [y]:
>   - PTP_1588_CLOCK_IDTCM [=y]
> 
> Make PTP_1588_CLOCK_IDTCM depends on PTP_1588_CLOCK to fix this.
> 
> Fixes: 3a6ba7dc7799 ("ptp: Add a ptp clock driver for IDT ClockMatrix.")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied.
