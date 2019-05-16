Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1799AC04AB4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 19:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE99220818
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 19:13:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbfEPTNB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 15:13:01 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:60092 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfEPTNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 15:13:00 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d8])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 16629133E977D;
        Thu, 16 May 2019 12:13:00 -0700 (PDT)
Date:   Thu, 16 May 2019 12:12:59 -0700 (PDT)
Message-Id: <20190516.121259.2282104828063365055.davem@davemloft.net>
To:     khlebnikov@yandex-team.ru
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: bpfilter: fallback to netfilter if failed to load
 bpfilter kernel module
From:   David Miller <davem@davemloft.net>
In-Reply-To: <155792045295.940.7526963251434168966.stgit@buzz>
References: <155792045295.940.7526963251434168966.stgit@buzz>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 16 May 2019 12:13:00 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Date: Wed, 15 May 2019 14:40:52 +0300

> If bpfilter is not available return ENOPROTOOPT to fallback to netfilter.
> 
> Function request_module() returns both errors and userspace exit codes.
> Just ignore them. Rechecking bpfilter_ops is enough.
> 
> Fixes: d2ba09c17a06 ("net: add skeleton of bpfilter kernel module")
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

Applied, thanks.
