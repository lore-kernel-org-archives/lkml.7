Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD08AC19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 22:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABD03206A2
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 22:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389379AbfHAWPQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 18:15:16 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:33778 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727987AbfHAWPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 18:15:15 -0400
Received: from localhost (unknown [172.58.27.22])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 6D5B915434E2B;
        Thu,  1 Aug 2019 15:15:14 -0700 (PDT)
Date:   Thu, 01 Aug 2019 18:15:08 -0400 (EDT)
Message-Id: <20190801.181508.657295078853071495.davem@davemloft.net>
To:     takondra@cisco.com
Cc:     jon.maloy@ericsson.com, ying.xue@windriver.com,
        netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, xe-linux-external@cisco.com,
        stable@vger.kernel.org
Subject: Re: [PATCH] tipc: compat: allow tipc commands without arguments
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190729221507.48893-1-takondra@cisco.com>
References: <20190729221507.48893-1-takondra@cisco.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 01 Aug 2019 15:15:15 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Taras Kondratiuk <takondra@cisco.com>
Date: Mon, 29 Jul 2019 22:15:07 +0000

> Commit 2753ca5d9009 ("tipc: fix uninit-value in tipc_nl_compat_doit")
> broke older tipc tools that use compat interface (e.g. tipc-config from
> tipcutils package):
 ...
> This patch relaxes the original fix and rejects messages without
> arguments only if such arguments are expected by a command (reg_type is
> non zero).
> 
> Fixes: 2753ca5d9009 ("tipc: fix uninit-value in tipc_nl_compat_doit")
> Signed-off-by: Taras Kondratiuk <takondra@cisco.com>
> ---
> The patch is based on v5.3-rc2.

Applied and queued up for -stable.
