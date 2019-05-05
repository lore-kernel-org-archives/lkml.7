Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E90C004C9
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 17:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 363972082F
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 17:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbfEERAs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 13:00:48 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:52486 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbfEERAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 13:00:47 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d8])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id DFF8E14D99A89;
        Sun,  5 May 2019 10:00:46 -0700 (PDT)
Date:   Sun, 05 May 2019 10:00:46 -0700 (PDT)
Message-Id: <20190505.100046.820872345993110303.davem@davemloft.net>
To:     mcroce@redhat.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
        vladbu@mellanox.com
Subject: Re: [PATCH net] cls_cgroup: avoid panic when receiving a packet
 before filter set
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190502151318.1884-1-mcroce@redhat.com>
References: <20190502151318.1884-1-mcroce@redhat.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 05 May 2019 10:00:47 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matteo Croce <mcroce@redhat.com>
Date: Thu,  2 May 2019 17:13:18 +0200

> When a cgroup classifier is added, there is a small time interval in
> which tp->root is NULL. If we receive a packet in this small time slice
> a NULL pointer dereference will happen, leading to a kernel panic:
 ...
> Suggested-by: Cong Wang <xiyou.wangcong@gmail.com>
> Fixes: ed76f5edccc9 ("net: sched: protect filter_chain list with filter_chain_lock mutex")
> Signed-off-by: Matteo Croce <mcroce@redhat.com>

Applied, thanks.
