Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0446FC4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 16:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4E1520640
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 16:14:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387713AbfIIQO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 12:14:57 -0400
Received: from smtprelay0206.hostedemail.com ([216.40.44.206]:44396 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726783AbfIIQO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 12:14:57 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id F134B182CF674;
        Mon,  9 Sep 2019 16:14:55 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: start11_652ceba729d49
X-Filterd-Recvd-Size: 2096
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Mon,  9 Sep 2019 16:14:55 +0000 (UTC)
Message-ID: <fbd0c88d97bf10ba9245755210a5b21362e57520.camel@perches.com>
Subject: Re: [PATCH] Fixed parentheses malpractice in apex_driver.c
From:   Joe Perches <joe@perches.com>
To:     Sandro Volery <sandro@volery.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        linux-kernel@vger.kernel.org
Date:   Mon, 09 Sep 2019 09:14:53 -0700
In-Reply-To: <6EC85D2C-F3B5-4637-8FCF-486F037E0DC2@volery.com>
References: <8d6586f8772dd68695b9348ef977f2d9afa7645d.camel@perches.com>
         <6EC85D2C-F3B5-4637-8FCF-486F037E0DC2@volery.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-09-07 at 18:12 +0200, Sandro Volery wrote:
> Alright, I'll do that when I get home tonight!

I'm going to assume this is not an actual problem.

> Thanks,
> Sandro V
> 
> > On 7 Sep 2019, at 18:08, Joe Perches <joe@perches.com> wrote:
> > 
> > ﻿On Sat, 2019-09-07 at 17:56 +0200, Sandro Volery wrote:
> > > > > On 7 Sep 2019, at 17:44, Joe Perches <joe@perches.com> wrote:
> > > > 
> > > > ﻿On Sat, 2019-09-07 at 17:34 +0200, Sandro Volery wrote:
> > > > > On patchwork I entered 'volery' as my username because I didn't know better, and now checkpatch always complains when I add 'signed-off-by' with my actual full name.
> > > > 
> > > > How does checkpatch complain?
> > > > There is no connection between patchwork
> > > > and checkpatch.
> > > 
> > > Checkpatch tells me that I haven't used 'volery' as
> > > my signed off name.
> > 
> > Please send the both the patch and the actual checkpatch output
> > you get when running 'perl ./scripts/checkpatch.pl <patch>'
> > 
> > If this patch is a commit in your own local git tree:
> > 
> > $ git format-patch -1 --stdout <commit_id> > tmp
> > $ perl ./scripts/checkpatch.pl --strict tmp
> > 
> > and send tmp and the checkpatch output.
> > 
> > 

