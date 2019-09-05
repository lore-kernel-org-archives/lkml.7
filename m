Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 418E7C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 10:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21275206BB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 10:06:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732609AbfIEKGY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 06:06:24 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:44062 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfIEKGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 06:06:23 -0400
Received: from localhost (unknown [89.248.140.11])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 25BE61538755E;
        Thu,  5 Sep 2019 03:06:21 -0700 (PDT)
Date:   Thu, 05 Sep 2019 12:06:20 +0200 (CEST)
Message-Id: <20190905.120620.474534663543605977.davem@davemloft.net>
To:     zhongjiang@huawei.com
Cc:     anna.schumaker@netapp.com, trond.myklebust@hammerspace.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] net: Use kzfree() directly
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1567564752-6430-1-git-send-email-zhongjiang@huawei.com>
References: <1567564752-6430-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.2
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 05 Sep 2019 03:06:23 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhong jiang <zhongjiang@huawei.com>
Date: Wed, 4 Sep 2019 10:39:09 +0800

> With the help of Coccinelle. We find some place to replace.
> 
> @@
> expression M, S;
> @@
> 
> - memset(M, 0, S);
> - kfree(M);
> + kzfree(M); 

Series applied to net-next.
