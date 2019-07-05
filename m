Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF217C46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 18:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B66521670
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 18:58:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbfGES66 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 14:58:58 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:40718 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfGES65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 14:58:57 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7B95B150084FF;
        Fri,  5 Jul 2019 11:58:56 -0700 (PDT)
Date:   Fri, 05 Jul 2019 11:58:53 -0700 (PDT)
Message-Id: <20190705.115853.1015836042100076787.davem@davemloft.net>
To:     xiaojiangfeng@huawei.com
Cc:     yisen.zhuang@huawei.com, salil.mehta@huawei.com,
        dingtianhong@huawei.com, robh+dt@kernel.org, mark.rutland@arm.com,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, leeyou.li@huawei.com,
        xiekunxun@huawei.com, jianping.liu@huawei.com,
        nixiaoming@huawei.com
Subject: Re: [PATCH 01/10] net: hisilicon: Add support for HI13X1 to
 hip04_eth
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1562307028-103555-1-git-send-email-xiaojiangfeng@huawei.com>
References: <1562307028-103555-1-git-send-email-xiaojiangfeng@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 05 Jul 2019 11:58:57 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


You must always provide a proper "[PATCH 00/NN]" header posting for
a patch series which describes at a high level what the patch series
is doing, how it is doing it, and why it is doing it this way.

I am tossing this patch series from patchwork, please resubmit this
entire series properly.

Thank you.
