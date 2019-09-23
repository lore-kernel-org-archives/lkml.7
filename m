Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F1EFC4CEC4
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 15:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04688207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 15:39:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732243AbfIWPjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 11:39:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:56320 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727682AbfIWPjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 11:39:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 66FE5AD72;
        Mon, 23 Sep 2019 15:39:11 +0000 (UTC)
Date:   Mon, 23 Sep 2019 17:39:08 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Richard Palethorpe <rpalethorpe@suse.de>
Cc:     ltp@lists.linux.it, Andy Lutomirski <luto@kernel.org>, lkp@01.org,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>
Subject: Re: [LTP] 12abeb544d: ltp.read_all_dev.fail
Message-ID: <20190923153908.GA379@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20190923003846.GB15734@shao2-debian>
 <871rw7l9dv.fsf@rpws.prws.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871rw7l9dv.fsf@rpws.prws.suse.cz>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> > FYI, we noticed the following commit (built with gcc-7):

> > commit: 12abeb544d548f55f56323fc6e5e6c0fb74f58e1 ("horrible test hack")
> > https://kernel.googlesource.com/pub/scm/linux/kernel/git/luto/linux.git random/kill-it

...
> > tst_test.c:1108: INFO: Timeout per run is 0h 05m 00s
> > Test timeouted, sending SIGKILL!
> > tst_test.c:1148: INFO: If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1
> > tst_test.c:1149: BROK: Test killed! (timeout?)

> So perhaps this is caused by reads of /dev/random hanging?

> At any rate,
> I suppose this is intended to deliberately break something, so we can
> ignore it.
Yep, I'd ignore it, [1] really looks like the commit description "horrible test hack" :)

Kind regards,
Petr

[1] https://kernel.googlesource.com/pub/scm/linux/kernel/git/luto/linux.git/+/12abeb544d548f55f56323fc6e5e6c0fb74f58e1%5E%21/#F0
