Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC4CCC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 08:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A623218E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 08:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbfCPIIL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 04:08:11 -0400
Received: from smtprelay0112.hostedemail.com ([216.40.44.112]:44701 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726626AbfCPIII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 04:08:08 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 1E69A100E86C3;
        Sat, 16 Mar 2019 08:08:07 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: sheep63_63ddafc4f1057
X-Filterd-Recvd-Size: 1660
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Sat, 16 Mar 2019 08:08:06 +0000 (UTC)
Message-ID: <17a4be1ffdaf908ff02a51bf8dea707117067f9b.camel@perches.com>
Subject: Re: [PATCH] Use fall-through attribute rather than magic comments
From:   Joe Perches <joe@perches.com>
To:     Shawn Landden <shawn@git.icu>, linux-kernel@vger.kernel.org
Cc:     "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Andy Whitcroft <apw@canonical.com>
Date:   Sat, 16 Mar 2019 01:08:04 -0700
In-Reply-To: <20190316033841.7659-1-shawn@git.icu>
References: <20190316033841.7659-1-shawn@git.icu>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-03-15 at 21:38 -0600, Shawn Landden wrote:
> The -Wimplicit-fallthrough warning recognizes magic comments
> https://developers.redhat.com/blog/2017/03/10/wimplicit-fallthrough-in-gcc-7/
> It is my opinion that magic comments are a bad idea. Comments should not
> change the interpretation (even regarding errors) of C code.
> (It also happens to break distcc as distcc compiles pre-processed .i files.)
> 
> I am aware this can cause some merge pain.
> 
> Also, if my style is OK, then needs some changes to checkpatch.pl. (CCed)

I think it's a pretty good idea
https://lkml.org/lkml/2017/2/10/485

It's generally better to add a patch first to the include
file and then conversion patches by subsystem instead of one
gigantic patch spanning multiple subsystems.

Or send a script that does the conversion.


