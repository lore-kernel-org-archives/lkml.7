Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD70C47E49
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 15:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CD6F21929
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 15:09:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731061AbfKEPJz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 10:09:55 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:44978 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727889AbfKEPJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 10:09:55 -0500
Received: (qmail 2356 invoked by uid 2102); 5 Nov 2019 10:09:54 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 5 Nov 2019 10:09:54 -0500
Date:   Tue, 5 Nov 2019 10:09:54 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Oliver Neukum <oneukum@suse.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 4.19 114/149] UAS: Revert commit 3ae62a42090f ("UAS: fix
 alignment of scatter/gather segments")
In-Reply-To: <1572964580.2921.21.camel@suse.com>
Message-ID: <Pine.LNX.4.44L0.1911051007140.1678-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Nov 2019, Oliver Neukum wrote:

> Am Montag, den 04.11.2019, 22:45 +0100 schrieb Greg Kroah-Hartman:
> >         Since commit ea44d190764b ("usbip: Implement SG support to
> >         vhci-hcd and stub driver") was merged, the USB/IP driver can
> >         also handle SG.
> 
> Hi,
> 
> same story as 4.4.x

I'm not sure about uas, but it was reported just yesterday that the 
corresponding commit for usb-storage caused a 30% speed degradation:

	https://marc.info/?l=linux-usb&m=157293660212040&w=2

Given this information, perhaps you will decide that the revert is 
worthwhile.

Alan Stern

