Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA357C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 17:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C38B21738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 17:40:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729552AbfDWRkw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 13:40:52 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:40008 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728526AbfDWRkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 13:40:52 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D25BD133E9740;
        Tue, 23 Apr 2019 10:40:50 -0700 (PDT)
Date:   Tue, 23 Apr 2019 10:40:50 -0700 (PDT)
Message-Id: <20190423.104050.1061777831023061186.davem@davemloft.net>
To:     tanhuazhong@huawei.com
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, shenjian15@huawei.com
Subject: Re: [PATCH V2 net-next] net: phy: marvell: add new default led
 configure for m88e151x
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1555941143-57673-1-git-send-email-tanhuazhong@huawei.com>
References: <1555941143-57673-1-git-send-email-tanhuazhong@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 23 Apr 2019 10:40:51 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huazhong Tan <tanhuazhong@huawei.com>
Date: Mon, 22 Apr 2019 21:52:23 +0800

> From: Jian Shen <shenjian15@huawei.com>
> 
> The default m88e151x LED configuration is 0x1177, used LED[0]
> for 1000M link, LED[1] for 100M link, and LED[2] for active.
> But for some boards, which use LED[0] for link, and LED[1] for
> active, prefer to be 0x1040. To be compatible with this case,
> this patch defines a new dev_flag, and set it before connect
> phy in HNS3 driver. When phy initializing, using the new
> LED configuration if this dev_flag is set.
> 
> Signed-off-by: Jian Shen <shenjian15@huawei.com>
> Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
> ---
> V1->V2: modifies the commit log

Applied, thank you.
