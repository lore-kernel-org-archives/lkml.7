Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3FA2C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 11:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 766D0206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 11:49:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729551AbfDDLtS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 07:49:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:59688 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726269AbfDDLtR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 07:49:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 36516AFB0;
        Thu,  4 Apr 2019 11:49:16 +0000 (UTC)
Date:   Thu, 4 Apr 2019 13:49:13 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Joe Lawrence <joe.lawrence@redhat.com>
cc:     Joao Moreira <jmoreira@suse.de>, live-patching@vger.kernel.org,
        pmladek@suse.cz, jikos@suse.cz, nstange@suse.de,
        jpoimboe@redhat.com, khlebnikov@yandex-team.ru, jeyu@kernel.org,
        matz@suse.de, linux-kernel@vger.kernel.org,
        yamada.masahiro@socionext.com, linux-kbuild@vger.kernel.org,
        michal.lkml@markovi.net
Subject: Re: [PATCH v2 0/8] klp-convert
In-Reply-To: <0580fe97-7882-68c1-54f2-5778f47c5564@redhat.com>
Message-ID: <alpine.LSU.2.21.1904041346350.32428@pobox.suse.cz>
References: <20190301141313.15057-1-jmoreira@suse.de> <20190318191843.GA22702@redhat.com> <3423e586-5ae7-1dd2-8e5f-3930f168143b@suse.de> <0580fe97-7882-68c1-54f2-5778f47c5564@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 
> BTW, something I *just* noticed when putting together that toy out-of-tree
> module to test out multi-object livepatch modules is that we aren't
> considering out-of-tree symbols in Symbols.list.
> 
> Perhaps we can save that for v4 or beyond, but maybe we want to re-arrange the
> klp-convert arguments to "klp-convert <input.ko> <out.ko> <Symbols.list>
> [Symbols.list ...]" where we treat everything after <out.ko> as a symbol list
> file?  (This would assume we would generate a separate out-of-tree module
> Symbols.list file.)    /thinking-out-loud

I understand it could help the testing quite a bit right now, but do we 
care about out-of-tree modules in general?

Miroslav
