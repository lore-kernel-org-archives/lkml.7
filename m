Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE499C43215
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 07:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94CE92073F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 07:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574840598;
	bh=1AKYs70Rh66DjEntki+8rSSBYyo2tSLbJ6Mxvzq9V6k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=E96C33+llUPp7ChdXeVoA6Gq/aO519NXz1TRd6T/Cy3gJQDfKqnV1YL05skkwpId2
	 GCYlAcP+HRXyPQBd75d6seS5+evYpjOLYgwlHrQAnTK7Z7rO1jCXuAc0U20Qwhc+P/
	 ucrgAnw1RAYxkj3Bi1sbn2NBZ2s5Lj/+9eC4dGCw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbfK0HnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 02:43:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:55402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbfK0HnR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 02:43:17 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FFD220665;
        Wed, 27 Nov 2019 07:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574840596;
        bh=1AKYs70Rh66DjEntki+8rSSBYyo2tSLbJ6Mxvzq9V6k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rfmpiHc5WPaTDEyw/chmdqeAzaX/cuFCPS33UaQr2JDugtjW8PiZ/G3au6CpzEz7h
         69I3RxSd0IH6W8xUsXlMHJ3MQLg13shuQ0EOenTY2zi2exI4iMbcDXmPQk2Qc9husT
         O9Q5WSGk5UTB89JPKqgYQR6x+YLcFCQa4a8J+3ys=
Date:   Wed, 27 Nov 2019 08:43:13 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Je Yen Tam <je.yen.tam@ni.com>
Cc:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH] Revert "serial/8250: Add support for NI-Serial
 PXI/PXIe+485 devices"
Message-ID: <20191127074313.GA1821354@kroah.com>
References: <20191127031751.9082-1-je.yen.tam@ni.com>
 <20191127065903.GA1725222@kroah.com>
 <MN2PR04MB5920DA1BBA0AF9D07E48EAC1B7440@MN2PR04MB5920.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR04MB5920DA1BBA0AF9D07E48EAC1B7440@MN2PR04MB5920.namprd04.prod.outlook.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2019 at 07:23:39AM +0000, Je Yen Tam wrote:
> > Subject: [EXTERNAL] Re: [PATCH] Revert "serial/8250: Add support for NI-Serial
> > PXI/PXIe+485 devices"
> > 
> > On Wed, Nov 27, 2019 at 11:17:51AM +0800, Je Yen Tam wrote:
> > > This reverts commit fdc2de87124f5183a98ea7eced1f76dbdba22951 which is
> > > commit 225607f75454 ("serial/8250: Add support for NI-Serial PXI/PXIe+485
> > devices").
> > 
> > That sentance does not make sense.  fdc2de87124f ("serial/8250: Add support for
> > NI-Serial PXI/PXIe+485 devices") is in the 5.4 kernel tree, where did the commit id
> > "225607f75454" come from?  I don't see it anywhere in Linus's tree.
> 
> Overlooked the commit 225607f75454 which only visible to my own branch, will 
> remove it, sorry for the confusion.
> 
> > > The upstream introduced a breakage on NI-Serial PXI(e)-RS485 devices,
> > > RS-232 variants have no issue. The Linux system can enumerate the
> > > Serial
> > > PXI(e)-RS485 devices, but it broke the R/W operation on the ports.
> > 
> > I can not parse this paragraph either, what do you mean by "The upstream"?
> 
> "The upstream" actually means the commit fdc2de87124f. To be more specific, will
> rephrase it to "The commit fdc2de87124f".
> 
> > > However, the implementation is working on the NI internal Linux RT
> > > kernel but it does not work in the Linux main tree kernel. This is
> > > only affecting NI products, specifically the RS-485 variants.
> > > Reverting the upstream until a proper implementation that can apply to
> > > both NI internal Linux kernel and Linux mainline kernel is figured out.
> > 
> > So this patch really does not work at all?  Can't you just find a simple fix to go on top
> > of it to resolve the issue?  You really want it all ripped out for 5.5 and 5.4.y?
> 
> It does work in NI Linux kernel but not in generic Linux kernel from the main tree, NI's
> Serial team's decision is to have a cleaner implementation so decided to rip out all of it
> for 5.5 and 5.4.y to prevent unexpected breakage.

Ok, fair enough, that's your call.  If you resubmit the patch with the
above changes I'll be glad to queue it up.

thanks,

greg k-h
