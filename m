Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52623C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 19:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B55C20659
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 19:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=firemail.cc header.i=@firemail.cc header.b="YgTT2nnE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbfKKTHy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 14:07:54 -0500
Received: from mx1.cock.li ([185.10.68.5]:51747 "EHLO cock.li"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728773AbfKKSg6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:36:58 -0500
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firemail.cc; s=mail;
        t=1573497414; bh=F6+fKuB9VlM/JzaEphjBNyziAWDmoBexPCn7fubbWsk=;
        h=Date:From:To:Cc:Subject:From;
        b=YgTT2nnEnb545IKXWp3i3ustVqq0i+9Ebu46B1tnuVeIktSVqSLqo7dO16Gj4gMxi
         upC+iKhcXFKAON3CtRRjCFbWGWTy53Y0/wkAmXXR9L70TRF3nkebsunPYMdTekI5ok
         FmvdE5aBVL15u7jVO7v0c8k03buDJlVLjNp29C29Df+TlKFQQx6yKMH4xMqyRFD1qq
         4BSYqom1IW74NKpftBSloJnQH7n7fuiLWeRvPyNlVlHxkwGwfpGMReB+lzhKou+yo9
         gWmjHY7BBLxy0F+P31/mAUGQsBlwNalPy61kY/MxxHagPgfS2XD81iH0VvtTGDfh/c
         P55Tx3ZpWALmQ==
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Mon, 11 Nov 2019 18:36:50 +0000
From:   nipponmail@firemail.cc
To:     rms@gnu.org
Cc:     gnu-system-discuss@gnu.org, esr@thyrsus.com,
        torvalds@linux-foundation.org, bugs@gnu.support, ams@gnu.org,
        bruce@perens.com, licensing@fsf.org
Subject: GrSecurity brags about it's GCC plugins (which violate the GPL for
 the same reason it's kernel patch does) -- Is this not a threat to the gnu gpl
 system?
Message-ID: <cb3382d8f66c4cc9ef5c532c67edaa0e@firemail.cc>
X-Sender: nipponmail@firemail.cc
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Is this not a threat to the whole GNU-GPL system?
grsecurity.org
grsecurity.net
> Unlike the manual, ad-hoc approach to finding and fixing Spectre v1 
> vulnerabilities employed elsewhere, our much higher coverage Respectre® 
> compiler plugin discovers and automatically instruments the code with 
> high-performance fixes.

Can you do something about this please? Does this not bother you?

I for one, was convinced to join the free software movement and program 
for it because of the promise of the GPL. But here, with their "access 
agreement" they blatantly violate it (version 2, section 6 for the 
kernel patch, I'm sure you know which section for GCC). They 
infact-and-indeed do add an additional restrictive term.

This is allowed to stand.

It is less likely that I myself would have contributed code if it were 
not for the promise of the GPL that others could not close derivative 
works to me. That promise is being shown to be a lie. I doubt I'm the 
only one who was attracted by the GPL, but now that it is shown to be a 
false promise: the spell likely is broken.

Can you please do something about this.
Why all the silence? Why is no one angry about this?
This is as blatant of a violation as they come: it cuts at the very root 
of the whole point of Free Software:
RMS you wanted the code to come back to you: you made it clear in your 
EMACS license/notice. GrSecurity (OpenSourceSecurity) have completely 
obliterated what you intended. And it is allowed to stand.

Why? Please will nothing be done? Will nothing be discussed?

GCC is your compiler: They're doing EXACTLY what you DID NOT WANT to 
happen regarding plugins: they have effectively created PROPRIETARY 
plugins. The lawyers told you it could not happen, so that you would 
agree to allow plugins. Now apparently it has happened.

Now you can only get GrSec, the patch, the compiler plugins, if you have 
10k+, and you are not permitted to redistribute it (or else).

Yes this is a violation of section 6 of version 2 of the GPL (I know 
some programmers argue otherwise because programmers think they know 
everything about every field)

> "UHHHHHMMMMM we put it in a SEPARATE writing, thus we can impose 
> additional restrictive terms!"

> UHHH, Punishing a recipient for breaking our additional negative 
> covenant is not violating the license :^), they didn't HAVE to violate 
> our restrictions! It was their choice!

> Ahem
> Although previous to our additional restriction, under the GPL the 
> recipient is free to distribute the source to anyone without 
> repercussion or harm.
> Once we chose to add our access agreement, the recipient after paying 
> us 10k, agrees to never freely distribute the work except to his own 
> customers on demand: under penalty of forfeiting the remainder of his 
> balance and no further updates (which he already paid for)
> This is clearly not an additional restriction not-present in the 
> licensing terms
> :^)
> We also don't tell the linux kernel team about the fixes we silently 
> fix in our GPL-Respecting additional-restrictive terms derivative work.
> We'll tell you though, unless you distribute the Work: then you're cut 
> off. Better not redistribute
> :^)

The federal copyright lawsuit would cost 600k to finance. 
OpenSourceSecurity makes 120k a year, off of government contract(s/ors).

GCC plugins have been part of GrSecurity for a very long time, I 
remember them writing about them in the early/mid 2000s

