Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2217BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 10:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D74B32070D
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 10:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbfCNK1c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 06:27:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58336 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726653AbfCNK1c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 06:27:32 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 14BA466223;
        Thu, 14 Mar 2019 10:27:32 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-148.rdu2.redhat.com [10.10.121.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8815D5D9C8;
        Thu, 14 Mar 2019 10:27:30 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAMuHMdUo7QA+xtWWoyBtFHghwYYp4XUWeHYRM2Mt5QXq+ACTww@mail.gmail.com>
References: <CAMuHMdUo7QA+xtWWoyBtFHghwYYp4XUWeHYRM2Mt5QXq+ACTww@mail.gmail.com> <153754740781.17872.7869536526927736855.stgit@warthog.procyon.org.uk> <153754746514.17872.4993763624097980573.stgit@warthog.procyon.org.uk>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mszeredi@redhat.com
Subject: Re: [PATCH 07/34] vfs: Add configuration parser helpers [ver #12]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <21985.1552559249.1@warthog.procyon.org.uk>
Date:   Thu, 14 Mar 2019 10:27:29 +0000
Message-ID: <21986.1552559249@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 14 Mar 2019 10:27:32 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> When would I want to disable this?
> 
> It seems this option was introduced in "ver #10" of your patch series,
> without being mentioned in the changelog for that version.

Sorry, yes - it's a debugging tool to check that the parser tables are vaguely
sane.  I set it to default to 'Y' for the moment to catch errors in upcoming
fs conversion development.  You probably want to disable it if you're not
doing fs conversion.

David
