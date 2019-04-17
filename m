Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14468C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 03:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E08D320835
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 03:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731102AbfDQDpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 23:45:09 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:48598 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729526AbfDQDpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 23:45:09 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7082514F78BB0;
        Tue, 16 Apr 2019 20:45:08 -0700 (PDT)
Date:   Tue, 16 Apr 2019 20:45:06 -0700 (PDT)
Message-Id: <20190416.204506.894190010392496319.davem@davemloft.net>
To:     92siuyang@gmail.com
Cc:     kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        YangX92@hotmail.com
Subject: Re: [PATCH] ipv6: Prevent overrun when parsing v6 header options
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1555040048-31294-1-git-send-email-92siuyang@gmail.com>
References: <1555040048-31294-1-git-send-email-92siuyang@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 16 Apr 2019 20:45:08 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Young Xiao <92siuyang@gmail.com>
Date: Fri, 12 Apr 2019 11:34:08 +0800

> -		exthdr = (struct ipv6_opt_hdr *)(nh + offset);
> +
>  	}

Please just completely delete this line, and do not add an empty line before
the closing braces.

Thank you very much.
