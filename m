Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4FB2C282E1
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 01:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 939C821479
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 01:43:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbfDTBnh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 21:43:37 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:38816 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbfDTBng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 21:43:36 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id F3A3214DB1C6D;
        Fri, 19 Apr 2019 18:43:35 -0700 (PDT)
Date:   Fri, 19 Apr 2019 18:43:33 -0700 (PDT)
Message-Id: <20190419.184333.1374616354781525029.davem@davemloft.net>
To:     tanhuazhong@huawei.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        salil.mehta@huawei.com, yisen.zhuang@huawei.com,
        linuxarm@huawei.com, nhorman@redhat.com
Subject: Re: [PATCH net-next 00/12] net: hns3: add some DFX info for HNS3
 driver
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1555643147-52407-1-git-send-email-tanhuazhong@huawei.com>
References: <1555643147-52407-1-git-send-email-tanhuazhong@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 19 Apr 2019 18:43:36 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huazhong Tan <tanhuazhong@huawei.com>
Date: Fri, 19 Apr 2019 11:05:35 +0800

> This patch-set adds some DFX information to HNS3 driver, for easily
> debug some problems, and fixes some related bugs.
> 
> [patch 1/12 - 4/12] adds debug info about reset & interrupt events
> 
> [patch 5/12 - 7/12] adds debug info about TX time out & fixes
> related bugs
> 
> [patch 8/12] adds support for setting netif message level
> 
> [patch 9/12 - 10/12] adds debugfs command to dump NCL & MAC info
> 
> [patch 11/12] adds VF's queue statistics info updating
> 
> [patch 12/12] adds a check for debugfs help function to decide which
> commands are supportable

Series applied, thanks.
