Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02EBAC3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 23:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D12132085B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 23:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbgABXi1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 18:38:27 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:52140 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgABXi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 18:38:27 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1c3::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 452DE156EEC0C;
        Thu,  2 Jan 2020 15:38:26 -0800 (PST)
Date:   Thu, 02 Jan 2020 15:38:25 -0800 (PST)
Message-Id: <20200102.153825.425008126689372806.davem@davemloft.net>
To:     brouer@redhat.com
Cc:     netdev@vger.kernel.org, lirongqing@baidu.com,
        linyunsheng@huawei.com, ilias.apalodimas@linaro.org,
        saeedm@mellanox.com, mhocko@kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [net-next v6 PATCH 0/2] page_pool: NUMA node handling fixes
From:   David Miller <davem@davemloft.net>
In-Reply-To: <157746672570.257308.7385062978550192444.stgit@firesoul>
References: <157746672570.257308.7385062978550192444.stgit@firesoul>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 02 Jan 2020 15:38:26 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jesper Dangaard Brouer <brouer@redhat.com>
Date: Fri, 27 Dec 2019 18:13:13 +0100

> The recently added NUMA changes (merged for v5.5) to page_pool, it both
> contains a bug in handling NUMA_NO_NODE condition, and added code to
> the fast-path.
> 
> This patchset fixes the bug and moves code out of fast-path. The first
> patch contains a fix that should be considered for 5.5. The second
> patch reduce code size and overhead in case CONFIG_NUMA is disabled.
> 
> Currently the NUMA_NO_NODE setting bug only affects driver 'ti_cpsw'
> (drivers/net/ethernet/ti/), but after this patchset, we plan to move
> other drivers (netsec and mvneta) to use NUMA_NO_NODE setting.

Series applied to net-next with the "fallthrough" misspelling fixed in
patch #1.

Thank you.
