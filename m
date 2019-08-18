Return-Path: <SRS0=w4Fx=WO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA21C3A589
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 21:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B58421855
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 21:12:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbfHRVMA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 17:12:00 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:49234 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbfHRVL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 17:11:59 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 4311B145EE9CF;
        Sun, 18 Aug 2019 14:11:59 -0700 (PDT)
Date:   Sun, 18 Aug 2019 14:11:58 -0700 (PDT)
Message-Id: <20190818.141158.218871786116375619.davem@davemloft.net>
To:     wenwen@cs.uga.edu
Cc:     inaky.perez-gonzalez@intel.com, linux-wimax@intel.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] wimax/i2400m: fix a memory leak bug
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1565900991-3573-1-git-send-email-wenwen@cs.uga.edu>
References: <1565900991-3573-1-git-send-email-wenwen@cs.uga.edu>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 18 Aug 2019 14:11:59 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wenwen Wang <wenwen@cs.uga.edu>
Date: Thu, 15 Aug 2019 15:29:51 -0500

> In i2400m_barker_db_init(), 'options_orig' is allocated through kstrdup()
> to hold the original command line options. Then, the options are parsed.
> However, if an error occurs during the parsing process, 'options_orig' is
> not deallocated, leading to a memory leak bug. To fix this issue, free
> 'options_orig' before returning the error.
> 
> Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>

Applied, but... looking at the rest of this file I hope nobody is actually
running this code.
