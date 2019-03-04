Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2047DC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 21:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3F31206DD
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 21:24:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbfCDVYq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 16:24:46 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:39496 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfCDVYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 16:24:46 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 6A7251429D550;
        Mon,  4 Mar 2019 13:24:45 -0800 (PST)
Date:   Mon, 04 Mar 2019 13:24:44 -0800 (PST)
Message-Id: <20190304.132444.1938515634110339846.davem@davemloft.net>
To:     arnd@arndb.de
Cc:     jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
        vladbu@mellanox.com, marcelo.leitner@gmail.com,
        dcaratti@redhat.com, simon.horman@netronome.com, adin@mellanox.com,
        wenxu@ucloud.cn, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/sched: avoid unused-label warning
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190304204049.2150878-1-arnd@arndb.de>
References: <20190304204049.2150878-1-arnd@arndb.de>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 04 Mar 2019 13:24:45 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Mon,  4 Mar 2019 21:40:32 +0100

> The label is only used from inside the #ifdef and should be
> hidden the same way, to avoid this warning:
> 
> net/sched/act_tunnel_key.c: In function 'tunnel_key_init':
> net/sched/act_tunnel_key.c:389:1: error: label 'release_tun_meta' defined but not used [-Werror=unused-label]
>  release_tun_meta:
> 
> Fixes: 41411e2fd6b8 ("net/sched: act_tunnel_key: Add dst_cache support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied.
