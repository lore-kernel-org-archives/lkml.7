Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 080C6C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 19:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9DC9206A3
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 19:15:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfEGTPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 15:15:52 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:33040 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbfEGTPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 15:15:51 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d8])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0CB7F14B666C5;
        Tue,  7 May 2019 12:15:51 -0700 (PDT)
Date:   Tue, 07 May 2019 12:15:50 -0700 (PDT)
Message-Id: <20190507.121550.257256216928661084.davem@davemloft.net>
To:     colin.king@canonical.com
Cc:     jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
        netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] taprio: add null check on sched_nest to avoid
 potential null pointer dereference
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190505215019.4639-1-colin.king@canonical.com>
References: <20190505215019.4639-1-colin.king@canonical.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 07 May 2019 12:15:51 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin King <colin.king@canonical.com>
Date: Sun,  5 May 2019 22:50:19 +0100

> From: Colin Ian King <colin.king@canonical.com>
> 
> The call to nla_nest_start_noflag can return a null pointer and currently
> this is not being checked and this can lead to a null pointer dereference
> when the null pointer sched_nest is passed to function nla_nest_end. Fix
> this by adding in a null pointer check.
> 
> Addresses-Coverity: ("Dereference null return value")
> Fixes: a3d43c0d56f1 ("taprio: Add support adding an admin schedule")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.
