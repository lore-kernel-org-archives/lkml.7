Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0206CC4CEC6
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 21:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1E2120830
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 21:09:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbfILVJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 17:09:07 -0400
Received: from smtprelay0043.hostedemail.com ([216.40.44.43]:38089 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728249AbfILVJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 17:09:06 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 529AE180A884F;
        Thu, 12 Sep 2019 21:09:05 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: fog75_4f3e7db1c3c36
X-Filterd-Recvd-Size: 2110
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Thu, 12 Sep 2019 21:09:04 +0000 (UTC)
Message-ID: <e4f60b3f68bd214261b946f34ea0459098da00c3.camel@perches.com>
Subject: Re: [PATCH] checkpatch.pl: Don't complain about nominal authors if
 there isn't one
From:   Joe Perches <joe@perches.com>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Andy Whitcroft <apw@canonical.com>
Cc:     Kernel development list <linux-kernel@vger.kernel.org>
Date:   Thu, 12 Sep 2019 14:09:03 -0700
In-Reply-To: <Pine.LNX.4.44L0.1909121651180.1305-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1909121651180.1305-100000@iolanthe.rowland.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-09-12 at 16:55 -0400, Alan Stern wrote:
> checkpatch.pl shouldn't warn about a "Missing Signed-off-by: line by
> nominal patch author" if there is no nominal patch author.  Without
> this change, checkpatch always gives me the following warning:
> 
>         WARNING: Missing Signed-off-by: line by nominal patch author ''

When/how does this occur?  Example please.

> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> 
> ---
> 
>  scripts/checkpatch.pl |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: usb-devel/scripts/checkpatch.pl
> ===================================================================
> --- usb-devel.orig/scripts/checkpatch.pl
> +++ usb-devel/scripts/checkpatch.pl
> @@ -6673,7 +6673,7 @@ sub process {
>                 if ($signoff == 0) {
>                         ERROR("MISSING_SIGN_OFF",
>                               "Missing Signed-off-by: line(s)\n");
> -               } elsif (!$authorsignoff) {
> +               } elsif ($author ne '' && !$authorsignoff) {
>                         WARN("NO_AUTHOR_SIGN_OFF",
>                              "Missing Signed-off-by: line by nominal patch author '$author'\n");
>                 }
> 

