Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6659C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 23:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85810206E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 23:06:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731594AbfFGXGe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 19:06:34 -0400
Received: from tartarus.angband.pl ([54.37.238.230]:46514 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731444AbfFGXGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 19:06:30 -0400
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.92)
        (envelope-from <kilobyte@angband.pl>)
        id 1hZNw0-0005aI-Qr; Sat, 08 Jun 2019 01:06:08 +0200
Date:   Sat, 8 Jun 2019 01:06:08 +0200
From:   Adam Borowski <kilobyte@angband.pl>
To:     Nick Terrell <terrelln@fb.com>
Cc:     =?iso-8859-1?Q?Ren=E9?= Rebe <rene@exactcode.com>,
        Andi Kleen <ak@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Kernel Team <Kernel-team@fb.com>, Chris Mason <clm@fb.com>,
        Julian Andres Klode <julian.klode@canonical.com>
Subject: Re: [RESEND PATCH v2 0/2] Add support for ZSTD-compressed kernel
Message-ID: <20190607230608.GA21020@angband.pl>
References: <5B282FAD-EDCF-44C8-A131-A3C6FF3EA84F@fb.com>
 <3F598446-EA1D-47CE-B7A1-4D3002DA3972@exactcode.com>
 <8DE2BD14-0C9C-43AF-B9B7-F760F8434B6B@exactcode.com>
 <20180817165403.GC12066@tassilo.jf.intel.com>
 <20180817175746.d2brxipp7xa4y2uw@angband.pl>
 <20180817192244.GF12066@tassilo.jf.intel.com>
 <20180817200747.bzmsl5nfwewyksvg@angband.pl>
 <8117EBED-C57E-40AA-8E29-F4DFAB97E059@fb.com>
 <0ABE55AB-D29B-4E12-8E12-A9AFD6E39382@exactcode.com>
 <9214536E-2A20-409A-81C7-822AF9269D95@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9214536E-2A20-409A-81C7-822AF9269D95@fb.com>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 07, 2019 at 07:20:46PM +0000, Nick Terrell wrote:
> We'd love to get this mainlined as well!
> 
> We're using these patches internally as well. We're seeing an improvement on an
> Intel Atom N3710, where boot time is reduced by one second over using an xz
> compressed kernel. It looks like Ubuntu just switched to a lz4 compressed kernel,
> but zstd is likely a better trade off, because it compresses much better and still has
> excellent decompression speed.
> 
> Since its been nearly a year since I sent these out, I will take some time to rebase
> and retest the patches in case anything changed, and then then resend the patches
> in the next weeks.

Hi!
After the ping, I intended to resend the patch-set (with removals included)
after I return from miniDebconf Hamburg, but you 1. are the author of the
non-trivial part, 2. you have a better test machinery, and 3. I have a
deeply seated preference for effort to be done by people who are not me.

A rebased and working version is at https://github.com/kilobyte/linux/tree/nobz2-v3
but there are no real improvements beyond rebases, a typo fix, and Paul Burton's
ACK for mips.

There's an unaddressed comment by Ingo Molnar
https://lore.kernel.org/lkml/20181112042200.GA96061@gmail.com/
for your part of the code.

So what do you suggest?


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀ Latin:   meow 4 characters, 4 columns,  4 bytes
⣾⠁⢠⠒⠀⣿⡁ Greek:   μεου 4 characters, 4 columns,  8 bytes
⢿⡄⠘⠷⠚⠋  Runes:   ᛗᛖᛟᚹ 4 characters, 4 columns, 12 bytes
⠈⠳⣄⠀⠀⠀⠀ Chinese: 喵   1 character,  2 columns,  3 bytes <-- best!
