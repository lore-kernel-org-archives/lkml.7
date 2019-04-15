Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FBD5C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 15:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6535D2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 15:32:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbfDOPcf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 11:32:35 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:39524 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727659AbfDOPce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 11:32:34 -0400
Received: (qmail 5244 invoked by uid 2102); 15 Apr 2019 11:32:33 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 15 Apr 2019 11:32:33 -0400
Date:   Mon, 15 Apr 2019 11:32:33 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Kento.A.Kobayashi@sony.com
cc:     bvanassche@acm.org, <martin.petersen@oracle.com>,
        <jejb@linux.ibm.com>, <oneukum@suse.com>,
        <gregkh@linuxfoundation.org>,
        <usb-storage@lists.one-eyed-alien.net>, <Jacky.Cao@sony.com>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linux-usb@vger.kernel.org>
Subject: RE: [PATCH] usb: uas: fix usb subsystem hang after power off hub
 port
In-Reply-To: <Pine.LNX.4.44L0.1904151107350.1575-100000@iolanthe.rowland.org>
Message-ID: <Pine.LNX.4.44L0.1904151129550.1575-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Apr 2019, Alan Stern wrote:

> On Mon, 15 Apr 2019 Kento.A.Kobayashi@sony.com wrote:
> 
> > Hi
> > 
> > >The unbind happens from inside the SCSI EH callback.  If that really is not allowed, we'll need to change it.  Or we can just change it regardless, since the effort required is pretty small.
> > >
> > >Kento, please try the patch below.  Does it help with your problem?
> > 
> > Thank you for suggestion about this problem.
> > I confirmed your patch fixes this problem.
> 
> Good; I will submit it.

I forgot to ask: Is it okay to add

	Tested-by: Kento Kobayashi <Kento.A.Kobayashi@sony.com>

along with the patch?

Alan Stern

