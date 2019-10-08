Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2577FC4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 18:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04BE721721
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 18:50:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728920AbfJHSuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 14:50:05 -0400
Received: from smtprelay0150.hostedemail.com ([216.40.44.150]:38874 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726098AbfJHSuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 14:50:05 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id C952318035432;
        Tue,  8 Oct 2019 18:50:03 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: rail72_57b7586455f60
X-Filterd-Recvd-Size: 2295
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Tue,  8 Oct 2019 18:50:02 +0000 (UTC)
Message-ID: <334aea9d82188d0cec300d7c02e59afff29b1d0a.camel@perches.com>
Subject: Re: [PATCH] checkpatch: use patch subject when reading from stdin
From:   Joe Perches <joe@perches.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Andy Whitcroft <apw@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 08 Oct 2019 11:50:01 -0700
In-Reply-To: <CAMuHMdUpqimKRn_VO+K5TB7+jhvxay1p61kPqgyLVOLwAsfJFw@mail.gmail.com>
References: <20191008094006.8251-1-geert+renesas@glider.be>
         <19c54ca5b3750bebc057e20542ad6c0c2acef960.camel@perches.com>
         <CAMuHMdUYf=0RVeJhSqs9WUY4H+o9Jk8U+J6tUsnMjz7bgKpAxw@mail.gmail.com>
         <f59c1ef48b64bcf97047df5952f8994f75c0cecf.camel@perches.com>
         <CAMuHMdWvLbcGDG=VZDSAd=E-Bb_FEt9zvffpJu5nubMCKMZUZA@mail.gmail.com>
         <18e4ecf36ada8a9a90cfb1e96bdb04bdbca4a537.camel@perches.com>
         <CAMuHMdUpqimKRn_VO+K5TB7+jhvxay1p61kPqgyLVOLwAsfJFw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-10-08 at 20:39 +0200, Geert Uytterhoeven wrote:
[]
> > I still think the patch I suggested is better as it
> > functions for other use cases too.
> 
> I agree it would be better if checkpatch would handle the splitting in
> patches itself, as that would be easier for the user.
> 
> However:
>   1) That requires getting the state reset right,

Not really difficult and maybe not necessary.
The process subroutine contains very limited state.
The biggest issue is resetting the "$in_header_lines"
states and such when a new multi-patch bundle
start is detected.  I'm not sure it actually impacts
the checkpatch output much.  Maybe it'd not emit a
>75 character warning when scanning commit log messages.

>   2) Using formail is the classical old UNIX way (combine small tools
>      to get the job done ;-)

Which doesn't impact your use case as formail is
already running checkpatch multiple times.

cheers, Joe

