Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBCB6C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 17:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD6F8215EA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 17:36:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731019AbfJARgb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 13:36:31 -0400
Received: from ms.lwn.net ([45.79.88.28]:38418 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730809AbfJARgb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 13:36:31 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 44341316;
        Tue,  1 Oct 2019 17:36:30 +0000 (UTC)
Date:   Tue, 1 Oct 2019 11:36:29 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Kees Cook <keescook@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] docs: Programmatically render MAINTAINERS into ReST
Message-ID: <20191001113629.6cdb1abb@lwn.net>
In-Reply-To: <201910010916.8B8248222@keescook>
References: <20190924230208.12414-1-keescook@chromium.org>
        <20191001083147.3a1b513f@lwn.net>
        <201910010916.8B8248222@keescook>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Oct 2019 09:27:29 -0700
Kees Cook <keescook@chromium.org> wrote:

> On Tue, Oct 01, 2019 at 08:31:47AM -0600, Jonathan Corbet wrote:
> > On a separate note...it occurred to me, rather belatedly as usual, that
> > last time we discussed doing this that there was some opposition to adding
> > a second MAINTAINERS parser to the kernel; future changes to the format of
> > that file may force both to be adjusted, and somebody will invariably
> > forget one.  Addressing that, if we feel a need to do so, probably requires
> > tweaking get_maintainer.pl to output the information in a useful format.  
> 
> That's a reasonable point, but I would make two observations:
> 
> - get_maintainers.pl is written in Perl and I really don't want to write
>   more Perl. ;)

Trust me, I get it!

> - the parsing methods in get_maintainers is much more focused on the
>   file/pattern matching and is blind to the structure of the rest
>   of the document (it only examines '^[A-Z]:' and blank lines), and
>   does so "on demand", in that it hunts through the entire MAINTAINERS
>   file contents for each path match.
> 
> So I don't think it's suitable to merge functionality here...

Makes sense to me.  If anybody out there objects, speak now ...

jon
