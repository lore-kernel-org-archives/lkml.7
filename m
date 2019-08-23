Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7446C3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 21:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A351121019
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 21:46:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393017AbfHWVqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 17:46:25 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:38294 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727260AbfHWVqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 17:46:25 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 39CED1543B41C;
        Fri, 23 Aug 2019 14:46:24 -0700 (PDT)
Date:   Fri, 23 Aug 2019 14:46:23 -0700 (PDT)
Message-Id: <20190823.144623.2105404166419156597.davem@davemloft.net>
To:     tim.froidcoeur@tessares.net
Cc:     matthieu.baerts@tessares.net, aprout@ll.mit.edu, cpaasch@apple.com,
        edumazet@google.com, gregkh@linuxfoundation.org,
        jonathan.lemon@gmail.com, jtl@netflix.com,
        linux-kernel@vger.kernel.org, mkubecek@suse.cz,
        ncardwell@google.com, sashal@kernel.org, stable@vger.kernel.org,
        ycheng@google.com
Subject: Re: [PATCH] tcp: fix tcp_rtx_queue_tail in case of empty
 retransmit queue
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190823125054.30070-1-tim.froidcoeur@tessares.net>
References: <529376a4-cf63-f225-ce7c-4747e9966938@tessares.net>
        <20190823125054.30070-1-tim.froidcoeur@tessares.net>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 23 Aug 2019 14:46:24 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


All networking patches must be sent CC:'d to netdev@vger.kernel.org

Thank you.
