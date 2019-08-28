Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F305C3A5A4
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 19:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43F292189D
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 19:55:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbfH1TzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 15:55:09 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:35946 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbfH1TzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 15:55:08 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 9C7F81533FE79;
        Wed, 28 Aug 2019 12:55:07 -0700 (PDT)
Date:   Wed, 28 Aug 2019 12:55:04 -0700 (PDT)
Message-Id: <20190828.125504.853814215014307743.davem@davemloft.net>
To:     wang.yi59@zte.com.cn
Cc:     kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        xue.zhihong@zte.com.cn, wang.liang82@zte.com.cn,
        cheng.lin130@zte.com.cn
Subject: Re: [PATCH v2] ipv6: Not to probe neighbourless routes
From:   David Miller <davem@davemloft.net>
In-Reply-To: <201908281650080034915@zte.com.cn>
References: <20190827.201305.1460354856100541470.davem@davemloft.net>
        <201908281650080034915@zte.com.cn>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 28 Aug 2019 12:55:07 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: <wang.yi59@zte.com.cn>
Date: Wed, 28 Aug 2019 16:50:08 +0800 (CST)

> We used an older version of the kernel, and found that configuring default
> route led to a lot of NS messages, which affected the real business.
> 
> Although commit f547fac624be adds rate-limiting, there are still some
> unreasonable things.
> 
> We have tested this change on CentOS 7.6 (3.10.0-957), whose rt6_probe()
> implementation is similar to the latest code. When remaking patch based on
> linux-5.3-rc5, a line of code was missed out with a mistack.

Therefore, you are not testing this patch on current kernels, so you are
sending a patch which is completely untested.

This is not appropriate nor accceptable.
