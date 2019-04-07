Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7980EC282DD
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 01:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 531102171F
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 01:12:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbfDGBMe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 21:12:34 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:39554 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbfDGBMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 21:12:34 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 4912214BBE65F;
        Sat,  6 Apr 2019 18:12:33 -0700 (PDT)
Date:   Sat, 06 Apr 2019 18:12:32 -0700 (PDT)
Message-Id: <20190406.181232.473436529978209156.davem@davemloft.net>
To:     linmiaohe@huawei.com
Cc:     dsa@cumulusnetworks.com, shrijeet@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingfangsen@huawei.com
Subject: Re: [PATCH net] net: vrf: Fix ping failed when vrf mtu is set to 0
From:   David Miller <davem@davemloft.net>
In-Reply-To: <0da12059-229f-e167-ad41-14b56993a029@huawei.com>
References: <0da12059-229f-e167-ad41-14b56993a029@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 06 Apr 2019 18:12:33 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: linmiaohe <linmiaohe@huawei.com>
Date: Thu, 4 Apr 2019 20:01:13 +0800

> From: Miaohe Lin <linmiaohe@huawei.com>
> 
> When the mtu of a vrf device is set to 0, it would cause ping
> failed.So I think we should limit dev->min_mtu to ETH_MIN_MTU
> to solve this problem. And if dev->max_mtu still be 0 can be
> confusing, so I limit dev->max_mtu to ETH_MAX_MTU.
> 
> Here is the reproduce step:

Just in case it isn't clear, David Ahern gave you feedback and
asked you to adjust things so that the problem is solved for ipv6
as well.  He also gave you an appropriate Fixes: tag to add to
your commit message.
