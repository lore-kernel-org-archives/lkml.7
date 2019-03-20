Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12418C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D991C2184D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbfCTRsI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 13:48:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39454 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726438AbfCTRsH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 13:48:07 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 763D27FD59;
        Wed, 20 Mar 2019 17:48:07 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.34])
        by smtp.corp.redhat.com (Postfix) with SMTP id 4BFDA5D71E;
        Wed, 20 Mar 2019 17:48:06 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 20 Mar 2019 18:48:06 +0100 (CET)
Date:   Wed, 20 Mar 2019 18:48:04 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Steffen Froemer <sfroemer@redhat.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: printk_ratelimited() && proc/sys/kernel/printk_ratelimit*
Message-ID: <20190320174804.GF21673@redhat.com>
References: <20190320170342.GA11770@redhat.com>
 <CAHk-=wg9-SK6QDhWvgy+7FkV4Q-d0Ae5p3RcAHoKQtRySn9z8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg9-SK6QDhWvgy+7FkV4Q-d0Ae5p3RcAHoKQtRySn9z8g@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Wed, 20 Mar 2019 17:48:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/20, Linus Torvalds wrote:
>
> On Wed, Mar 20, 2019 at 10:03 AM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > At the same time, printk_ratelimited() uses a static ratelimit_state, so user-
> > space can't override the default DEFAULT_RATELIMIT_.* numbers.
> >
> > Isn't it strange? Shouldn't printk_ratelimited() use printk_ratelimit_state ?
>
> No it shouldn't.
>
> Each printk_ratelimited() is independent, and that's very much on purpose.

Damn, I am really stupid.

Oleg.

