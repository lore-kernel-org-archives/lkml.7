Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1563EECE58D
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 18:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF3F22053B
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 18:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438879AbfJQS0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 14:26:12 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:40012 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732289AbfJQS0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 14:26:12 -0400
Received: from localhost (unknown [IPv6:2603:3023:50c:85e1:5314:1b70:2a53:887e])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 28295140128C4;
        Thu, 17 Oct 2019 11:26:11 -0700 (PDT)
Date:   Thu, 17 Oct 2019 14:26:10 -0400 (EDT)
Message-Id: <20191017.142610.700073266665616558.davem@davemloft.net>
To:     linyunsheng@huawei.com
Cc:     tglx@linutronix.de, peterz@infradead.org, fw@strlen.de,
        bigeasy@linutronix.de, pabeni@redhat.com, jonathan.lemon@gmail.com,
        anshuman.khandual@arm.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH net-next] pktgen: remove unnecessary assignment in
 pktgen_xmit()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1571308453-213479-1-git-send-email-linyunsheng@huawei.com>
References: <1571308453-213479-1-git-send-email-linyunsheng@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.2
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 17 Oct 2019 11:26:11 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>
Date: Thu, 17 Oct 2019 18:34:13 +0800

> variable ret is not used after jumping to "unlock" label, so
> the assignment is redundant.
> 
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>

Applied.
