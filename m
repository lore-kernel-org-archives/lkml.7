Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6752C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 07:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86AEF2075C
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 07:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfCPHzn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 03:55:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36984 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725977AbfCPHzm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 03:55:42 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 901AA85A03;
        Sat, 16 Mar 2019 07:55:42 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-148.rdu2.redhat.com [10.10.121.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7F184614C0;
        Sat, 16 Mar 2019 07:55:41 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAHk-=wisFUf55wZ3o5pv8ZY5st9utSdWELAofsJ6AwAwYByPPg@mail.gmail.com>
References: <CAHk-=wisFUf55wZ3o5pv8ZY5st9utSdWELAofsJ6AwAwYByPPg@mail.gmail.com> <12246.1552693296@warthog.procyon.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] AFS fixes and other bits
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4840.1552722940.1@warthog.procyon.org.uk>
Date:   Sat, 16 Mar 2019 07:55:40 +0000
Message-ID: <4841.1552722940@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Sat, 16 Mar 2019 07:55:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> The thing hasn't even seen a compiler, and when you *do* show the code
> to a compiler, said compiler correctly warns about

No, it doesn't - at least not gcc-8.3.1 on Fedora 29.  What compiler are you
using?

> afs_do_silly_unlink() potentially returning an uninitialized variable.

Not only has it seen a compiler, it's also been tested numerous times, with
firefox, sqlite and some commands that tests file locking manually.

But please hold off for now.  I've just tried the system flock program - and
that causes a lock leakage message for some reason that needs investigating.

David
