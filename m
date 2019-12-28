Return-Path: <SRS0=tgXE=2S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 424AEC2D0C3
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 00:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AB3320828
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 00:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbfL1AbP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 19:31:15 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:53716 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbfL1AbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 19:31:15 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1c3::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 23818154D1147;
        Fri, 27 Dec 2019 16:31:14 -0800 (PST)
Date:   Fri, 27 Dec 2019 16:31:13 -0800 (PST)
Message-Id: <20191227.163113.718146091776171084.davem@davemloft.net>
To:     vulab@iscas.ac.cn
Cc:     paulus@samba.org, linux-ppp@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ppp: Remove redundant BUG_ON() check in ppp_pernet
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1577180224-16405-1-git-send-email-vulab@iscas.ac.cn>
References: <1577180224-16405-1-git-send-email-vulab@iscas.ac.cn>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 27 Dec 2019 16:31:14 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xu Wang <vulab@iscas.ac.cn>
Date: Tue, 24 Dec 2019 09:37:04 +0000

> Passing NULL to ppp_pernet causes a crash via BUG_ON.
> Dereferencing net in net_generici() also has the same effect.
> This patch removes the redundant BUG_ON check on the same parameter.
> 
> Signed-off-by: Xu Wang <vulab@iscas.ac.cn>

Applied, thanks.
