Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74586C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 12:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5063D20840
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 12:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbfHMMGJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 08:06:09 -0400
Received: from muru.com ([72.249.23.125]:57280 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727342AbfHMMGI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 08:06:08 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 953858179;
        Tue, 13 Aug 2019 12:06:36 +0000 (UTC)
Date:   Tue, 13 Aug 2019 05:06:05 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     ssantosh@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH -next] soc: ti: pm33xx: Make two symbols static
Message-ID: <20190813120605.GX52127@atomide.com>
References: <20190413141243.38620-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190413141243.38620-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Yue Haibing <yuehaibing@huawei.com> [190413 07:13]:
> From: YueHaibing <yuehaibing@huawei.com>
> 
> Fix sparse warnings:
> 
> drivers/soc/ti/pm33xx.c:144:27: warning: symbol 'rtc_wake_src' was not declared. Should it be static?
> drivers/soc/ti/pm33xx.c:160:5: warning: symbol 'am33xx_rtc_only_idle' was not declared. Should it be static?

Applying into fixes thanks.

Tony
