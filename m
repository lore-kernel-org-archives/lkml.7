Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB48C5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 08:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F0E521D79
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 08:44:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733246AbfKGIoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 03:44:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:47674 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727120AbfKGIoI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 03:44:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8C31EB20A;
        Thu,  7 Nov 2019 08:44:07 +0000 (UTC)
Date:   Thu, 7 Nov 2019 09:44:06 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Joe Lawrence <joe.lawrence@redhat.com>
cc:     linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v2] x86/stacktrace: update kconfig help text for reliable
 unwinders
In-Reply-To: <20191107032958.14034-1-joe.lawrence@redhat.com>
Message-ID: <alpine.LSU.2.21.1911070943480.7917@pobox.suse.cz>
References: <20191107032958.14034-1-joe.lawrence@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Nov 2019, Joe Lawrence wrote:

> commit 6415b38bae26 ("x86/stacktrace: Enable HAVE_RELIABLE_STACKTRACE
> for the ORC unwinder") added the ORC unwinder as a "reliable" unwinder.
> Update the help text to reflect that change: the frame pointer unwinder
> is no longer the only one that can provide HAVE_RELIABLE_STACKTRACE.
> 
> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>

Acked-by: Miroslav Benes <mbenes@suse.cz>

M
