Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B25C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 23:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08DA220684
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 23:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfCHX0o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 18:26:44 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:41502 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbfCHX0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 18:26:44 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id BBFB81479C97C;
        Fri,  8 Mar 2019 15:26:43 -0800 (PST)
Date:   Fri, 08 Mar 2019 15:26:43 -0800 (PST)
Message-Id: <20190308.152643.1974199265649566047.davem@davemloft.net>
To:     natechancellor@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com, ndesaulniers@google.com
Subject: Re: [PATCH] net: ethernet: sun: Zero initialize class in default
 case in niu_add_ethtool_tcam_entry
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190307232933.10145-1-natechancellor@gmail.com>
References: <20190307232933.10145-1-natechancellor@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 08 Mar 2019 15:26:44 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>
Date: Thu,  7 Mar 2019 16:29:33 -0700

> When building with -Wsometimes-uninitialized, Clang warns:
> 
> drivers/net/ethernet/sun/niu.c:7466:5: warning: variable 'class' is used
> uninitialized whenever switch default is taken
> [-Wsometimes-uninitialized]
> 
> The default case can never happen because i can only be 0 to 3
> (NIU_L3_PROG_CLS is defined as 4). To make this clear to Clang,
> just zero initialize class in the default case (use the macro
> CLASS_CODE_UNRECOG to make it clear this shouldn't happen).
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/403
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Applied, thanks.
