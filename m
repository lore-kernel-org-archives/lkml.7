Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C42CC10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 20:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB4C620850
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 20:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfDNUsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 16:48:03 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:44068 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbfDNUsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 16:48:02 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A642214C711C5;
        Sun, 14 Apr 2019 13:47:59 -0700 (PDT)
Date:   Sun, 14 Apr 2019 13:47:59 -0700 (PDT)
Message-Id: <20190414.134759.1327016521296726330.davem@davemloft.net>
To:     tanhuazhong@huawei.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        salil.mehta@huawei.com, yisen.zhuang@huawei.com,
        linuxarm@huawei.com
Subject: Re: [PATCH V2 net-next 00/12] code optimizations & bugfixes for
 HNS3 driver
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1555206466-44240-1-git-send-email-tanhuazhong@huawei.com>
References: <1555206466-44240-1-git-send-email-tanhuazhong@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 14 Apr 2019 13:47:59 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huazhong Tan <tanhuazhong@huawei.com>
Date: Sun, 14 Apr 2019 09:47:34 +0800

> This patch-set includes code optimizations and bugfixes for the HNS3
> ethernet controller driver.
> 
> [patch 1/12 - 4/12] optimizes the VLAN freature and adds support for port
> based VLAN, fixes some related bugs about the current implementation.
> 
> [patch 5/12 - 12/12] includes some other code optimizations for the HNS3
> ethernet controller driver.
> 
> Change log:
> V1->V2: modifies some patches' commint log and code.

These commit log messages are a lot better, thanks!

Series applied.
