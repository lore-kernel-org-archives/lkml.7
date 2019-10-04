Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD54CC4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 20:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97B422133F
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 20:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730550AbfJDU7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 16:59:03 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:58924 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfJDU7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 16:59:02 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:1e2::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 3DDE614EC3094;
        Fri,  4 Oct 2019 13:59:02 -0700 (PDT)
Date:   Fri, 04 Oct 2019 13:59:01 -0700 (PDT)
Message-Id: <20191004.135901.2236530388885343464.davem@davemloft.net>
To:     dhowells@redhat.com
Cc:     netdev@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] rxrpc: Add missing "new peer" trace
From:   David Miller <davem@davemloft.net>
In-Reply-To: <157012115701.21124.13973726693523106899.stgit@warthog.procyon.org.uk>
References: <157012115701.21124.13973726693523106899.stgit@warthog.procyon.org.uk>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 04 Oct 2019 13:59:02 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>
Date: Thu, 03 Oct 2019 17:45:57 +0100

> There was supposed to be a trace indicating that a new peer had been
> created.  Add it.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>

Applied.
