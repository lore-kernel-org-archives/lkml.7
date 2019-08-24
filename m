Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F03C3A59E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 23:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A47B2082F
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 23:24:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbfHXXYX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 19:24:23 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:48506 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727740AbfHXXYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 19:24:23 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 40D0A1525F732;
        Sat, 24 Aug 2019 16:24:22 -0700 (PDT)
Date:   Sat, 24 Aug 2019 16:24:21 -0700 (PDT)
Message-Id: <20190824.162421.1494143522595019726.davem@davemloft.net>
To:     yuehaibing@huawei.com
Cc:     yisen.zhuang@huawei.com, salil.mehta@huawei.com,
        lipeng321@huawei.com, tanhuazhong@huawei.com,
        shenjian15@huawei.com, linyunsheng@huawei.com,
        liuzhongzhu@huawei.com, huangguangbin2@huawei.com,
        liweihang@hisilicon.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: hns3: Fix -Wunused-const-variable warning
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190822144937.75884-1-yuehaibing@huawei.com>
References: <20190822144937.75884-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 24 Aug 2019 16:24:22 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>
Date: Thu, 22 Aug 2019 22:49:37 +0800

> drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h:542:30:
>  warning: meta_data_key_info defined but not used [-Wunused-const-variable=]
> drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h:553:30:
>  warning: tuple_key_info defined but not used [-Wunused-const-variable=]
> 
> The two variable is only used in hclge_main.c,
> so just move the definition over there.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied, thanks.
