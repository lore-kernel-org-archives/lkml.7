Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6235EC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 17:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ED22204EC
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 17:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387416AbfHARPy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 13:15:54 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:57400 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727498AbfHARPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 13:15:54 -0400
Received: from localhost (c-24-22-75-21.hsd1.or.comcast.net [24.22.75.21])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C54B1153F5146;
        Thu,  1 Aug 2019 10:15:53 -0700 (PDT)
Date:   Thu, 01 Aug 2019 13:15:52 -0400 (EDT)
Message-Id: <20190801.131552.999340749788862767.davem@davemloft.net>
To:     yuehaibing@huawei.com
Cc:     f.fainelli@gmail.com, andrew@lunn.ch, vivien.didelot@gmail.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: b53: use
 devm_platform_ioremap_resource() to simplify code
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190801122732.37216-1-yuehaibing@huawei.com>
References: <20190801122732.37216-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 01 Aug 2019 10:15:54 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>
Date: Thu, 1 Aug 2019 20:27:32 +0800

> Use devm_platform_ioremap_resource() to simplify the code a bit.
> This is detected by coccinelle.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied.
