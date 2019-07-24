Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC286C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 17:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1C3921852
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 17:29:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728491AbfGXR3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 13:29:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57826 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726158AbfGXR3e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 13:29:34 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 39ED43082128;
        Wed, 24 Jul 2019 17:29:34 +0000 (UTC)
Received: from treble (ovpn-122-90.rdu2.redhat.com [10.10.122.90])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 423965D71A;
        Wed, 24 Jul 2019 17:29:33 +0000 (UTC)
Date:   Wed, 24 Jul 2019 12:29:29 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Matt Helsley <mhelsley@vmware.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 00/13] Cleanup recordmcount and begin objtool
 conversion
Message-ID: <20190724172929.fnh2kxsgxtcneipe@treble>
References: <cover.1560285597.git.mhelsley@vmware.com>
 <20190710130924.16aee549@gandalf.local.home>
 <20190710171900.gzzitftdinkdx6ra@treble>
 <20190724124652.362a90d0@gandalf.local.home>
 <5714C12C-D3D0-47F1-A301-908398B46F72@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5714C12C-D3D0-47F1-A301-908398B46F72@vmware.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Wed, 24 Jul 2019 17:29:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 05:26:10PM +0000, Matt Helsley wrote:
> 
> 
> > On Jul 24, 2019, at 9:46 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
> > 
> > On Wed, 10 Jul 2019 12:19:00 -0500
> > Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > 
> >> On Wed, Jul 10, 2019 at 01:09:24PM -0400, Steven Rostedt wrote:
> >>> 
> >>> Josh,
> >>> 
> >>> Can you have a look at these? I can apply them if you think they are OK.  
> >> 
> >> Sorry for the delay.  I didn't forget about it, it's just been a hectic
> >> month.  I plan to give it a proper review soon (in the next week or so).
> >> 
> > 
> > Friendly reminder ;-)
> > 
> > -- Steve
> 
> Just thought I’d add:
> 
> I rebased yesterday and noticed a few minor changes are needed to resolve conflicts with mainline. I will send a v3 out today with these changes:
> 
> 	renaming elf_open to elf_read
> 
> 	some kernel build changes (in Makefile.build)
> 
> Also, I’ve finished removing all of the old recordmcount ELF wrapper code. I can send a follow-on RFC series by Friday.

Matt, thanks for your patience.  As I told Steven, I'm unfortunately
very behind on reviews.  Yours is (almost) at the top of the list.

-- 
Josh
