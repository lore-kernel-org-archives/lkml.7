Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 515E8C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2421B21901
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:31:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387851AbfDXSb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 14:31:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:53660 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733199AbfDXSb2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 14:31:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3B629AEA1;
        Wed, 24 Apr 2019 18:31:27 +0000 (UTC)
Date:   Wed, 24 Apr 2019 20:31:26 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Petr Mladek <pmladek@suse.com>
cc:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] livepatch: Convert error about unsupported reliable
 stacktrace into a warning
In-Reply-To: <20190424085550.29612-2-pmladek@suse.com>
Message-ID: <alpine.LSU.2.21.1904242031120.30239@pobox.suse.cz>
References: <20190424085550.29612-1-pmladek@suse.com> <20190424085550.29612-2-pmladek@suse.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Apr 2019, Petr Mladek wrote:

> The commit d0807da78e11d46f ("livepatch: Remove immediate feature") caused
> that any livepatch was refused when reliable stacktraces were not supported
> on the given architecture.
> 
> The limitation is too strong. User space processes are safely migrated
> even when entering or leaving the kernel. Kthreads transition would
> need to get forced. But it is safe when:
> 
>    + The livepatch does not change the semantic of the code.
>    + Callbacks do not depend on a safely finished transition.
> 
> Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
> Signed-off-by: Petr Mladek <pmladek@suse.com>

Acked-by: Miroslav Benes <mbenes@suse.cz>

Miroslav
