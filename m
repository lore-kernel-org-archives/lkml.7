Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B994C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 08:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5218121019
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 08:03:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbfEIIDs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 04:03:48 -0400
Received: from smtprelay0215.hostedemail.com ([216.40.44.215]:40533 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725963AbfEIIDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 04:03:48 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id A754C180A8437;
        Thu,  9 May 2019 08:03:46 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: crown87_3c409a1aa411
X-Filterd-Recvd-Size: 1325
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Thu,  9 May 2019 08:03:45 +0000 (UTC)
Message-ID: <3d1911051672d4d84b46dfa229b8c82c4a41813b.camel@perches.com>
Subject: Re: [PATCH v4] checkpatch: add command-line option for TAB size
From:   Joe Perches <joe@perches.com>
To:     Antonio Borneo <borneo.antonio@gmail.com>,
        Andy Whitcroft <apw@canonical.com>,
        "Elliott, Robert (Servers)" <elliott@hpe.com>
Cc:     linux-kernel@vger.kernel.org
Date:   Thu, 09 May 2019 01:03:44 -0700
In-Reply-To: <20190509072104.18734-1-borneo.antonio@gmail.com>
References: <20190509072104.18734-1-borneo.antonio@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-05-09 at 09:21 +0200, Antonio Borneo wrote:
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -2224,7 +2229,7 @@ sub string_find_replace {
>  sub tabify {
>  	my ($leading) = @_;
>  
> -	my $source_indent = 8;
> +	my $source_indent = $tabsize;
>  	my $max_spaces_before_tab = $source_indent - 1;

I didn't test this.

Does this work properly if --tab-size=1 ?
Maybe die if ($tabsize < 2); is necessary?


