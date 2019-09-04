Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3459C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 22:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA5CB208E4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 22:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730437AbfIDWZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 18:25:36 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:38684 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729919AbfIDWZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 18:25:35 -0400
Received: from localhost (unknown [62.21.130.100])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D735B15285FEA;
        Wed,  4 Sep 2019 15:25:33 -0700 (PDT)
Date:   Wed, 04 Sep 2019 15:25:32 -0700 (PDT)
Message-Id: <20190904.152532.1998977195554205249.davem@davemloft.net>
To:     dhowells@redhat.com
Cc:     netdev@vger.kernel.org, hdanton@sina.com,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] rxrpc: Fix misplaced traceline
From:   David Miller <davem@davemloft.net>
In-Reply-To: <156742044878.3320.3639294965607016931.stgit@warthog.procyon.org.uk>
References: <156742044878.3320.3639294965607016931.stgit@warthog.procyon.org.uk>
X-Mailer: Mew version 6.8 on Emacs 26.2
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 04 Sep 2019 15:25:35 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>
Date: Mon, 02 Sep 2019 11:34:08 +0100

> There's a misplaced traceline in rxrpc_input_packet() which is looking at a
> packet that just got released rather than the replacement packet.
> 
> Fix this by moving the traceline after the assignment that moves the new
> packet pointer to the actual packet pointer.
> 
> Fixes: d0d5c0cd1e71 ("rxrpc: Use skb_unshare() rather than skb_cow_data()")
> Reported-by: Hillf Danton <hdanton@sina.com>
> Signed-off-by: David Howells <dhowells@redhat.com>

Applied.
