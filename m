Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C715FC73C46
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 13:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96EE820844
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 13:52:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbfGINwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 09:52:25 -0400
Received: from lb2-smtp-cloud7.xs4all.net ([194.109.24.28]:51261 "EHLO
        lb2-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726060AbfGINwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 09:52:25 -0400
Received: from xps13 ([83.160.161.190])
        by smtp-cloud7.xs4all.net with ESMTPSA
        id kqXbhm3nw0SBqkqXeh3BQp; Tue, 09 Jul 2019 15:52:23 +0200
Message-ID: <2a52d8bd1b44e5518abb965ef503c2f1014d9829.camel@tiscali.nl>
Subject: Re: screen freeze with 5.2-rc6 Dell XPS-13 skylake  i915
From:   Paul Bolle <pebolle@tiscali.nl>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        intel-gfx@lists.freedesktop.org
Date:   Tue, 09 Jul 2019 15:52:19 +0200
In-Reply-To: <1561834612.3071.6.camel@HansenPartnership.com>
References: <1561834612.3071.6.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.3 (3.32.3-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfLBYmG6SmpCBQxXyyp03Mr6NJuF8UR9yPwgqcZqIHX05s+2+W+qnQulaCZklgoi56/AdNQf58A0NFPcAaa8L8FBahO9a2NofpxTF+uEmhMI3Uwbs6Qgu
 QLeZX72Dad4KHd78nqKA7glOxAZNPQJ81npwNy2baFdSkdqo5wR5r6FKm7sfQQ+8I6nVzynT/TROhdnc5yY4YDSUJRLqG9jDX4koJ/99FUQXQZFDryAyzZKe
 QmOGx3avDDiw0cirOmK+A1cSfZrBf/qRE0WoOTdJOoc=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

James Bottomley schreef op za 29-06-2019 om 11:56 [-0700]:
> The symptoms are really weird: the screen image is locked in place. 
> The machine is still functional and if I log in over the network I can
> do anything I like, including killing the X server and the display will
> never alter.  It also seems that the system is accepting keyboard input
> because when it freezes I can cat information to a file (if the mouse
> was over an xterm) and verify over the network the file contents. 
> Nothing unusual appears in dmesg when the lockup happens.
> 
> The last kernel I booted successfully on the system was 5.0, so I'll
> try compiling 5.1 to narrow down the changes.

Upgrading to 5.2 (from 5.1.y) on a "Dell XPS 13 9350" (is that a skylake too?)
showed similar symptoms. There's no pattern to the freezes that I can see.
They're rather frequent too (think every few minutes). Eg, two freezes while
composing this message!

My totally silly workaround is suspending (via Fn + Insert) and resuming.

Did you manage to narrow this any further?

Thanks,


Paul Bolle

