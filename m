Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2AE4C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 11:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8911D2070C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 11:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567769707;
	bh=OZv2j012p2ayMdvZBqj8VHWUjthdDvlFrTRCtyzJl4o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=mva1c7H3kOEoTeQJBC13kN2yBN/3OkOKSzG89IEbGKHTG7FK0hgvvrkB5VKWkFjHV
	 Mfffk2BDm3Z8o2h21CtP0t6bVPOOOaJ2S/SABzxSgH3s520V0gpFMDCzjkp0tA7nPC
	 H3LbDX3dm4/jjGehXwy1oRg7FymaC+EERpHk5Q/I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389712AbfIFLfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 07:35:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35382 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388468AbfIFLfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 07:35:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zrqdCZIAtuCdqvP6ElMXrKWwciDgub0e1oVmcRi8cfE=; b=XdrsSrTOvJJ5oLyddFleIAkmH
        o8J+tCOH8+WP04G+51dFQb5MmdXEI73fJF5Fry5wdIbNCaaEoJr3qjr3pX6B5Yy6s5kpzKUi41YF2
        Y7CEnjmv35KqV9t19p2W+7NfuZawYA/hUb7TqGcpydk/yNrEYXH0oJgHtWn6yVjUdpGMaHxTVuCQh
        tN+gfzzp+fCPYZ5Xxlg1akAIgHX9g1AqJlrqJSl1ELJktelbyyKQ8+BwwbBy4yT5M4qLpkm9nvZEp
        M6uV4SVCMl92DZ2RDftobgPMZodDjDJlNHI3Ukm5UIRsM19sFU+0ZrPxqjISiHTR57DxwvYeJs8/F
        fAR7OkTnQ==;
Received: from [177.159.253.249] (helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i6CW7-0004R6-Ev; Fri, 06 Sep 2019 11:35:04 +0000
Date:   Fri, 6 Sep 2019 08:34:57 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jessica Yu <jeyu@kernel.org>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Thomas Gleixner <tglx@linutronix.de>, linux-doc@vger.kernel.org
Subject: Re: [PATCH] docs: license-rules.txt: cover SPDX headers on Python
 scripts
Message-ID: <20190906083457.7e7934ec@coco.lan>
In-Reply-To: <b32c2e46b91e7bcda2a9bd140673f06d71b2487a.camel@perches.com>
References: <20190905055614.7958918b@coco.lan>
        <88e638eb959095ab6657d295f9f8c27169569bf2.1567675272.git.mchehab+samsung@kernel.org>
        <20190905092703.GA30899@kroah.com>
        <20190905090701.37dcf75e@coco.lan>
        <b32c2e46b91e7bcda2a9bd140673f06d71b2487a.camel@perches.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 05 Sep 2019 10:45:36 -0700
Joe Perches <joe@perches.com> escreveu:

> On Thu, 2019-09-05 at 09:07 -0300, Mauro Carvalho Chehab wrote:
> > There are currently 227 files that don't complain with the "up to line 3"
> > rule, including COPYING (with should probably be excluded from the check).
> > 
> > Patches are at:
> > 
> > 	https://git.linuxtv.org/mchehab/experimental.git/log/?h=spdx_pedantic
> > 
> > Btw, most violations are due to:
> > 
> > /*
> >  * SPDX...  
> 
> Hey Mauro.
> 
> Here's a little script to move all of the improperly located
> SPDX-License-Identifier lines in [.ch] files.
> 
> Using this command line:
> 
> $ git grep -n 'SPDX-License-Identifier: ' -- '*.[ch]' | \
>   grep -v ':1:' | perl move_spdx.pl
> 
> and
> 
> $ cat move_spdx.pl
> while (<>) {
>     /^([^:]+):([^:]+):(.*)/;
>     my ($file, $line, $spdx) = ($1, $2, $3);
>     $spdx =~ s/^\s*\/?\*\s*//;
>     $spdx =~ s/\s*\*\/\s*$//;
>     if ($file =~ /\.h$/) {
> 	$spdx = "/* $spdx */";
>     } else {
> 	$spdx = "// $spdx";
>     }
>     open(FH, '<', $file) or die $!;
>     my @lines = <FH>;
>     close FH;
>     open(FH, '>', $file) or die $!;
>     print FH "$spdx\n";
>     my $count = 0;
>     foreach (@lines) {
> 	$count++;
> 	next if ($count == $line);
> 	next if ($count == $line - 1 && $_ =~ /^\s*\*\s*$/);
> 	next if ($count == $line + 1 && $_ =~ /^\s*\*\s*$/);
> 	print FH "$_";
>     }
>     close FH;
> }
> 
> which gives this diff for today's -next

Nice script!

I did some changes on it, plus one change at the pedantic mode of
scripts/spdxcheck.py, and placed the corresponding patches at:

	https://git.linuxtv.org/mchehab/experimental.git/log/?h=spdx_pedantic

With that, we now have (next-20190904):

Warning: SPDX header for file Documentation/networking/caif/caif.rst is at line 2
Warning: SPDX header for file Documentation/networking/mac80211_hwsim/mac80211_hwsim.rst is at line 2
Warning: SPDX header for file tools/thermal/tmon/tmon.8 is at line 2

The first two are due to a ":orphan:" tag at the RST files. IMO, it makes
sense to have this at the very beginning of the files with weren't added
yet at the documentation body. Having them generating a warning is a plus.

The last one is interesting... what's the "very first line" where a
SPDX header tag should be on a man page?

Thanks,
Mauro
