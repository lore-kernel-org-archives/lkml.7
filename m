Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82092C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 21:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AE6620818
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 21:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbfEPV1p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 17:27:45 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:33508 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbfEPV1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 17:27:45 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d8])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7B8E212D6C7DF;
        Thu, 16 May 2019 14:27:44 -0700 (PDT)
Date:   Thu, 16 May 2019 14:27:44 -0700 (PDT)
Message-Id: <20190516.142744.1107545161556108780.davem@davemloft.net>
To:     george_davis@mentor.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: sysctl: cleanup net_sysctl_init error exit paths
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1558020189-16843-1-git-send-email-george_davis@mentor.com>
References: <1558020189-16843-1-git-send-email-george_davis@mentor.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 16 May 2019 14:27:44 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "George G. Davis" <george_davis@mentor.com>
Date: Thu, 16 May 2019 11:23:08 -0400

> Unwind net_sysctl_init error exit goto spaghetti code
> 
> Suggested-by: Joshua Frkuska <joshua_frkuska@mentor.com>
> Signed-off-by: George G. Davis <george_davis@mentor.com>

Cleanups are not appropriate until the net-next tree opens back up.

So please resubmit at that time.

Thank you.
