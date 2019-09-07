Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD579C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 19:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99C2D21848
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 19:10:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404261AbfIGTKN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 15:10:13 -0400
Received: from netrider.rowland.org ([192.131.102.5]:39091 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727014AbfIGTKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 15:10:13 -0400
Received: (qmail 1746 invoked by uid 500); 7 Sep 2019 15:10:11 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 7 Sep 2019 15:10:11 -0400
Date:   Sat, 7 Sep 2019 15:10:11 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     Julius Werner <jwerner@chromium.org>
cc:     Greg KH <greg@kroah.com>, Oliver Neukum <oneukum@suse.com>,
        USB Storage list <usb-storage@lists.one-eyed-alien.net>,
        Dan Williams <dcbw@redhat.com>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>
Subject: Re: [PATCH] usb: storage: Add ums-cros-aoa driver
In-Reply-To: <CAODwPW-FybmnZ97eTfShya_z1Oxrc91ofe6yC4vNN2ri51V5fw@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1909071506500.1597-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Sep 2019, Julius Werner wrote:

> FWIW, I found a suitable workaround now to get my use case working
> with existing kernels: I can do the mode switch from userspace, then
> after the device reenumerates I can manually disable any interfaces I
> don't like by writing 0 to their 'authorized' node, and then I write
> the VID/PID to usb-storage/new_id.

Okay, very good.

> I still think it would be nice in general to be able to force a driver
> to bind a specific device (rather than a VID/PID match), but it's not
> a pressing need for me anymore.

You _can_ do this currently, by writing the name of the interface to 
/sys/bus/usb/drivers/usb-storage/bind.  But as you know, this doesn't 
work unless the VID & PID already match one of the driver's entries.

Alan Stern

