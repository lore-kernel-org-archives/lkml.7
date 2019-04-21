Return-Path: <SRS0=ebdT=SX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F74C10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 17:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F190E20821
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 17:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbfDURiB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 13:38:01 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:37322 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbfDURiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 13:38:00 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 01422146EDF65;
        Sun, 21 Apr 2019 10:37:59 -0700 (PDT)
Date:   Sun, 21 Apr 2019 10:37:59 -0700 (PDT)
Message-Id: <20190421.103759.1397350043814049622.davem@davemloft.net>
To:     huangfq.daxian@gmail.com
Cc:     jes@trained-monkey.org, linux-hippi@sunsite.dk,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/06] net: hippi:Fix misuse of %x in rrunner.c
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190421114826.20512-1-huangfq.daxian@gmail.com>
References: <20190421114826.20512-1-huangfq.daxian@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 21 Apr 2019 10:38:00 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fuqian Huang <huangfq.daxian@gmail.com>
Date: Sun, 21 Apr 2019 19:48:26 +0800

> The pointer should be printed with %p or %px rather than
> cast to unsigned long type and printed with %08lx.
> Change %08lx to %p to print the pointer.
> 
> Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>

Applied to net-next.
