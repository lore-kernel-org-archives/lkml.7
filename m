Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 931CBC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 22:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6990420700
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 22:02:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbfDAWCR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 18:02:17 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:38856 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbfDAWCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 18:02:16 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 29C23108DA59C;
        Mon,  1 Apr 2019 15:02:16 -0700 (PDT)
Date:   Mon, 01 Apr 2019 15:02:15 -0700 (PDT)
Message-Id: <20190401.150215.729449280275163138.davem@davemloft.net>
To:     gustavo@embeddedor.com
Cc:     vishal@chelsio.com, nhorman@tuxdriver.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2 net-next] cxgb3/l2t: Fix undefined behaviour and
 use struct_size() helper
From:   David Miller <davem@davemloft.net>
In-Reply-To: <cover.1553872521.git.gustavo@embeddedor.com>
References: <cover.1553872521.git.gustavo@embeddedor.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 01 Apr 2019 15:02:16 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Fri, 29 Mar 2019 10:26:16 -0500

> Hi all,
> 
> This patchset aims to fix an undefined behaviour when using a zero-sized
> array and, add the use of the struct_size() helper in kvzalloc().
> 
> You might consider the first patch in this series for stable.
> 
> More details in the commit logs.

Series applied, honestly I don't think this is -stable material.

And if it was you should have targetted 'net' instead of 'net-next'.
