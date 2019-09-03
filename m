Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 265F5C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 08:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 053A622CF7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 08:46:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbfICIqR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 04:46:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:45422 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725888AbfICIqR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 04:46:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 990FBAF62;
        Tue,  3 Sep 2019 08:46:15 +0000 (UTC)
Message-ID: <1567500374.2878.2.camel@suse.com>
Subject: Re: [PATCH] usb: storage: Add ums-cros-aoa driver
From:   Oliver Neukum <oneukum@suse.com>
To:     Greg KH <greg@kroah.com>, Alan Stern <stern@rowland.harvard.edu>
Cc:     Julius Werner <jwerner@chromium.org>,
        USB Storage list <usb-storage@lists.one-eyed-alien.net>,
        Dan Williams <dcbw@redhat.com>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>
Date:   Tue, 03 Sep 2019 10:46:14 +0200
In-Reply-To: <20190902164724.GA22619@kroah.com>
References: <CAODwPW8gTZ_2WEc9n=WJ2PEmQk2anTQYfwQ-898+kOq6wsjnZw@mail.gmail.com>
         <Pine.LNX.4.44L0.1908301337150.1459-100000@iolanthe.rowland.org>
         <20190902164724.GA22619@kroah.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, den 02.09.2019, 18:47 +0200 schrieb Greg KH:
> 
> This should work just fine today.  Add a new device id to the "new_id"
> file and then tell the driver to bind.  That's pretty much the same as a
> "force_bind", right?

That looks like a race condition by design to me.

	Regards
		Oliver

