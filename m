Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7631EC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 04:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5024A2082E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 04:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfDLE0o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 00:26:44 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:39798 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbfDLE0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 00:26:44 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 87B7113D0F774;
        Thu, 11 Apr 2019 21:26:43 -0700 (PDT)
Date:   Thu, 11 Apr 2019 21:26:41 -0700 (PDT)
Message-Id: <20190411.212641.809336343201829564.davem@davemloft.net>
To:     tanhuazhong@huawei.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        salil.mehta@huawei.com, yisen.zhuang@huawei.com,
        linuxarm@huawei.com, shenjian15@huawei.com
Subject: Re: [PATCH net-next 01/12] net: hns3: fix VLAN initialization to
 be compatible with port base insert VLAN
From:   David Miller <davem@davemloft.net>
In-Reply-To: <0a650f2c-7988-5ff3-68ad-909005fc50c9@huawei.com>
References: <1554985531-1827-2-git-send-email-tanhuazhong@huawei.com>
        <20190411.112025.1323996172119715001.davem@davemloft.net>
        <0a650f2c-7988-5ff3-68ad-909005fc50c9@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 11 Apr 2019 21:26:43 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: tanhuazhong <tanhuazhong@huawei.com>
Date: Fri, 12 Apr 2019 10:30:38 +0800

> 
> 
> On 2019/4/12 2:20, David Miller wrote:
>> From: Huazhong Tan <tanhuazhong@huawei.com>
>> Date: Thu, 11 Apr 2019 20:25:20 +0800
>> 
>>> From: Jian Shen <shenjian15@huawei.com>
>>>
>>> This patch fixes VLAN initialization, in order to be compatible
>>> with VLAN inserted base on port.
>> This doesn't mean anything to me.
>> Why was normal VLAN initialization different, and how is the behavior
>> of VLAN's configured when inserted based upon port different and why
>> is it better?
>> You have to improve your commit log messages so that someone not
>> intimately familiar with your driver and code can understand what you
>> are doing and why.
>> 
> 
> Sorry, I will describe it in detail.
> 
> Our hardware supports insert a specified vlan header for each function
> when send packets. User can enable it with command "ip link set
> <devname> vf <vfid> vlan <vlan id>".  For this vlan header is inserted
> by hardware, not from stack, hardware also needs to strip it from
> received packet before upstreaming to stack.  In this case, driver
> needs to tell hardware which vlan to insert or strip.

Don't tell me here, rewrite all of your commit messages for this patch
series so that they explain these k inds of details.

That is what I am asking you to do.

Thank you.
