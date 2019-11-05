Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03100C5DF62
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 15:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6D902087E
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 15:41:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389916AbfKEPlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 10:41:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:36232 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389507AbfKEPlJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 10:41:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F1178B066;
        Tue,  5 Nov 2019 15:41:07 +0000 (UTC)
Message-ID: <1572968467.2921.27.camel@suse.com>
Subject: Re: [PATCH 4.19 114/149] UAS: Revert commit 3ae62a42090f ("UAS: fix
 alignment of scatter/gather segments")
From:   Oliver Neukum <oneukum@suse.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Date:   Tue, 05 Nov 2019 16:41:07 +0100
In-Reply-To: <Pine.LNX.4.44L0.1911051007140.1678-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1911051007140.1678-100000@iolanthe.rowland.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, den 05.11.2019, 10:09 -0500 schrieb Alan Stern:
> On Tue, 5 Nov 2019, Oliver Neukum wrote:
> 
> > Am Montag, den 04.11.2019, 22:45 +0100 schrieb Greg Kroah-Hartman:
> > >         Since commit ea44d190764b ("usbip: Implement SG support to
> > >         vhci-hcd and stub driver") was merged, the USB/IP driver can
> > >         also handle SG.
> > 
> > Hi,
> > 
> > same story as 4.4.x
> 
> I'm not sure about uas, but it was reported just yesterday that the 
> corresponding commit for usb-storage caused a 30% speed degradation:
> 
> 	https://marc.info/?l=linux-usb&m=157293660212040&w=2
> 
> Given this information, perhaps you will decide that the revert is 
> worthwhile.

Damned if I do, damned if I do not.
Check for usbip and special case it?

	Regards
		Oliver

