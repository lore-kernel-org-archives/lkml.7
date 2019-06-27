Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C40C4321A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 22:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31487208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 22:09:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfF0WJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 18:09:05 -0400
Received: from smtprelay0191.hostedemail.com ([216.40.44.191]:36952 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726557AbfF0WJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 18:09:04 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 2A88D837F24D;
        Thu, 27 Jun 2019 22:09:03 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: alley15_31b2a6b628109
X-Filterd-Recvd-Size: 2706
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Thu, 27 Jun 2019 22:09:01 +0000 (UTC)
Message-ID: <3740b16e5d0a3144e2d48af7cf56ae8020c3f9af.camel@perches.com>
Subject: Re: [tip:timers/core] hrtimer: Use a bullet for the returns bullet
 list
From:   Joe Perches <joe@perches.com>
To:     corbet@lwn.net, linux-doc@vger.kernel.org, tglx@linutronix.de,
        mingo@kernel.org, mchehab@infradead.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mchehab+samsung@kernel.org,
        linux-tip-commits@vger.kernel.org
Cc:     docutils-develop@lists.sourceforge.net
Date:   Thu, 27 Jun 2019 15:08:59 -0700
In-Reply-To: <tip-516337048fa40496ae5ca9863c367ec991a44d9a@git.kernel.org>
References: <74ddad7dac331b4e5ce4a90e15c8a49e3a16d2ac.1561372382.git.mchehab+samsung@kernel.org>
         <tip-516337048fa40496ae5ca9863c367ec991a44d9a@git.kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-06-27 at 14:46 -0700, tip-bot for Mauro Carvalho Chehab
wrote:
> Commit-ID:  516337048fa40496ae5ca9863c367ec991a44d9a
> Gitweb:     https://git.kernel.org/tip/516337048fa40496ae5ca9863c367ec991a44d9a
> Author:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> AuthorDate: Mon, 24 Jun 2019 07:33:26 -0300
> Committer:  Thomas Gleixner <tglx@linutronix.de>
> CommitDate: Thu, 27 Jun 2019 23:30:04 +0200
> 
> hrtimer: Use a bullet for the returns bullet list
> 
> That gets rid of this warning:
> 
>    ./kernel/time/hrtimer.c:1119: WARNING: Block quote ends without a blank line; unexpected unindent.

Doesn't this form occur multiple dozens of times in
kernel sources?

For instance:

$ git grep -B3 -A5 -P "^ \* Returns:?$" | \
  grep -P -A8 '\-\s+\*\s*@\w+:'

I think the warning is odd at best and docutils might
be updated or the warning ignored or suppressed.

> and displays nicely both at the source code and at the produced
> documentation.

> diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
[]
> @@ -1114,9 +1114,10 @@ EXPORT_SYMBOL_GPL(hrtimer_start_range_ns);
>   * @timer:	hrtimer to stop
>   *
>   * Returns:
> - *  0 when the timer was not active
> - *  1 when the timer was active
> - * -1 when the timer is currently executing the callback function and
> + *
> + *  *  0 when the timer was not active
> + *  *  1 when the timer was active
> + *  * -1 when the timer is currently executing the callback function and
>   *    cannot be stopped
>   */
>  int hrtimer_try_to_cancel(struct hrtimer *timer)

