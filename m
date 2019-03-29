Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A2DC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F6C420663
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:05:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730810AbfDASFs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 14:05:48 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:32950 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730451AbfDARNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:13:04 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 9CA8B14B8AF67;
        Mon,  1 Apr 2019 10:13:03 -0700 (PDT)
Date:   Fri, 29 Mar 2019 13:33:06 -0700 (PDT)
Message-Id: <20190329.133306.2165254559631165505.davem@davemloft.net>
To:     khorenko@virtuozzo.com
Cc:     jarod@redhat.com, j.vosburgh@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, vfalico@gmail.com, andy@greyhouse.net
Subject: Re: [PATCH] bonding: show full hw address in sysfs for slave
 entries
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190328102921.11680-1-khorenko@virtuozzo.com>
References: <20190328102921.11680-1-khorenko@virtuozzo.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 01 Apr 2019 10:13:03 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konstantin Khorenko <khorenko@virtuozzo.com>
Date: Thu, 28 Mar 2019 13:29:21 +0300

> Bond expects ethernet hwaddr for its slave, but it can be longer than 6
> bytes - infiniband interface for example.
> 
>  # cat /sys/devices/<skipped>/net/ib0/address
>  80:00:02:08:fe:80:00:00:00:00:00:00:7c:fe:90:03:00:be:5d:e1
> 
>  # cat /sys/devices/<skipped>/net/ib0/bonding_slave/perm_hwaddr
>  80:00:02:08:fe:80
> 
> So print full hwaddr in sysfs "bonding_slave/perm_hwaddr" as well.
> 
> Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>

Applied, thanks.
