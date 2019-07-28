Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77921C7618B
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 17:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B22F2075B
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 17:48:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbfG1Rst (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 13:48:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40386 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726080AbfG1Rss (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 13:48:48 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C02993091753;
        Sun, 28 Jul 2019 17:48:48 +0000 (UTC)
Received: from treble (ovpn-120-102.rdu2.redhat.com [10.10.120.102])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EE17D5D6A9;
        Sun, 28 Jul 2019 17:48:47 +0000 (UTC)
Date:   Sun, 28 Jul 2019 12:48:45 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Matt Helsley <mhelsley@vmware.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v3 09/13] objtool: Prepare to merge recordmcount
Message-ID: <20190728174807.vr7j6t7ebblub6cz@treble>
References: <cover.1563992889.git.mhelsley@vmware.com>
 <2767f55f4a5fbf30ba0635aed7a9c5ee92ac07dd.1563992889.git.mhelsley@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2767f55f4a5fbf30ba0635aed7a9c5ee92ac07dd.1563992889.git.mhelsley@vmware.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Sun, 28 Jul 2019 17:48:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 02:05:03PM -0700, Matt Helsley wrote:
> Move recordmcount into the objtool directory. We keep this step separate
> so changes which turn recordmcount into a subcommand of objtool don't
> get obscured.
> 
> Signed-off-by: Matt Helsley <mhelsley@vmware.com>
> ---
>  scripts/.gitignore                         |  1 -
>  scripts/Makefile                           |  1 -
>  scripts/Makefile.build                     | 11 ++++++-----
>  tools/objtool/.gitignore                   |  1 +
>  tools/objtool/Build                        |  2 ++
>  tools/objtool/Makefile                     | 13 ++++++++++++-
>  {scripts => tools/objtool}/recordmcount.c  |  0
>  {scripts => tools/objtool}/recordmcount.h  |  0
>  {scripts => tools/objtool}/recordmcount.pl |  0
>  9 files changed, 21 insertions(+), 8 deletions(-)
>  rename {scripts => tools/objtool}/recordmcount.c (100%)
>  rename {scripts => tools/objtool}/recordmcount.h (100%)
>  rename {scripts => tools/objtool}/recordmcount.pl (100%)

According to "git grep recordmcount" there are a few documentation files
which reference recordmcount and recordmount.pl in their old locations.

And they'll probably need updating again for the next patch as well.

-- 
Josh
