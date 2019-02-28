Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5495CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 09:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F03820652
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 09:23:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731533AbfB1JXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 04:23:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:21419 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbfB1JXv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 04:23:51 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CF991317F3BF;
        Thu, 28 Feb 2019 09:23:50 +0000 (UTC)
Received: from localhost (ovpn-12-40.pek2.redhat.com [10.72.12.40])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F328265F5D;
        Thu, 28 Feb 2019 09:23:49 +0000 (UTC)
Date:   Thu, 28 Feb 2019 17:23:46 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, keescook@chromium.org, thgarnie@google.com
Subject: Re: [PATCH v2 0/2] x86/mm/KASLR: Change the granularity of
 randomization to PUD size in 5-level
Message-ID: <20190228092346.GQ14858@MiWiFi-R3L-srv>
References: <20190228003522.9957-1-bhe@redhat.com>
 <20190228091001.5wvkwe7cqkf2euzc@kshutemo-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228091001.5wvkwe7cqkf2euzc@kshutemo-mobl1>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Thu, 28 Feb 2019 09:23:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/28/19 at 12:10pm, Kirill A. Shutemov wrote:
> On Thu, Feb 28, 2019 at 08:35:20AM +0800, Baoquan He wrote:
> >  arch/x86/mm/kaslr.c | 92 ++++++++++++++++++++-------------------------
> >  1 file changed, 40 insertions(+), 52 deletions(-)
> 
> What tree is it against?
> 
> I cannot apply on current Linus' tree or tip/master.

Oops, I put them on my on my previous kaslr fixing patches:
http://lkml.kernel.org/r/20190216140008.28671-1-bhe@redhat.com
[PATCH v3 0/6] Several patches to fix code bugs, improve documents and clean up

There's a clean up there to open code get_padding(), that cause
conflict in patch 0002. Let me rearrange and repost.

Thanks
Baoquan

