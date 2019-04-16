Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB1A4C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA17D217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:35:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbfDPNfu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 09:35:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33664 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727037AbfDPNfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 09:35:50 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D9744C081F5B;
        Tue, 16 Apr 2019 13:35:44 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-98.rdu2.redhat.com [10.10.121.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A9EBA1001DE0;
        Tue, 16 Apr 2019 13:35:43 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAGXu5jJRNUZcCyRS_xXG-XYWVLkCtV1h62-H3OsQWKB4jQ02kQ@mail.gmail.com>
References: <CAGXu5jJRNUZcCyRS_xXG-XYWVLkCtV1h62-H3OsQWKB4jQ02kQ@mail.gmail.com> <20190110220245.GA20942@embeddedor> <CAGXu5j+WYMbVaAWETjjg6BbVGNYaJt_8cKcFkiL7XUwbQEZGAA@mail.gmail.com> <2077.1554802104@warthog.procyon.org.uk>
To:     Kees Cook <keescook@google.com>
Cc:     dhowells@redhat.com,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-afs@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] afs: Mark expected switch fall-throughs
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <21213.1555421742.1@warthog.procyon.org.uk>
Date:   Tue, 16 Apr 2019 14:35:42 +0100
Message-ID: <21214.1555421742@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Tue, 16 Apr 2019 13:35:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kees Cook <keescook@google.com> wrote:

> > Can we fix the compiler, please, to say that *every* case (perhaps barring
> > the last) is expected to fall through?

I should say "... so that we can say that *every* case ...".

David
