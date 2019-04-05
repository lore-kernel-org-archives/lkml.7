Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B63C10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 14:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0325420663
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 14:24:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731131AbfDEOYr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 10:24:47 -0400
Received: from wp260.webpack.hosteurope.de ([80.237.133.29]:53748 "EHLO
        wp260.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729987AbfDEOYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 10:24:47 -0400
Received: from hsi-kbw-46-223-87-231.hsi.kabel-badenwuerttemberg.de ([46.223.87.231] helo=vega.skynet.aixah.de); authenticated
        by wp260.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1hCPls-0006rM-Da; Fri, 05 Apr 2019 16:24:44 +0200
Received: by vega.skynet.aixah.de (Postfix, from userid 1005)
        id C850AE5352; Fri,  5 Apr 2019 16:24:43 +0200 (CEST)
Date:   Fri, 5 Apr 2019 16:24:43 +0200
From:   Luis Ressel <aranea@aixah.de>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH] objtool: Don't use -Werror
Message-ID: <20190405142443.rgpwbgyym76xizad@vega.skynet.aixah.de>
References: <20190405110151.2461-1-aranea@aixah.de>
 <20190405123909.tupbgueie4czg2dd@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190405123909.tupbgueie4czg2dd@treble>
User-Agent: NeoMutt/20180716
X-bounce-key: webpack.hosteurope.de;aranea@aixah.de;1554474286;d3a562fd;
X-HE-SMSGID: 1hCPls-0006rM-Da
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2019 at 07:39:09AM -0500, Josh Poimboeuf wrote:
> What version of libelf are you using?  AFAIK, the non-elfutils version
> of libelf is buggy and has been unmaintained for 10 years.

I'm using libelf 0.8.13, which is indeed 10y old, abandoned and rather
suboptimal (elfutils OTOH is nonportable, and I haven't gotten around
yet to fixing its incompatibilities with the musl libc).

I can accept that you might not be interested in fixing issues related
to libelf, but using -Werror is a more general problem which just
happens to be triggered by my particular setup.

Regards,
Luis
