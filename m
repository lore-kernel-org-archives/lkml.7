Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D890C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 682FE20883
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:07:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbfDHOHk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 10:07:40 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:51480 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726849AbfDHOHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 10:07:39 -0400
Received: (qmail 2503 invoked by uid 2102); 8 Apr 2019 10:07:38 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 8 Apr 2019 10:07:38 -0400
Date:   Mon, 8 Apr 2019 10:07:38 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Thierry Reding <thierry.reding@gmail.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jon Hunter <jonathanh@nvidia.com>, <linux-usb@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/6] usb: host: xhci-tegra: Add Tegra186 XUSB support
In-Reply-To: <20190408081739.GB6644@ulmo>
Message-ID: <Pine.LNX.4.44L0.1904081006330.1440-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Apr 2019, Thierry Reding wrote:

> On Mon, Apr 01, 2019 at 12:40:44PM +0200, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> > 
> > Hi,
> > 
> > This series introduces support for XUSB to the Tegra186 SoC. This is
> > mostly the same as on earlier generations in that it provides an XHCI
> > compatible interface with a bit of vendor-specific glue. Perhaps the
> > most notable change is the removal of the IPFS wrapper. Patches for
> > the UPHY related changes that control the PHYs for the XUSB controller
> > were merged into v5.1.
> > 
> > This version is a rebase of the series posted here:
> > 
> >     http://patchwork.ozlabs.org/project/linux-tegra/list/?series=88193
> > 
> > There have been no code changes and I collected Reviewed-by and Acked-by
> > tags.
> > 
> > Greg, can you pick up patches 1-3 with Rob's and Mathias' Acked-by,
> > respectively? I'll pick up patches 4-6 into the Tegra tree.
> 
> Hi Greg,
> 
> would you mind picking up patches 1-3 of this series?

FYI: Greg is on vacation for the coming week, with no email access.

Alan Stern

