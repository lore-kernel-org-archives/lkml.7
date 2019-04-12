Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC681C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 931542084D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:43:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfDLKni (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 06:43:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:43452 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726384AbfDLKni (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 06:43:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3B43CAC17;
        Fri, 12 Apr 2019 10:43:34 +0000 (UTC)
Date:   Fri, 12 Apr 2019 12:43:33 +0200 (CEST)
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
Subject: Re: [PATCH v3 6/9] modpost: Add modinfo flag to livepatch modules
In-Reply-To: <20190410155058.9437-7-joe.lawrence@redhat.com>
Message-ID: <alpine.LSU.2.21.1904121236220.773@pobox.suse.cz>
References: <20190410155058.9437-1-joe.lawrence@redhat.com> <20190410155058.9437-7-joe.lawrence@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> diff --git a/samples/livepatch/Makefile b/samples/livepatch/Makefile
> index 8b9b42a258ad..5fb3280bbdc4 100644
> --- a/samples/livepatch/Makefile
> +++ b/samples/livepatch/Makefile
> @@ -1,4 +1,8 @@
>  LIVEPATCH_livepatch-sample := y
> +LIVEPATCH_livepatch-shadow-fix1 := y
> +LIVEPATCH_livepatch-shadow-fix2 := y
> +LIVEPATCH_livepatch-callbacks-demo := y

You could also remove MODULE_INFO(livepatch, "Y") from the three files.

Miroslav
