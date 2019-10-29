Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C386CA9EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 04:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 105DE2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 04:24:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729203AbfJ2EYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 00:24:51 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:49132 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbfJ2EYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 00:24:50 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:1e2::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id EED7614CEC933;
        Mon, 28 Oct 2019 21:24:49 -0700 (PDT)
Date:   Mon, 28 Oct 2019 21:24:49 -0700 (PDT)
Message-Id: <20191028.212449.1389218373993746531.davem@davemloft.net>
To:     syzbot+8da67f407bcba2c72e6e@syzkaller.appspotmail.com
Cc:     andy@greyhouse.net, j.vosburgh@gmail.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, vfalico@gmail.com,
        ap420073@gmail.com
Subject: Re: INFO: trying to register non-static key in
 bond_3ad_update_ad_actor_settings
From:   David Miller <davem@davemloft.net>
In-Reply-To: <000000000000929f990596024a82@google.com>
References: <000000000000044a7f0595fbaf2c@google.com>
        <000000000000929f990596024a82@google.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 28 Oct 2019 21:24:50 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: syzbot <syzbot+8da67f407bcba2c72e6e@syzkaller.appspotmail.com>
Date: Mon, 28 Oct 2019 18:11:08 -0700

> syzbot has found a reproducer for the following crash on:
> 
> HEAD commit:    60c1769a Add linux-next specific files for 20191028
> git tree:       linux-next
> console output:
> https://syzkaller.appspot.com/x/log.txt?x=154d4374e00000
> kernel config:
> https://syzkaller.appspot.com/x/.config?x=cb86688f30db053d
> dashboard link:
> https://syzkaller.appspot.com/bug?extid=8da67f407bcba2c72e6e
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro: https://syzkaller.appspot.com/x/repro.syz?x=14d43a04e00000
> C reproducer: https://syzkaller.appspot.com/x/repro.c?x=16be3b9ce00000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the
> commit:
> Reported-by: syzbot+8da67f407bcba2c72e6e@syzkaller.appspotmail.com

This might be because of the lockdep depth changes.

Taehee, please take a look.

Thanks.
