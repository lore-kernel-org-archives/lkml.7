Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99DA4C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 23:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74CBB206C2
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 23:33:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbfHOXdv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 19:33:51 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:52222 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbfHOXdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 19:33:50 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 116D01265123C;
        Thu, 15 Aug 2019 16:33:50 -0700 (PDT)
Date:   Thu, 15 Aug 2019 16:33:49 -0700 (PDT)
Message-Id: <20190815.163349.1048232454570643495.davem@davemloft.net>
To:     dhowells@redhat.com
Cc:     netdev@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/2] rxrpc: Fix local endpoint handling
From:   David Miller <davem@davemloft.net>
In-Reply-To: <156577967167.1405.3581547705200268244.stgit@warthog.procyon.org.uk>
References: <156577967167.1405.3581547705200268244.stgit@warthog.procyon.org.uk>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 15 Aug 2019 16:33:50 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>
Date: Wed, 14 Aug 2019 11:47:51 +0100

> Here's a pair of patches that fix two issues in the handling of local
> endpoints (rxrpc_local structs):
> 
>  (1) Use list_replace_init() rather than list_replace() if we're going to
>      unconditionally delete the replaced item later, lest the list get
>      corrupted.
> 
>  (2) Don't access the rxrpc_local object after passing our ref to the
>      workqueue, not even to illuminate tracepoints, as the work function
>      may cause the object to be freed.  We have to cache the information
>      beforehand.

Pulled, thanks David.
