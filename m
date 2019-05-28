Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B42C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 06:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3023D208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 06:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559026083;
	bh=Mi6OVBsUTrJWgDXEsZ7s0skgaVCmudiQHbvjpOqLLQ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZlOfKS2bBb0NmnZGG4by62Lj5XGCCecE+SA3cNsDwdkr5KdjIPBfiYOKSAv7FXCzU
	 //hrpNxMJ4zp/QEEnMvXN2kUyxFGBVIVi/+kWjwZYqJ8NH5Khm2qYmKUFYcJYslPOA
	 LCqusymZwP1I7gdJSTzVsc74ewrl13NkEEtyT+dM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbfE1GsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 02:48:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:54832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726789AbfE1GsB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 02:48:01 -0400
Received: from localhost (unknown [77.241.229.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B40C82070D;
        Tue, 28 May 2019 06:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559026081;
        bh=Mi6OVBsUTrJWgDXEsZ7s0skgaVCmudiQHbvjpOqLLQ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pJImHFfAv9zBeRVlc7yxhNbrELVWHjJ1m+2oxfYFdg5iTwk8z5B14Ou1MWwgJvtJh
         DIFBJkOK8rP5O+kQUjxkDotzsC9XIU71sr4HdVCkZ+anVyZTzZhUXkSs8AyaeCrATh
         YDxSlWfl5BXv1K8qrhvf32Lhzt3oKsRkVYUFPEo8=
Date:   Tue, 28 May 2019 08:47:59 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     laurentiu.tudor@nxp.com, stern@rowland.harvard.edu,
        linux-usb@vger.kernel.org, marex@denx.de, leoyang.li@nxp.com,
        linux-kernel@vger.kernel.org, robin.murphy@arm.com,
        noring@nocrew.org, JuergenUrban@gmx.de
Subject: Re: [PATCH v6 0/5] prerequisites for device reserved local mem rework
Message-ID: <20190528064759.GB2428@kroah.com>
References: <20190522142748.10078-1-laurentiu.tudor@nxp.com>
 <20190523065602.GA11928@lst.de>
 <20190523070755.GA23832@kroah.com>
 <20190528055831.GA11279@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528055831.GA11279@lst.de>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 07:58:31AM +0200, Christoph Hellwig wrote:
> On Thu, May 23, 2019 at 09:07:55AM +0200, Greg KH wrote:
> > I have no objection for you just taking this whole series as-is, no need
> > to worry about merge conflicts with the USB tree, I doubt anything will
> > be touching this area of code anytime soon.
> > 
> > So if you want to take it now, feel free to add:
> > 
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Given that I'll pull it in, shouldn't this be a Reviewed-by or Acked-by?

Good point, I don't usually do this, so I forgot:
	Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
