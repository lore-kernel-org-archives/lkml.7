Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 359DFC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 18:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0B9E2083E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 18:41:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfDKSla (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 14:41:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:49014 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726603AbfDKSl3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 14:41:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2F568AE47;
        Thu, 11 Apr 2019 18:41:28 +0000 (UTC)
Date:   Thu, 11 Apr 2019 20:41:26 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Joe Lawrence <joe.lawrence@redhat.com>
cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        live-patching@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Jessica Yu <jeyu@kernel.org>, Jiri Kosina <jikos@kernel.org>,
        Joao Moreira <jmoreira@suse.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Michael Matz <matz@suse.de>, Nicolai Stange <nstange@suse.de>,
        Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v3 1/9] livepatch: Create and include UAPI headers
In-Reply-To: <141bbc68-95a7-3444-08a5-3794b6dc84ce@redhat.com>
Message-ID: <alpine.LSU.2.21.1904112039290.18787@pobox.suse.cz>
References: <20190410155058.9437-1-joe.lawrence@redhat.com> <20190410155058.9437-2-joe.lawrence@redhat.com> <CAK7LNAQ_=bp0VTOze7ckfXSwFy0m_g6OYPxS5K-ac7jjoutB+A@mail.gmail.com> <141bbc68-95a7-3444-08a5-3794b6dc84ce@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >> +
> >> +/*
> >> + * livepatch.h - Kernel Live Patching Core
> >> + *
> >> + * Copyright (C) 2016 Josh Poimboeuf <jpoimboe@redhat.com>
> >> + */
> >> +
> >> +#ifndef _UAPI_LIVEPATCH_H
> >> +#define _UAPI_LIVEPATCH_H
> >> +
> >> +#include <linux/types.h>
> > 
> > 
> > Why is this include needed?
> > 
> >> +#define KLP_RELA_PREFIX                ".klp.rela."
> >> +#define KLP_SYM_PREFIX         ".klp.sym."
> > 
> > These do not depend on <linux/types.h>
> > 
> 
> Hmmm, types.h has been included since v1, but I just verified that removing it
> results in a clean build, so you are correct that it is (now) unnecessary.

Yes, I mentioned it while reviewing v2. Unfortunately, it seems to get 
lost due to unexplained submitting hiccups. Better to walk through my 
emails again and make sure nothing more falls through the cracks...

Miroslav
