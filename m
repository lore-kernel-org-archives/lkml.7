Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB54C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 12:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A463F206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 12:02:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbfCKMCc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 08:02:32 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:48937 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbfCKMCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 08:02:31 -0400
Received: from 79.184.254.189.ipv4.supernova.orange.pl (79.184.254.189) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id ce8fa1b6db4e3085; Mon, 11 Mar 2019 13:02:29 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Kevin Hilman <khilman@baylibre.com>, Joe Perches <joe@perches.com>
Cc:     Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] power: Add and use pr_fmt
Date:   Mon, 11 Mar 2019 13:00:45 +0100
Message-ID: <1770110.j5eI0eBPZe@aspire.rjw.lan>
In-Reply-To: <7himwyjcco.fsf@baylibre.com>
References: <06d16c65a81d28016643d714f8aa3dfd7a2ad3ed.camel@perches.com> <7himwyjcco.fsf@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, March 5, 2019 3:15:19 AM CET Kevin Hilman wrote:
> Joe Perches <joe@perches.com> writes:
> 
> > Prefix all printk/pr_<level> messages with "PM: " to make the
> > logging a bit more consistent.
> >
> > Miscellanea:
> >
> > o Convert a few printks to pr_<level>
> > o Whitespace to align to open parentheses
> > o Remove embedded "PM: " from pr_debugs as pr_fmt adds it
> >
> > Signed-off-by: Joe Perches <joe@perches.com>
> 
> Reviewed-by: Kevin Hilman <khilman@baylibre.com>
> 

Patch applied, thanks!

