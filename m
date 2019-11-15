Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF57C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 10:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B018120748
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 10:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbfKOKq4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 05:46:56 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:41785 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbfKOKqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 05:46:55 -0500
Received: from 79.184.253.153.ipv4.supernova.orange.pl (79.184.253.153) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id 9e92dac80e5ea588; Fri, 15 Nov 2019 11:46:53 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Petr Mladek <pmladek@suse.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: linux-next: manual merge of the pm tree with the printk tree
Date:   Fri, 15 Nov 2019 11:46:53 +0100
Message-ID: <2126744.rv85diC2z5@kreacher>
In-Reply-To: <20191115110500.2bad45b2@canb.auug.org.au>
References: <20191115110500.2bad45b2@canb.auug.org.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, November 15, 2019 1:05:00 AM CET Stephen Rothwell wrote:
> 
> --Sig_/8dHD0qGh0F9UnYxbYqUlngQ
> Content-Type: text/plain; charset=US-ASCII
> Content-Transfer-Encoding: quoted-printable
> 
> Hi all,
> 
> Today's linux-next merge of the pm tree got a conflict in:
> 
>   scripts/checkpatch.pl
> 
> between commit:
> 
>   1d28122131b2 ("checkpatch: don't warn about new vsprintf pointer extensio=
> n '%pe'")
> 
> from the printk tree and commit:
> 
>   3bd32d6a2ee6 ("lib/vsprintf: Add %pfw conversion specifier for printing f=
> wnode names")
> 
> from the pm tree.
> 
> I fixed it up (see below) and can carry the fix as necessary.

Thanks, and it looks good to me.



