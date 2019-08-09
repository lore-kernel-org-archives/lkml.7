Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D43AC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 20:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9DC0214C6
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 20:41:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbfHIUli (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 16:41:38 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:37864 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfHIUli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 16:41:38 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 791D4145DD3AA;
        Fri,  9 Aug 2019 13:41:37 -0700 (PDT)
Date:   Fri, 09 Aug 2019 13:41:36 -0700 (PDT)
Message-Id: <20190809.134136.289159189804759707.davem@davemloft.net>
To:     yuehaibing@huawei.com
Cc:     jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
        vinicius.gomes@intel.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH v2 net-next] taprio: remove unused variable
 'entry_list_policy'
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190809014923.69328-1-yuehaibing@huawei.com>
References: <20190808142623.69188-1-yuehaibing@huawei.com>
        <20190809014923.69328-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 09 Aug 2019 13:41:37 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>
Date: Fri, 9 Aug 2019 09:49:23 +0800

> net/sched/sch_taprio.c:680:32: warning:
>  entry_list_policy defined but not used [-Wunused-const-variable=]
> 
> One of the points of commit a3d43c0d56f1 ("taprio: Add support adding
> an admin schedule") is that it removes support (it now returns "not
> supported") for schedules using the TCA_TAPRIO_ATTR_SCHED_SINGLE_ENTRY
> attribute (which were never used), the parsing of those types of schedules
> was the only user of this policy. So removing this policy should be fine.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Suggested-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
> v2: respin commit log using Vinicius's explanation.

Applied.
