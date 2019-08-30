Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1BCC3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 16:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B60972087F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 16:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbfH3Qhz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 12:37:55 -0400
Received: from smtprelay0089.hostedemail.com ([216.40.44.89]:40152 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727914AbfH3Qhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 12:37:55 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id C4F3018224D7B;
        Fri, 30 Aug 2019 16:37:53 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: wind21_a98b898a015f
X-Filterd-Recvd-Size: 2175
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Fri, 30 Aug 2019 16:37:52 +0000 (UTC)
Message-ID: <19c9b30b3d77a65c6c4289a2eeeb6cbe40594aab.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Remove obsolete period from "ambiguous
 SHA1" query
From:   Joe Perches <joe@perches.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Andy Whitcroft <apw@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Date:   Fri, 30 Aug 2019 09:37:51 -0700
In-Reply-To: <20190830163103.15914-1-sean.j.christopherson@intel.com>
References: <20190830163103.15914-1-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-08-30 at 09:31 -0700, Sean Christopherson wrote:
> Git dropped the period from its "ambiguous SHA1" error message in commit
> 0c99171ad2 ("get_short_sha1: mark ambiguity error for translation"),
> circa 2016.  Drop the period from checkpatch's associated query so as to
> match both the old and new error messages.
> 
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  scripts/checkpatch.pl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 93a7edfe0f05..ef3642c53100 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -962,7 +962,7 @@ sub git_commit_info {
>  
>  	return ($id, $desc) if ($#lines < 0);
>  
> -	if ($lines[0] =~ /^error: short SHA1 $commit is ambiguous\./) {
> +	if ($lines[0] =~ /^error: short SHA1 $commit is ambiguous/) {
>  # Maybe one day convert this block of bash into something that returns
>  # all matching commit ids, but it's very slow...
>  #

Thanks.

Did git ever change to actually support human readable
messages in multiple languages?

If so, this won't work for non-english output.

It probably doesn't matter though.

Acked-by: Joe Perches <joe@perches.com>


