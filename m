Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F7B4C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 17:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ECC020868
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 17:37:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfCHRhE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 12:37:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:45492 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726607AbfCHRhE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 12:37:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 248FFAF8C;
        Fri,  8 Mar 2019 17:37:03 +0000 (UTC)
Date:   Fri, 8 Mar 2019 18:37:05 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     x86-ml <x86@kernel.org>, linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] RAS updates for 5.1
Message-ID: <20190308173705.GC15033@zn.tnic>
References: <20190305141645.GF9073@zn.tnic>
 <CAHk-=wjESdzE5YRYny25yhMvKP24omiRAJ2PMbqOdh7HwjKJAg@mail.gmail.com>
 <20190308173529.GB15033@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190308173529.GB15033@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2019 at 06:35:29PM +0100, Borislav Petkov wrote:
> On Fri, Mar 08, 2019 at 09:14:32AM -0800, Linus Torvalds wrote:
> > Hmm. You use signed tags for the EDAC tree, but not the RAS one. Is
> > there a reason for that oddity?
> 
> Well, tip guys don't do signed tags but they name the top commit. I've
> forgotten to do that, here it is:
> 
> # HEAD: 41f035a86b5b72a4f947c38e94239d20d595352a x86/mce: Improve error message when kernel cannot recover, p2

Err, correction, it is there. I simply used git request-pull.

Sorry for the confusion, the meds are not kicking in yet ;-\

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
