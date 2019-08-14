Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27422C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 16:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0921C2083B
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 16:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbfHNQPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 12:15:22 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43643 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbfHNQPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 12:15:20 -0400
Received: from [213.220.153.21] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1hxvvi-0007Ui-MU; Wed, 14 Aug 2019 16:15:19 +0000
Date:   Wed, 14 Aug 2019 18:15:17 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     linux-kernel@vger.kernel.org, libc-alpha@sourceware.org,
        alistair23@gmail.com, ebiederm@xmission.com, arnd@arndb.de,
        dalias@libc.org, torvalds@linux-foundation.org,
        adhemerval.zanella@linaro.org, fweimer@redhat.com,
        palmer@sifive.com, macro@wdc.com, zongbox@gmail.com,
        akpm@linux-foundation.org, viro@zeniv.linux.org.uk, hpa@zytor.com
Subject: Re: [PATCH v3 1/1] waitid: Add support for waiting for the current
 process group
Message-ID: <20190814161517.ldbn62mulk2pmqo5@wittgenstein>
References: <CAKmqyKMJPQAOKn11xepzAwXOd4e9dU0Cyz=A0T-uMEgUp5yJjA@mail.gmail.com>
 <20190814154400.6371-1-christian.brauner@ubuntu.com>
 <20190814154400.6371-2-christian.brauner@ubuntu.com>
 <20190814160917.GG11595@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190814160917.GG11595@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 06:09:17PM +0200, Oleg Nesterov wrote:
> On 08/14, Christian Brauner wrote:
> >
> > and a signal could come in between the system call that
> > retrieved the process gorup and the call to waitid that changes the
>                         ^^^^^
> > current process group.
> 
> I noticed this typo only because I spent 2 minutes or more trying to
> understand this sentence ;) But yes, a signal handler or another thread

I'll try to rewrite it. :)

> can change pgrp in between.
> 
> Reviewed-by: Oleg Nesterov <oleg@redhat.com>
> 
