Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B8CC7618B
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 17:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B0CB2075C
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 17:53:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbfG1RxB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 13:53:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55772 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbfG1RxA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 13:53:00 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 987753082133;
        Sun, 28 Jul 2019 17:53:00 +0000 (UTC)
Received: from treble (ovpn-120-102.rdu2.redhat.com [10.10.120.102])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 058345DA97;
        Sun, 28 Jul 2019 17:52:59 +0000 (UTC)
Date:   Sun, 28 Jul 2019 12:52:58 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Matt Helsley <mhelsley@vmware.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v3 00/13] Cleanup recordmcount and begin objtool
 conversion
Message-ID: <20190728175258.nsaudvo26xbjmi2y@treble>
References: <cover.1563992889.git.mhelsley@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1563992889.git.mhelsley@vmware.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Sun, 28 Jul 2019 17:53:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 02:04:54PM -0700, Matt Helsley wrote:
> This series cleans up recordmcount and then makes it into
> an objtool subcommand.
> 
> The series starts with 8 cleanup patches which make recordmcount
> easier to review and integrate with objtool. The final 5 patches
> show the beginning steps of converting recordmcount to use objtool's
> ELF code rather than its own open-coded methods of accessing ELF
> files.
> 
> ---
> 
> v3:
> 	Rebased on mainline. s/elf_open/elf_read/ in recordmcount.c

So this will be the first time objtool will be used on non-x86 arches.
Have you tested the other HAVE_C_RECORDMCOUNT arches, both native and
cross compilation?

Other than my few minor comments, it looks good.  The patches are nicely
split up.  I'll try to be more prompt next time ;-)

-- 
Josh
