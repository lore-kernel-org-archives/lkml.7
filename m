Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6473C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 17:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9C4920863
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 17:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729504AbfEVRg5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 13:36:57 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:59068 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729085AbfEVRg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 13:36:56 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d8])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id F2C6615002409;
        Wed, 22 May 2019 10:36:55 -0700 (PDT)
Date:   Wed, 22 May 2019 10:36:55 -0700 (PDT)
Message-Id: <20190522.103655.1021678724919980639.davem@davemloft.net>
To:     felipe@felipegasper.com
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v4] net: Add UNIX_DIAG_UID to Netlink UNIX socket
 diagnostics.
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190521004351.23706-1-felipe@felipegasper.com>
References: <20190521004351.23706-1-felipe@felipegasper.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 22 May 2019 10:36:56 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Felipe Gasper <felipe@felipegasper.com>
Date: Mon, 20 May 2019 19:43:51 -0500

> This adds the ability for Netlink to report a socket's UID along with the
> other UNIX diagnostic information that is already available. This will
> allow diagnostic tools greater insight into which users control which
> socket.
> 
> To test this, do the following as a non-root user:
> 
>     unshare -U -r bash
>     nc -l -U user.socket.$$ &
> 
> .. and verify from within that same session that Netlink UNIX socket
> diagnostics report the socket's UID as 0. Also verify that Netlink UNIX
> socket diagnostics report the socket's UID as the user's UID from an
> unprivileged process in a different session. Verify the same from
> a root process.
> 
> Signed-off-by: Felipe Gasper <felipe@felipegasper.com>

Applied to net-next, thanks.
