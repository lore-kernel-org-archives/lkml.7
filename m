Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E201AC0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 08:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4A1D218A4
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 08:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562228179;
	bh=wsLljZrT9J0hiLO+D2vsICC2fWZBLC54s8PquZQ4LnA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SF9nm0hpkmSXT6Hvsx5nVKXWBrEWjRkjoIojFTlZp/DPinhhx4xMhrTYtQrwy3xU+
	 6PbUu3/qMCMcKEHdiU4FhcQrDv24y63F/TGlxp4hR9vWrrDxOhIAyNk9cJTvLNZf89
	 J52CSPMT2cxCUcElHkUi30F7CZn4KQTavTzbMvnQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfGDIQS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 04:16:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:38206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbfGDIQS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 04:16:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2EC58218A3;
        Thu,  4 Jul 2019 08:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562228177;
        bh=wsLljZrT9J0hiLO+D2vsICC2fWZBLC54s8PquZQ4LnA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jx8JlWqJsZlq0N6WAJzDYwXSZib0Pm01Y7gpamilP0O5jX50pVAoVfwthjUwNChoi
         i6GDAUxqmE26NhkB8Y6yDxMPDSg6slhamjIIcdRvCBgSbIUjIx3hECAkwWSR2ba7Bl
         2ap3pcmxIXWrfzE0NTDfTeEchOrh7hUwNOxWccq8=
Date:   Thu, 4 Jul 2019 10:16:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Je Yen Tam <je.yen.tam@ni.com>
Cc:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH V2 2/2] PCI: Add NI-Serial PXI/PXIe+485 device IDs
Message-ID: <20190704081615.GB6438@kroah.com>
References: <20190703072516.34199-1-je.yen.tam@ni.com>
 <20190703083605.GA8996@kroah.com>
 <MN2PR04MB5920BB86A99B1ABF946B2373B7FA0@MN2PR04MB5920.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR04MB5920BB86A99B1ABF946B2373B7FA0@MN2PR04MB5920.namprd04.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 04, 2019 at 06:58:39AM +0000, Je Yen Tam wrote:
> > On Wed, Jul 03, 2019 at 12:25:16AM -0700, jeyentam wrote:
> > > Add NI PXIe-RS232, PXI-RS485 and PXIe-RS485 device IDs.
> > >
> > > Signed-off-by: jeyentam <je.yen.tam@ni.com>
> > > ---
> > >  include/linux/pci_ids.h | 12 ++++++++++++
> > >  1 file changed, 12 insertions(+)
> > 
> > You have read the comment at the top of this file, right?  If so, why 
> > are you adding these entries?
> 
> Yes, but I think these entries should be added in because the NI-Serial PXI 
> (RS232) device IDs already been defined in this file originally, so now I'm 
> adding the newly supported NI-Serial PXI (RS485), PXIe (RS232) and PXIe 
> (RS485) device IDs into here as they are the same product.

No, do not add new device ids to this file, only put them in the single
file that needs it.  This file is for device ids that are shared across
multiple drivers/files.

You should not need to touch this file at all.

thanks,

greg k-h
