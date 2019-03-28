Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAEA7C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 05:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB15B2075E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 05:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbfC1FsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 01:48:13 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:34754 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbfC1FsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 01:48:13 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 5B3191086215C;
        Wed, 27 Mar 2019 22:48:12 -0700 (PDT)
Date:   Wed, 27 Mar 2019 22:48:11 -0700 (PDT)
Message-Id: <20190327.224811.2020685573680145957.davem@davemloft.net>
To:     wangxi11@huawei.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        salil.mehta@huawei.com, yisen.zhuang@huawei.com,
        linuxarm@huawei.com
Subject: Re: [PATCH net] net: hns3: fix compile error
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1553583229-121323-1-git-send-email-wangxi11@huawei.com>
References: <1553583229-121323-1-git-send-email-wangxi11@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 27 Mar 2019 22:48:12 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xi Wang <wangxi11@huawei.com>
Date: Tue, 26 Mar 2019 14:53:49 +0800

> Currently, the rules for configuring search paths in Kbuild have
> changed, this will lead some erros when compiling hns3 with the
> following command:
> 
> make O=DIR M=drivers/net/ethernet/hisilicon/hns3
> 
> drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c:11:10:
> fatal error: hnae3.h: No such file or directory
> 
> This patch fix it by adding $(srctree)/ prefix to the serach paths.
> 
> Signed-off-by: Xi Wang <wangxi11@huawei.com>

Applied.
