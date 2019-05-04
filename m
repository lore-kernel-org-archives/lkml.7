Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2546C04AAA
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 05:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E08B2084A
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 05:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbfEDF2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 01:28:08 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:56810 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfEDF2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 01:28:07 -0400
Received: from localhost (unknown [75.104.87.19])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 9A9A114DA0325;
        Fri,  3 May 2019 22:28:00 -0700 (PDT)
Date:   Sat, 04 May 2019 01:27:56 -0400 (EDT)
Message-Id: <20190504.012756.510495833576060196.davem@davemloft.net>
To:     mkubecek@suse.cz
Cc:     netdev@vger.kernel.org, johannes@sipsolutions.net,
        dsahern@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/3] netlink: strict attribute checking
 follow-up
From:   David Miller <davem@davemloft.net>
In-Reply-To: <cover.1556806084.git.mkubecek@suse.cz>
References: <cover.1556806084.git.mkubecek@suse.cz>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 03 May 2019 22:28:06 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Kubecek <mkubecek@suse.cz>
Date: Thu,  2 May 2019 16:15:10 +0200 (CEST)

> Three follow-up patches for recent strict netlink validation series.
> 
> Patch 1 fixes dump handling for genetlink families which validate and parse
> messages themselves (e.g. because they need different policies for diferent
> commands).
> 
> Patch 2 sets bad_attr in extack in one place where this was omitted.
> 
> Patch 3 adds new NL_VALIDATE_NESTED flags for strict validation to enable
> checking that NLA_F_NESTED value in received messages matches expectations
> and includes this flag in NL_VALIDATE_STRICT. This would change userspace
> visible behavior but the previous switching to NL_VALIDATE_STRICT for new
> code is still only in net-next at the moment.
> 
> v2: change error messages to mention NLA_F_NESTED explicitly

Series applied.
