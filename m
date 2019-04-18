Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F208C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 12:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69095217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 12:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388978AbfDRMQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 08:16:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:51904 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388401AbfDRMQs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 08:16:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5C205B185;
        Thu, 18 Apr 2019 12:16:47 +0000 (UTC)
Date:   Thu, 18 Apr 2019 12:16:47 +0000 (UTC)
From:   Michael Matz <matz@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Borislav Petkov <bp@alien8.de>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] asm/io: Correct output operand specification of the MMIO
 write* routines
In-Reply-To: <CAHk-=wjazpzX=Y==69hfafDpcgcrwaNcZ-XdJnoVXX8+iy3zLA@mail.gmail.com>
Message-ID: <alpine.LSU.2.21.1904181203170.8064@wotan.suse.de>
References: <20190417085008.GB20492@zn.tnic> <CAHk-=wjazpzX=Y==69hfafDpcgcrwaNcZ-XdJnoVXX8+iy3zLA@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 17 Apr 2019, Linus Torvalds wrote:

> So I see no upside to changing it.

As long as the memory clobber stays (and it can't be removed in the 
general case, as you say) the change has no practical effect.

<outsider>
It does have a psychological upside, though: people won't continue to 
wonder why the asm doesn't precisely specify what it does, and instead 
only declares a memory-read while clearly being a memory write.  
Normally, with asms, leaving nothing to wonder about is a good thing.
</outsider>


Ciao,
Michael.
