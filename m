Return-Path: <SRS0=lz0T=XK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF60AC4CEC7
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 09:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9683120692
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 09:43:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbfIOJnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Sep 2019 05:43:31 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:38076 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbfIOJnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 05:43:31 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 4F07380ECE; Sun, 15 Sep 2019 11:43:14 +0200 (CEST)
Date:   Sun, 15 Sep 2019 11:43:06 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Joe Perches <joe@perches.com>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Uwe Kleine-K??nig <uwe@kleine-koenig.org>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v2] printf: add support for printing symbolic error codes
Message-ID: <20190915094306.GA1060@bug>
References: <20190830214655.6625-1-linux@rasmusvillemoes.dk>
 <20190909203826.22263-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190909203826.22263-1-linux@rasmusvillemoes.dk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2019-09-09 22:38:25, Rasmus Villemoes wrote:
> It has been suggested several times to extend vsnprintf() to be able
> to convert the numeric value of ENOSPC to print "ENOSPC". This is yet
> another attempt. Rather than adding another %p extension, simply teach
> plain %p to convert ERR_PTRs. While the primary use case is

For the record, I hate manually decoding errors, so I like this patch.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
