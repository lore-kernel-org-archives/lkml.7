Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45448C5DF60
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 16:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 853CA21882
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 16:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=redchan.it header.i=@redchan.it header.b="vbDKjm/L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390164AbfKEQIP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 11:08:15 -0500
Received: from mx1.cock.li ([185.10.68.5]:55127 "EHLO cock.li"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389843AbfKEQIP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 11:08:15 -0500
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=redchan.it; s=mail;
        t=1572970091; bh=TO9KvzRzQl6Ot1r8fldjk8jx5yc9bJo7kd+9gy49Ku4=;
        h=Date:From:To:Subject:From;
        b=vbDKjm/LCia44oiPUfOQtlsEfhv3BjodwxqU2xfcQtjkXKIguemn2QSBtE3DpS+LL
         tY3XJdTkEzfzeji9eDp7LXreX3tsUi+rsiGGAc6VB+CJmqOsI+80GEXHEuThQqMtKG
         Ujo0B5FZ0VcwA34VzzCASp4tl0OxdF8QLovpC1Ghq1r2VtGF+aK/r3OG/ZyGy4wTlp
         SzhGHlMddosBQAhe8vvQQ1BLASc8X7FJLSFo9zMS8c9TL2WLuyhhZ823VvyjuHC9cw
         uREy9sAFGgvW/0P1f0oUDXvTsvxEdmIWPrHczyxeQFzs7+5UnDcYkQ8fwdJaqeedWN
         OIxMBTRmMBxBA==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 05 Nov 2019 16:08:07 +0000
From:   gameonlinux@redchan.it
To:     linux-kernel@vger.kernel.org, debian-user@lists.debian.org
Subject: Proposal: More GTK1 (and 2) programs. (Reviving use of these
 libraries in free systems, for efficiency and avoidance of lock-in)
Message-ID: <6191833c208dc4c495ada501f14f525c@redchan.it>
X-Sender: gameonlinux@redchan.it
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It has been noted that GTK1 and GTK2 were the GIMP ToolKit and were 
fairly efficient, and allowed the creation of programs that could run on 
a wide variety of hardware; however GTK3 is Gnome*'s ToolKit.

GTK1 was lightweight, and fairly straight forward, and was built by the 
GIMP hackers.
GTK2 was aswell, but introduced things similar to a "windows registry" 
for gfx, however it increased the options the hackers had when creating 
their programs.
GTK3 is quite slow, removes many options, and is controlled by Gnome 
with no input by the hackers, and is not a Gnu project, essentially. No 
hacker can rely on it: only the Gnome programmers at the Gnome 
foundation can.

*(now "Gnome: they stopped being "GNOME" in 2012 since they didn't want 
to be an acronym associated with Gnu any longer (see: their mailing list 
regarding "rebranding"))

GTK3 is unsuited for the poor who do not have access to 
high-memory-bandwith modern computers (note: I just switched to one, 
after my old desktop failed: there is much difference), great amounts of 
memory, and fast tertiary storage (SSDs). It is also controlled by a 
foundation, not the hackers, who seems to act like the corporate 
entities the hackers rejected.

So my proposal is that GTK1 and GTK2 programs be written again, and the 
libraries be included in distributions of GNU/Linux again thusly: to 
avoid being taken down a river by Gnome.

Recently I wished to use a free-software program from a project I 
contributed to a decade+ ago. Seems like yesterday that I was 
contributing to it.

I got gtk1.2, and glib1.2, had to patch it to work with gcc3x ( 
glib-1.2.10-gcc34-1.patch ), and use the c89 option, also compiled 
libpng-1.4.22 (after that they removed code that was relied upon) , 
compiled it all, and was able to use my GTK1 program.

It worked fine. It was fast, and was no different than it had ever been, 
but the Gnome folks would make it seem as if Gimp's 2 tool kits are dead 
and you have to follow their development (they even use slow Javascript 
for their stuff aswell, instead of C: slowing things down even more). 
They're just trying to lock us in: they've all-ready taken control of 
they system away from the hackers and given it to their employees, who 
they direct.

Can we step back into the promised land, together?
Must we be lead by the nose by these foundation-managers and their 
workers that they own?
