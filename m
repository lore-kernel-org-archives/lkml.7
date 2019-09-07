Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80723C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 20:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F55B2178F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 20:01:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406123AbfIGUBO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 16:01:14 -0400
Received: from smtprelay0096.hostedemail.com ([216.40.44.96]:36646 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391561AbfIGUBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 16:01:13 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 6BB4B45DA;
        Sat,  7 Sep 2019 20:01:12 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: clock12_449f447336531
X-Filterd-Recvd-Size: 1691
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Sat,  7 Sep 2019 20:01:11 +0000 (UTC)
Message-ID: <628cfe909375f444c33ef4da0b09a32dbff0303b.camel@perches.com>
Subject: Re: [PATCH] Fixed most indent issues in tty_io.c
From:   Joe Perches <joe@perches.com>
To:     Sandro Volery <sandro@volery.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
        jslaby@suse.com
Date:   Sat, 07 Sep 2019 13:01:10 -0700
In-Reply-To: <9A23770B-49B8-4DB1-8B45-22F3650E0CB8@volery.com>
References: <a99b7481f26138ea01de0d271e9aec2a525c0aed.camel@perches.com>
         <9A23770B-49B8-4DB1-8B45-22F3650E0CB8@volery.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-09-07 at 21:51 +0200, Sandro Volery wrote:
> > On 7 Sep 2019, at 21:27, Joe Perches <joe@perches.com> wrote:
[]
> > As long as git diff -w shows no difference and a compiled
> > object comparison before and after the change shows no
> > difference, I think it's fine.
> 
> My thoughts, too. I didn't feel comfortable arguing as a newbie tho
> so I'll see what I can do once I get home.

If you do that, it's important to mention both elements in
the commit message:

	1: git diff -w shows no difference
	2: pre and post compilation objects are identical

It is also good to verify that allyesconfig and defconfig
objects with the minimal CONFIG_ required for compilation
are also identical.

Whitespace only changes should only change horizontal
spacing and should not have vertical line changes.


