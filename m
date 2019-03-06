Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ADF5C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05632205F4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:57:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729561AbfCFS5e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 13:57:34 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:39256 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbfCFS5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 13:57:33 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 9393C144FEC2F;
        Wed,  6 Mar 2019 10:57:32 -0800 (PST)
Date:   Wed, 06 Mar 2019 10:57:32 -0800 (PST)
Message-Id: <20190306.105732.1611262774925888075.davem@davemloft.net>
To:     maowenan@huawei.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        arvid.brodin@alten.se
Subject: Re: [PATCH net] net: hsr: fix memory leak in hsr_dev_finalize()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190306144501.77976-1-maowenan@huawei.com>
References: <20190306144501.77976-1-maowenan@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 06 Mar 2019 10:57:32 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mao Wenan <maowenan@huawei.com>
Date: Wed, 6 Mar 2019 22:45:01 +0800

> If hsr_add_port(hsr, hsr_dev, HSR_PT_MASTER) failed to
> add port, it directly returns res and forgets to free the node
> that allocated in hsr_create_self_node(), and forgets to delete
> the node->mac_list linked in hsr->self_node_db.
 ...
> Fixes: c5a759117210("net/hsr: Use list_head (and rcu) instead of array for slave devices.")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Mao Wenan <maowenan@huawei.com>

Applied and queued up for -stable, thanks.
