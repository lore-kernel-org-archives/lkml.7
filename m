Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD3DC282DC
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 16:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D302B2146F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 16:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731476AbfDEQaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 12:30:18 -0400
Received: from wp260.webpack.hosteurope.de ([80.237.133.29]:35266 "EHLO
        wp260.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730554AbfDEQaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 12:30:18 -0400
Received: from hsi-kbw-46-223-87-231.hsi.kabel-badenwuerttemberg.de ([46.223.87.231] helo=vega.skynet.aixah.de); authenticated
        by wp260.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1hCRjM-0005lX-1e; Fri, 05 Apr 2019 18:30:16 +0200
Received: by vega.skynet.aixah.de (Postfix, from userid 1005)
        id 9F561E5352; Fri,  5 Apr 2019 18:30:15 +0200 (CEST)
Date:   Fri, 5 Apr 2019 18:30:15 +0200
From:   Luis Ressel <aranea@aixah.de>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH] objtool: Don't use -Werror
Message-ID: <20190405163015.3t4r7lzywxjsgg4n@vega.skynet.aixah.de>
References: <20190405110151.2461-1-aranea@aixah.de>
 <20190405123909.tupbgueie4czg2dd@treble>
 <20190405142443.rgpwbgyym76xizad@vega.skynet.aixah.de>
 <20190405143926.wmrkjsazlheeg6qs@treble>
 <20190405160550.62arkmvj67zm6oc2@vega.skynet.aixah.de>
 <20190405161541.6rs7iz4w4dj72azm@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190405161541.6rs7iz4w4dj72azm@treble>
User-Agent: NeoMutt/20180716
X-bounce-key: webpack.hosteurope.de;aranea@aixah.de;1554481817;2198bfbf;
X-HE-SMSGID: 1hCRjM-0005lX-1e
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2019 at 11:15:41AM -0500, Josh Poimboeuf wrote:
> I consider that a good thing, because I *want* the build to be broken
> when somebody uses a bad version of libelf.  A patch to produce a more
> useful error message (e.g., "bad version of libelf") would be welcome of
> course.

Do that if you must, but please do it properly (i.e. check the libelf
version and error out explicitly with a suitable message, instead of
relying on -Werror), and don't backport the change to stable kernels.

The patch which I referenced in my commit message suddently broke the
build for me between 4.19.32 and .33; I consider that a regression which
ought to be fixed.

Regards,
Luis
