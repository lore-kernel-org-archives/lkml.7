Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21310C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 18:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0340921852
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 18:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbfGCStf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 14:49:35 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:32774 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbfGCStf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 14:49:35 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 8A6F61412A8A3;
        Wed,  3 Jul 2019 11:49:34 -0700 (PDT)
Date:   Wed, 03 Jul 2019 11:49:33 -0700 (PDT)
Message-Id: <20190703.114933.2138129118204643808.davem@davemloft.net>
To:     liuyonglong@huawei.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, salil.mehta@huawei.com,
        yisen.zhuang@huawei.com, shiju.jose@huawei.com
Subject: Re: [PATCH net] net: hns: add support for vlan TSO
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1562152350-14244-1-git-send-email-liuyonglong@huawei.com>
References: <1562152350-14244-1-git-send-email-liuyonglong@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 03 Jul 2019 11:49:34 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yonglong Liu <liuyonglong@huawei.com>
Date: Wed, 3 Jul 2019 19:12:30 +0800

> The hip07 chip support vlan TSO, this patch adds NETIF_F_TSO
> and NETIF_F_TSO6 flags to vlan_features to improve the
> performance after adding vlan to the net ports.
> 
> Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>

Applied, thank you.
