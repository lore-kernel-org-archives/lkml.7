Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F147C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 21:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04D7323439
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 21:15:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbfH3VPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 17:15:52 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:42046 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727991AbfH3VPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 17:15:51 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 531DA154FE294;
        Fri, 30 Aug 2019 14:15:51 -0700 (PDT)
Date:   Fri, 30 Aug 2019 14:15:50 -0700 (PDT)
Message-Id: <20190830.141550.302970621444143276.davem@davemloft.net>
To:     yuehaibing@huawei.com
Cc:     thomas.lendacky@amd.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] amd-xgbe: Fix error path in xgbe_mod_init()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190829024600.16052-1-yuehaibing@huawei.com>
References: <20190829024600.16052-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 30 Aug 2019 14:15:51 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>
Date: Thu, 29 Aug 2019 10:46:00 +0800

> In xgbe_mod_init(), we should do cleanup if some error occurs
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: efbaa828330a ("amd-xgbe: Add support to handle device renaming")
> Fixes: 47f164deab22 ("amd-xgbe: Add PCI device support")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied.
