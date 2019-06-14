Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F57C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 15:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6715F2173C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 15:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbfFNPt1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 11:49:27 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:45350 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfFNPt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 11:49:26 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 6BA23148BD7FF;
        Fri, 14 Jun 2019 08:49:26 -0700 (PDT)
Date:   Fri, 14 Jun 2019 08:49:25 -0700 (PDT)
Message-Id: <20190614.084925.1041124966442067512.davem@davemloft.net>
To:     mkubecek@suse.cz
Cc:     xuechaojing@huawei.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, luoshaokai@huawei.com,
        cloud.wangxiaoyun@huawei.com, chiqijun@huawei.com,
        wulike1@huawei.com
Subject: Re: [PATCH net-next v3 2/2] hinic: add support for rss parameters
 with ethtool
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190614073209.GN31797@unicorn.suse.cz>
References: <20190613015802.3916-1-xuechaojing@huawei.com>
        <20190613015802.3916-3-xuechaojing@huawei.com>
        <20190614073209.GN31797@unicorn.suse.cz>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 14 Jun 2019 08:49:26 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Kubecek <mkubecek@suse.cz>
Date: Fri, 14 Jun 2019 09:32:09 +0200

> On Thu, Jun 13, 2019 at 01:58:02AM +0000, Xue Chaojing wrote:
>> This patch adds support rss parameters with ethtool,
>> user can change hash key, hash indirection table, hash
>> function by ethtool -X, and show rss parameters by ethtool -x.
>> 
>> Signed-off-by: Xue Chaojing <xuechaojing@huawei.com>
>> ---
> 
> If you are going to submit a new version, please split the patch into
> one moving the existing ethtool code into a new file and one with the
> new features so that it's clear what is new.
> 
> I'm also not sure if an error lever message in kernel log is an
> appropriate response to user trying to perform an unsupported operation,
> in particular if it can be triggered by a regular user.

I think no log message should be reported.
