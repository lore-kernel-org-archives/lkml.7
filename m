Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A24C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 09:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3282A20833
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 09:28:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfDIJ21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 05:28:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51334 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726387AbfDIJ20 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 05:28:26 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A1E9B2D7F5;
        Tue,  9 Apr 2019 09:28:26 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-98.rdu2.redhat.com [10.10.121.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 62EA760BF1;
        Tue,  9 Apr 2019 09:28:25 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAGXu5j+WYMbVaAWETjjg6BbVGNYaJt_8cKcFkiL7XUwbQEZGAA@mail.gmail.com>
References: <CAGXu5j+WYMbVaAWETjjg6BbVGNYaJt_8cKcFkiL7XUwbQEZGAA@mail.gmail.com> <20190110220245.GA20942@embeddedor>
To:     Kees Cook <keescook@google.com>
Cc:     dhowells@redhat.com,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-afs@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] afs: Mark expected switch fall-throughs
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2074.1554802104.1@warthog.procyon.org.uk>
Date:   Tue, 09 Apr 2019 10:28:24 +0100
Message-ID: <2077.1554802104@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 09 Apr 2019 09:28:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kees Cook <keescook@google.com> wrote:

> These look good to me. Gets us another step to finishing this. :)

Can we fix the compiler, please, to say that *every* case (perhaps barring the
last) is expected to fall through?

David
