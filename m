Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D349C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 12:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1B32222D6
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 12:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553429481;
	bh=H8+1qciSs+3AA1akrTbhrU7yQSYNiPo8ngia5DwL7Ms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aRCc9gn00sWnVQE6yf7HOc2dvc4i/Gc1BrLW9PWHgLnOc8M+K+HC2hWfY848PrwqI
	 aZpj7Qd/9HDLuPxl4eK9GEa1jVZHl1gmp/c6Etp6reJNEHRnlK7CbyRHonDcWhu9w+
	 mnoqETjLK1qeyJjGQsilv464Xg5VjGSH3yr7z6jQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728744AbfCXMLT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 08:11:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:46458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726877AbfCXMLT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 08:11:19 -0400
Received: from localhost (unknown [88.128.80.97])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F227222D1;
        Sun, 24 Mar 2019 12:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553429478;
        bh=H8+1qciSs+3AA1akrTbhrU7yQSYNiPo8ngia5DwL7Ms=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s0SW40pTF0/KozIVqQI9b7W/KJAADUpaP+imKXOixH980daH59rFJEJvvaXY20zAW
         kIOWnMMwQ1USmnGCaFY4ZCskXJL1BwPWd5dxiWVf706sD1QiCFhgCIbyh4PbKRs1xV
         irwLdBwD/vqM914efOIk9h0spXblGIhKO4Sj5b3I=
Date:   Sun, 24 Mar 2019 13:11:14 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Bharath Vedartham <linux.bhar@gmail.com>
Cc:     christian@lkamp.de, neil@brown.name, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: ralink-gdma: Convert unsigned to unsigned int
Message-ID: <20190324121114.GA5772@kroah.com>
References: <20190323113444.GA9329@bharath12345-Inspiron-5559>
 <20190324085842.GB21912@kroah.com>
 <20190324093748.GA15691@bharath12345-Inspiron-5559>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190324093748.GA15691@bharath12345-Inspiron-5559>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 24, 2019 at 03:07:48PM +0530, Bharath Vedartham wrote:
> On Sun, Mar 24, 2019 at 09:58:42AM +0100, Greg KH wrote:
> > On Sat, Mar 23, 2019 at 05:04:44PM +0530, Bharath Vedartham wrote:
> > > Fix the checkpatch.pl warning: "Use unsigned int instead of unsigned".
> > > 
> > > Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
> > > ---
> > >  drivers/staging/ralink-gdma/ralink-gdma.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > This patch also does not apply at all :(
> 
> I have been working on linus's branch and not the staging branch. I
> thought that linus's branch would have the latest updates and would be
> the latest branch :( . Is it a problem if I use linus's branch for
> staging drivers?

Yes, if you want to do kernel development, you always need to work off
of the subsystem tree that you are wanting to contribute to, or off of
linux-next.  Development trees can often be 3 months ahead of Linus's
tree depending on the time of the merge window.

The tree should always be listed in the MAINTAINERS file for what one to
use.

hope this helps,

greg k-h
