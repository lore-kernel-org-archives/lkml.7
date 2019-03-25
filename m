Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E05C1C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 03:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B621520828
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 03:44:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729514AbfCYDox (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 23:44:53 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:46048 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729399AbfCYDow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 23:44:52 -0400
Received: from localhost (unknown [50.233.106.125])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 31CA3133E976B;
        Sun, 24 Mar 2019 20:44:52 -0700 (PDT)
Date:   Sun, 24 Mar 2019 23:44:48 -0400 (EDT)
Message-Id: <20190324.234448.753975696465822129.davem@davemloft.net>
To:     yuehaibing@huawei.com
Cc:     gerrit@erg.abdn.ac.uk, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, dccp@vger.kernel.org, mojha@codeaurora.org
Subject: Re: [PATCH v3] dccp: Fix memleak in __feat_register_sp
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190325024106.10808-1-yuehaibing@huawei.com>
References: <20190325024106.10808-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 24 Mar 2019 20:44:52 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I said DO NOT submit any networking patches for at least 2 days, and yet
you still posted a followup to this?

Please don't.  I'm ignoring all of your submissions for at least 2 days.
