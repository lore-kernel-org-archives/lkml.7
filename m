Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D202C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 18:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09AC12084D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 18:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfDKSU0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 14:20:26 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:32984 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726577AbfDKSU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 14:20:26 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id AB6E614D03A35;
        Thu, 11 Apr 2019 11:20:25 -0700 (PDT)
Date:   Thu, 11 Apr 2019 11:20:25 -0700 (PDT)
Message-Id: <20190411.112025.1323996172119715001.davem@davemloft.net>
To:     tanhuazhong@huawei.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        salil.mehta@huawei.com, yisen.zhuang@huawei.com,
        linuxarm@huawei.com, shenjian15@huawei.com
Subject: Re: [PATCH net-next 01/12] net: hns3: fix VLAN initialization to
 be compatible with port base insert VLAN
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1554985531-1827-2-git-send-email-tanhuazhong@huawei.com>
References: <1554985531-1827-1-git-send-email-tanhuazhong@huawei.com>
        <1554985531-1827-2-git-send-email-tanhuazhong@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 11 Apr 2019 11:20:26 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huazhong Tan <tanhuazhong@huawei.com>
Date: Thu, 11 Apr 2019 20:25:20 +0800

> From: Jian Shen <shenjian15@huawei.com>
> 
> This patch fixes VLAN initialization, in order to be compatible
> with VLAN inserted base on port.

This doesn't mean anything to me.

Why was normal VLAN initialization different, and how is the behavior
of VLAN's configured when inserted based upon port different and why
is it better?

You have to improve your commit log messages so that someone not
intimately familiar with your driver and code can understand what you
are doing and why.
