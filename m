Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F726C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 22:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E021F20706
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 22:42:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbfLEWm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 17:42:57 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:48716 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbfLEWm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 17:42:57 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1c3::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 83C99150AF487;
        Thu,  5 Dec 2019 14:42:56 -0800 (PST)
Date:   Thu, 05 Dec 2019 14:42:55 -0800 (PST)
Message-Id: <20191205.144255.1847671743657818576.davem@davemloft.net>
To:     tanhuazhong@huawei.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        salil.mehta@huawei.com, yisen.zhuang@huawei.com,
        linuxarm@huawei.com, jakub.kicinski@netronome.com
Subject: Re: [PATCH V2 net 0/3] net: hns3: fixes for -net
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1575511949-1613-1-git-send-email-tanhuazhong@huawei.com>
References: <1575511949-1613-1-git-send-email-tanhuazhong@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 05 Dec 2019 14:42:56 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huazhong Tan <tanhuazhong@huawei.com>
Date: Thu, 5 Dec 2019 10:12:26 +0800

> This patchset includes misc fixes for the HNS3 ethernet driver.
> 
> [patch 1/3] fixes a TX queue not restarted problem.
> 
> [patch 2/3] fixes a use-after-free issue.
> 
> [patch 3/3] fixes a VF ID issue for setting VF VLAN.
> 
> change log:
> V1->V2: keeps 'ring' as parameter in hns3_nic_maybe_stop_tx()
> 	in [patch 1/3], suggestted by David.
> 	rewrites [patch 2/3]'s commit log to make it be easier
> 	to understand, suggestted by David.

Series applied.
