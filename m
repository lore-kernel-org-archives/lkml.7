Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE87C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 982F32084F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbfDZPeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 11:34:05 -0400
Received: from netrider.rowland.org ([192.131.102.5]:49243 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727104AbfDZPeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 11:34:03 -0400
Received: (qmail 30040 invoked by uid 500); 26 Apr 2019 11:34:02 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 26 Apr 2019 11:34:02 -0400
Date:   Fri, 26 Apr 2019 11:34:02 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     Jim Lin <jilin@nvidia.com>
cc:     linux-usb@vger.kernel.org, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/6] usb: Add Clear_TT_Buffer support for XHCI
In-Reply-To: <1556290130-9347-1-git-send-email-jilin@nvidia.com>
Message-ID: <Pine.LNX.4.44L0.1904261128380.23806-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Apr 2019, Jim Lin wrote:

> Jim Lin (6):
>   usb: hub:Extend usb_hub_clear_tt_buffer parameter
>   usb: isp1760:Adjusted for usb_hub_clear_tt_buffer
>   usb: fotg210:Adjusted for usb_hub_clear_tt_buffer
>   usb: ehci: Adjusted for usb_hub_clear_tt_buffer
>   usb: dwc2: Adjusted for usb_hub_clear_tt_buffer
>   usb: xhci: Add Clear_TT_Buffer
> 
>  drivers/usb/core/hub.c            |  5 +++--
>  drivers/usb/dwc2/hcd_intr.c       |  2 +-
>  drivers/usb/host/ehci-q.c         |  2 +-
>  drivers/usb/host/fotg210-hcd.c    |  2 +-
>  drivers/usb/host/xhci-ring.c      | 25 +++++++++++++++++++++++++
>  drivers/usb/host/xhci.c           |  7 +++++++
>  drivers/usb/host/xhci.h           |  3 +++
>  drivers/usb/isp1760/isp1760-hcd.c |  5 +++--
>  include/linux/usb/hcd.h           |  2 +-
>  9 files changed, 45 insertions(+), 8 deletions(-)

This doesn't explain anything.  After reading the patches, I could see 
that patches 2-5 are needed in order to work with patch 1, but I don't 
know why patch 1 was needed in the first place.  It looks like patch 1 
forces callers to add an extra argument containing information that is 
already available, so why is the extra argument needed?

In any case, this is the sort of the thing you should explain to people
instead of forcing them to figure it out for themselves.

Alan Stern

