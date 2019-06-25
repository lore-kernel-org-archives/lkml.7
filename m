Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E24CC48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 07:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20E1E2085A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 07:45:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OCzYGIQs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729180AbfFYHpc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 03:45:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58886 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbfFYHpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 03:45:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fO1ya63GmfBylpWC3mBrEEn/HtaxFMjiB7+XI1Of4fE=; b=OCzYGIQsjNTZ0XmeieZrq24/F
        /5CLWA5qWPxtHXBznYLUlGP00nbEZUrjD2zQNLSgtE5shKRs4U0Rpd2kGbEOLkK59mqlQm1O0L0VQ
        JylT1uGMJ2H2z5S0H9+wzQMzyPSQToNcXN8NHoWyPYWgC4YArCcBXyxs/BOeZbvlrhD0RPVwtdsOy
        +5rrs15iUt2Tvg2GbQQzlXIVVsDLwg//POYDt4tqev0VDbkY8QTihIkMD4N+0yiMPtJj8hI/sMsco
        x1t2rfcSaHCKUmFsQLhrqOWqJfV7DCu3X0swCqEkCzCNRW4Mvf45zIPaEFv3ILHKwoF9z625mzpeR
        B3bQSUF6g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hfg8u-00040W-2C; Tue, 25 Jun 2019 07:45:28 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 89D4820A0642E; Tue, 25 Jun 2019 09:45:26 +0200 (CEST)
Date:   Tue, 25 Jun 2019 09:45:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Joe Perches <joe@perches.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] get_maintainer: Add --cc option
Message-ID: <20190625074526.GS3436@hirez.programming.kicks-ass.net>
References: <20190624130323.14137-1-bigeasy@linutronix.de>
 <20190624133333.GW3419@hirez.programming.kicks-ass.net>
 <9528bb2c4455db9e130576120c8b985b9dd94e3d.camel@perches.com>
 <20190624202512.GK3436@hirez.programming.kicks-ass.net>
 <02324731bac2da6ef30b3812edaf213ecf626fe4.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02324731bac2da6ef30b3812edaf213ecf626fe4.camel@perches.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 01:42:13PM -0700, Joe Perches wrote:
> On Mon, 2019-06-24 at 22:25 +0200, Peter Zijlstra wrote:
> > I hate it when people cross-post to moderated lists, and
> > this thing just made me do it :-(
> 
> Maybe:

That seems to work,

Tested-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Thanks!

> ---
>  scripts/get_maintainer.pl | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
> index c1c088ef1420..8c2fc22f3a11 100755
> --- a/scripts/get_maintainer.pl
> +++ b/scripts/get_maintainer.pl
> @@ -27,6 +27,7 @@ my $email_usename = 1;
>  my $email_maintainer = 1;
>  my $email_reviewer = 1;
>  my $email_list = 1;
> +my $email_moderated_list = 1;
>  my $email_subscriber_list = 0;
>  my $email_git_penguin_chiefs = 0;
>  my $email_git = 0;
> @@ -248,6 +249,7 @@ if (!GetOptions(
>  		'r!' => \$email_reviewer,
>  		'n!' => \$email_usename,
>  		'l!' => \$email_list,
> +		'moderated!' => \$email_moderated_list,
>  		's!' => \$email_subscriber_list,
>  		'multiline!' => \$output_multiline,
>  		'roles!' => \$output_roles,
> @@ -1023,7 +1025,8 @@ MAINTAINER field selection options:
>      --r => include reviewer(s) if any
>      --n => include name 'Full Name <addr\@domain.tld>'
>      --l => include list(s) if any
> -    --s => include subscriber only list(s) if any
> +    --moderated => include moderated lists(s) if any (default: true)
> +    --s => include subscriber only list(s) if any (default: false)
>      --remove-duplicates => minimize duplicate email names/addresses
>      --roles => show roles (status:subsystem, git-signer, list, etc...)
>      --rolestats => show roles and statistics (commits/total_commits, %)
> @@ -1313,11 +1316,14 @@ sub add_categories {
>  		} else {
>  		    if ($email_list) {
>  			if (!$hash_list_to{lc($list_address)}) {
> -			    $hash_list_to{lc($list_address)} = 1;
>  			    if ($list_additional =~ m/moderated/) {
> -				push(@list_to, [$list_address,
> -						"moderated list${list_role}"]);
> +				if ($email_moderated_list) {
> +				    $hash_list_to{lc($list_address)} = 1;
> +				    push(@list_to, [$list_address,
> +						    "moderated list${list_role}"]);
> +				}
>  			    } else {
> +				$hash_list_to{lc($list_address)} = 1;
>  				push(@list_to, [$list_address,
>  						"open list${list_role}"]);
>  			    }
> 
> 
