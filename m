Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE08C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 16:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A85321916
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 16:30:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbfCUQaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 12:30:04 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:49894 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbfCUQaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 12:30:04 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 792AA133E9753;
        Thu, 21 Mar 2019 09:30:03 -0700 (PDT)
Date:   Thu, 21 Mar 2019 09:30:02 -0700 (PDT)
Message-Id: <20190321.093002.1561928215186509735.davem@davemloft.net>
To:     yuehaibing@huawei.com
Cc:     keescook@chromium.org, ktkhai@virtuozzo.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] genetlink: Fix a memory leak on error path
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190321070250.20128-1-yuehaibing@huawei.com>
References: <20190321070250.20128-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 21 Mar 2019 09:30:03 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yue Haibing <yuehaibing@huawei.com>
Date: Thu, 21 Mar 2019 15:02:50 +0800

> From: YueHaibing <yuehaibing@huawei.com>
> 
> In genl_register_family(), when idr_alloc() fails,
> we forget to free the memory we possibly allocate for
> family->attrbuf.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: 2ae0f17df1cd ("genetlink: use idr to track families")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied and queued up for -stable, thanks.
