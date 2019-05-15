Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 461CCC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 13:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2176E2070D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 13:38:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbfEONiQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 09:38:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:39342 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726635AbfEONiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 09:38:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F0F7AAD36;
        Wed, 15 May 2019 13:38:14 +0000 (UTC)
Date:   Wed, 15 May 2019 15:38:14 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCHv2 2/4] printk: remove invalid register_console() comment
Message-ID: <20190515133814.ftn46cxpfncsm6gl@pathway.suse.cz>
References: <20190426053302.4332-1-sergey.senozhatsky@gmail.com>
 <20190426053302.4332-3-sergey.senozhatsky@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426053302.4332-3-sergey.senozhatsky@gmail.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2019-04-26 14:33:00, Sergey Senozhatsky wrote:
> We don't iterate consoles twice, since commit 8259cf434202
> ("printk: Ensure that "console enabled" messages are printed
>  on the console"), so the comment is not valid anymore, and
> can be removed, as was suggested by Petr.
> 
> The patch also invokes pr_info("%sconsole [%s%d] enabled\n")
> before we unlock_consoles(), just to make sure that we really
> print that message on every registered and enabled console.
> 
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
