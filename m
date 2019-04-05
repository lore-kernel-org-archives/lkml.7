Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CCFAC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 08:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54592217D7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 08:33:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730283AbfDEIdq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 04:33:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:56856 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729785AbfDEIdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 04:33:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 352DBAF47;
        Fri,  5 Apr 2019 08:33:44 +0000 (UTC)
Date:   Fri, 5 Apr 2019 10:33:43 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
cc:     yamada.masahiro@socionext.com, michal.lkml@markovi.net,
        pmladek@suse.com, jikos@kernel.org, joe.lawrence@redhat.com,
        ggherdovich@suse.cz, linux-kbuild@vger.kernel.org,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kbuild: use -flive-patching when CONFIG_LIVEPATCH is
 enabled
In-Reply-To: <20190404201855.xtvtgxaaomcmowrt@treble>
Message-ID: <alpine.LSU.2.21.1904051028480.13155@pobox.suse.cz>
References: <20190404184411.1392-1-mbenes@suse.cz> <20190404201855.xtvtgxaaomcmowrt@treble>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> While we're on the subject, I'm glad to see ongoing activity on
> klp-convert (though I haven't had a chance to follow the discussions).
> What's the status of the rest of the needed bits?
> 
> - kgraft-analysis-tool - will this also be submitted for inclusion in
>   the kernel tree?

Yes, it is the next step.
 
> - Documentation about how to create a patch

I know we talked about it, but I don't remember what we came up with. We 
should probably tie to Nicolai's work. It will change the process a lot.

> - The other bits I think Nicolai has been working on to eliminate all
>   the manual steps

Miroslav
