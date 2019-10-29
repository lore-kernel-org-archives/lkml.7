Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D5ECA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 17:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4651820679
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 17:42:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729553AbfJ2RmQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 13:42:16 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:57464 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727239AbfJ2RmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 13:42:15 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:1e2::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 59CE514CDDCFF;
        Tue, 29 Oct 2019 10:42:15 -0700 (PDT)
Date:   Tue, 29 Oct 2019 10:42:12 -0700 (PDT)
Message-Id: <20191029.104212.1114755402526419547.davem@davemloft.net>
To:     will@kernel.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        nico@semmle.com
Subject: Re: [PATCH] fjes: Handle workqueue allocation failure
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191025110602.10615-1-will@kernel.org>
References: <20191025110602.10615-1-will@kernel.org>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 29 Oct 2019 10:42:15 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Will Deacon <will@kernel.org>
Date: Fri, 25 Oct 2019 12:06:02 +0100

> In the highly unlikely event that we fail to allocate either of the
> "/txrx" or "/control" workqueues, we should bail cleanly rather than
> blindly march on with NULL queue pointer(s) installed in the
> 'fjes_adapter' instance.
> 
> Cc: "David S. Miller" <davem@davemloft.net>
> Reported-by: Nicolas Waisman <nico@semmle.com>
> Link: https://lore.kernel.org/lkml/CADJ_3a8WFrs5NouXNqS5WYe7rebFP+_A5CheeqAyD_p7DFJJcg@mail.gmail.com/
> Signed-off-by: Will Deacon <will@kernel.org>

Applied, thanks Will.
