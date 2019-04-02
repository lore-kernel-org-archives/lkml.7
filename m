Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F9BC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 01:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A308D2084C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 01:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728738AbfDBBQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 21:16:43 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:41262 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbfDBBQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 21:16:43 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 37E81133E9760;
        Mon,  1 Apr 2019 18:16:42 -0700 (PDT)
Date:   Mon, 01 Apr 2019 18:16:41 -0700 (PDT)
Message-Id: <20190401.181641.1589135999760609672.davem@davemloft.net>
To:     yuehaibing@huawei.com
Cc:     gerrit@erg.abdn.ac.uk, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, dccp@vger.kernel.org, mojha@codeaurora.org
Subject: Re: [PATCH] dccp: Fix memleak in __feat_register_sp
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190401013554.17488-1-yuehaibing@huawei.com>
References: <20190401013554.17488-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 01 Apr 2019 18:16:42 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yue Haibing <yuehaibing@huawei.com>
Date: Mon, 1 Apr 2019 09:35:54 +0800

> From: YueHaibing <yuehaibing@huawei.com>
> 
> If dccp_feat_push_change fails, we forget free the mem
> which is alloced by kmemdup in dccp_feat_clone_sp_val.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: e8ef967a54f4 ("dccp: Registration routines for changing feature values")
> Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied.
