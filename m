Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3458C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 05:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CC5A20883
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 05:49:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbfDHFtv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 01:49:51 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:57716 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbfDHFtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 01:49:51 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id BC8A3133E9747;
        Sun,  7 Apr 2019 22:49:50 -0700 (PDT)
Date:   Sun, 07 Apr 2019 22:49:47 -0700 (PDT)
Message-Id: <20190407.224947.1057169172447711389.davem@davemloft.net>
To:     dsa@cumulusnetworks.com
Cc:     linmiaohe@huawei.com, shrijeet@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingfangsen@huawei.com
Subject: Re: [PATCH net v3] net: vrf: Fix ping failed when vrf mtu is set
 to 0
From:   David Miller <davem@davemloft.net>
In-Reply-To: <22ff0d05-c1af-ad08-4cae-39dec91eff47@cumulusnetworks.com>
References: <b32ed160-6c7f-fb8e-aa14-11d935a1cb15@huawei.com>
        <22ff0d05-c1af-ad08-4cae-39dec91eff47@cumulusnetworks.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 07 Apr 2019 22:49:51 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Ahern <dsa@cumulusnetworks.com>
Date: Sun, 7 Apr 2019 20:51:05 -0700

> On 4/7/19 7:04 PM, linmiaohe wrote:
>> From: Miaohe Lin <linmiaohe@huawei.com>
>> 
>> When the mtu of a vrf device is set to 0, it would cause ping
>> failed. So I think we should limit vrf mtu in a reasonable range
>> to solve this problem. I set dev->min_mtu to IPV6_MIN_MTU, so it
>> will works for both ipv4 and ipv6. And if dev->max_mtu still be 0
>> can be confusing, so I set dev->max_mtu to ETH_MAX_MTU.
>> 
>> Here is the reproduce step:
 ...
>> Fixes: ad49bc6361ca2 ("net: vrf: remove MTU limits for vrf device")
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
> 
> Reviewed-by: David Ahern <dsahern@gmail.com>

Applied and queued up for -stable, thanks.
