Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C2D0C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 09:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1F6A2083E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 09:02:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbfDLJCl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 05:02:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:40666 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726987AbfDLJCl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 05:02:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A553AAE67;
        Fri, 12 Apr 2019 09:02:39 +0000 (UTC)
Date:   Fri, 12 Apr 2019 11:02:37 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Joe Lawrence <joe.lawrence@redhat.com>
cc:     linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
        linux-kbuild@vger.kernel.org, Jessica Yu <jeyu@kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Joao Moreira <jmoreira@suse.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michael Matz <matz@suse.de>, Nicolai Stange <nstange@suse.de>,
        Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v3 3/9] livepatch: Add klp-convert tool
In-Reply-To: <20190410182220.GB13083@redhat.com>
Message-ID: <alpine.LSU.2.21.1904121101220.773@pobox.suse.cz>
References: <20190410155058.9437-1-joe.lawrence@redhat.com> <20190410155058.9437-4-joe.lawrence@redhat.com> <20190410182220.GB13083@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Apr 2019, Joe Lawrence wrote:

> On Wed, Apr 10, 2019 at 11:50:52AM -0400, Joe Lawrence wrote:
> >
> > [ ... snip ... ]
> >
> > diff --git a/scripts/livepatch/klp-convert.c b/scripts/livepatch/klp-convert.c
> > new file mode 100644
> > index 000000000000..62bd26941081
> > --- /dev/null
> > +++ b/scripts/livepatch/klp-convert.c
> > 
> > [ ... snip ... ]
> >
> > +	if (argc != 4) {
> > +		WARN("Usage: %s <Symbols.list> <input.ko> <out.ko>", argv[0]);
>                                                ^^^^^^^^^^
> nit: since we're using .klp.o prefix, should this be "input.klp.o"

I'd leave input.ko there. It is clear then that it is an ordinary kernel 
module and nothing special, but it is up to you.

I would change out.ko to output.ko for consistency.

Miroslav
