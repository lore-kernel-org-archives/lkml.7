Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D562CECE588
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 17:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A80DB20650
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 17:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388591AbfJORYg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 13:24:36 -0400
Received: from smtprelay0040.hostedemail.com ([216.40.44.40]:54325 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727242AbfJORYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 13:24:36 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id D243918070EDC;
        Tue, 15 Oct 2019 17:24:34 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: touch42_27b1af360ab2d
X-Filterd-Recvd-Size: 1865
Received: from XPS-9350 (unknown [172.58.27.13])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Tue, 15 Oct 2019 17:24:32 +0000 (UTC)
Message-ID: <70c9eaac3510bf8857338d82e14c7e3eded9faa9.camel@perches.com>
Subject: Re: [PATCH] checkpatch: use patch subject when reading from stdin
From:   Joe Perches <joe@perches.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Andy Whitcroft <apw@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 15 Oct 2019 10:24:02 -0700
In-Reply-To: <CAMuHMdUvoQz7a7NmLHdpNjRnAUMdbqxFRvB2vdLhHj8pw4Z9Rw@mail.gmail.com>
References: <20191008094006.8251-1-geert+renesas@glider.be>
         <19c54ca5b3750bebc057e20542ad6c0c2acef960.camel@perches.com>
         <CAMuHMdUYf=0RVeJhSqs9WUY4H+o9Jk8U+J6tUsnMjz7bgKpAxw@mail.gmail.com>
         <f59c1ef48b64bcf97047df5952f8994f75c0cecf.camel@perches.com>
         <CAMuHMdWvLbcGDG=VZDSAd=E-Bb_FEt9zvffpJu5nubMCKMZUZA@mail.gmail.com>
         <CAMuHMdWZYOsJv1uQkOFRK2tZO+E8sSHEneUM-p+q5FyAmYZ9Fw@mail.gmail.com>
         <fa4ce46605a81d660be73361a4fdd30240a6348e.camel@perches.com>
         <CAMuHMdWSGzs7BHqeHC0W5qUEpYqJ8B3Os4wdY11JNzt5+xEaiQ@mail.gmail.com>
         <e09057e0eefb221549ef9686826e2d190ef36a9c.camel@perches.com>
         <CAMuHMdUvoQz7a7NmLHdpNjRnAUMdbqxFRvB2vdLhHj8pw4Z9Rw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-10-15 at 18:40 +0200, Geert Uytterhoeven wrote:
> The advantage of formail over git-mailsplit is that the former doesn't
> create a bunch of files that need to be stored in a temporary place,
> and cleant up afterwards.
> But hey, that can be handled in yet-another-script...

Or yet-another-git-hook.

