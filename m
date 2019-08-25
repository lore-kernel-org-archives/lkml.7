Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F39C3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 19:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37950206E0
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 19:49:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728915AbfHYTtT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 15:49:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:47202 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727077AbfHYTtS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 15:49:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9EAAFAE9A;
        Sun, 25 Aug 2019 19:49:17 +0000 (UTC)
Date:   Sun, 25 Aug 2019 21:49:12 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Pu Wen <puwen@hygon.cn>, Thomas Gleixner <tglx@linutronix.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [GIT pull] x86/urgent for 5.3-rc5
Message-ID: <20190825194912.GF20639@zn.tnic>
References: <156672618029.19810.8479315461492191933.tglx@nanos.tec.linutronix.de>
 <156672618029.19810.9732807383797358917.tglx@nanos.tec.linutronix.de>
 <CAHk-=wjWPDauemCmLTKbdMYFB0UveMszZpcrwoUkJRRWKrqaTw@mail.gmail.com>
 <20190825173000.GB20639@zn.tnic>
 <CAHk-=wiV54LwvWcLeATZ4q7rA5Dd9kE0Lchx=k023kgxFHySNQ@mail.gmail.com>
 <20190825182922.GC20639@zn.tnic>
 <CAHk-=wjhyg-MndXHZGRD+ZKMK1UrcghyLH32rqQA=YmcxV7Z0Q@mail.gmail.com>
 <20190825193218.GD20639@zn.tnic>
 <CAHk-=wiBqmHTFYJWOehB=k3mC7srsx0DWMCYZ7fMOC0T7v1KHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wiBqmHTFYJWOehB=k3mC7srsx0DWMCYZ7fMOC0T7v1KHA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 25, 2019 at 12:35:53PM -0700, Linus Torvalds wrote:
> You know what? The days of UP are long gone, and we really only want a
> one-time warning, so I think your thing is fine as-is.
> 
> It would be good to test with a known-bad setup, of course..

The trivial test by not incrementing the @changed variable looks like
this: http://ix.io/1Tsr

We're really verbose, though. Dunno if we should make this a WARN_ONCE
or we say that we really should be very loud with a non-functioning
RDRAND...

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 247165, AG München
