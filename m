Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E5CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 09:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B02E20828
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 09:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbfCSJDc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 05:03:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52656 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725934AbfCSJDc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 05:03:32 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3FE0630FE5BA;
        Tue, 19 Mar 2019 09:03:32 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-47.rdu2.redhat.com [10.10.120.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B9871614C1;
        Tue, 19 Mar 2019 09:03:30 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAK7LNAS4zVusQRQLFNmmza9U_zbNBrjyx4qyDcH8g1oL0AzHTQ@mail.gmail.com>
References: <CAK7LNAS4zVusQRQLFNmmza9U_zbNBrjyx4qyDcH8g1oL0AzHTQ@mail.gmail.com> <23500.1552920217@warthog.procyon.org.uk>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     dhowells@redhat.com, Liz Zhang <lizzha@microsoft.com>,
        Lili Deng <v-lide@microsoft.com>,
        Manoj Srivastava <srivasta@debian.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Commit seems to prevent use of GNUmakefile wrappers
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4206.1552986209.1@warthog.procyon.org.uk>
Date:   Tue, 19 Mar 2019 09:03:29 +0000
Message-ID: <4207.1552986209@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Tue, 19 Mar 2019 09:03:32 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masahiro Yamada <yamada.masahiro@socionext.com> wrote:

> How about this patch?
> https://patchwork.kernel.org/patch/10858809/
> 
> I hope you will be able to wrap the top Makefile again.

That works for me.

Tested-by: David Howells <dhowells@redhat.com>
