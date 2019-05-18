Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF1B7C04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 06:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94BF1216C4
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 06:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558161306;
	bh=cbQxEDUMUnjV9fqBk/G2W8OaeEiXUXJBn48F5Pv0RZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=k6Hh3GOPoGjrIoYQl28mqaRIFay3X+Cq9KpwbwYGl9JepO+F8IReSu8+d/VQFscaR
	 /1hRBeq15P1PKRbRWTs8NQ82UNmG8MCgnI7Bxo3N9CG0eqvjmRTpac/TOG8lWEYv8k
	 aDyeJPgbkX7eV2yFKpG8BC1uJ+7/Es/6TXH6Mcxo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728970AbfERGfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 02:35:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:53934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbfERGfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 02:35:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D209D20848;
        Sat, 18 May 2019 06:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558161304;
        bh=cbQxEDUMUnjV9fqBk/G2W8OaeEiXUXJBn48F5Pv0RZE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zt0DxaB5vYVAeOnL6lXWGix86p0MB8+VBuFNEzcxsIgaYPvsMxtfO1YoeL4zRgctT
         H9BIiQcvRlOtTWZBge0I8vp1uzb4eglga8xXeaVbA1Gx/Uz7BxdUZXRjuPggwmqgcU
         nAPWU2uQ1vViLsTVK14KdMKxMqDJnx9FwKfRo1EQ=
Date:   Sat, 18 May 2019 08:35:01 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Liming Sun <lsun@mellanox.com>
Cc:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Vadim Pasternak <vadimp@mellanox.com>,
        David Woods <dwoods@mellanox.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: [PATCH v5 2/2] platform/mellanox/mlxbf-bootctl: Add the ABI
 definitions
Message-ID: <20190518063501.GA26163@kroah.com>
References: <0b74e9ad12360b56bc0a3c2ca972798c424f2610.1548790896.git.lsun@mellanox.com>
 <1558115345-32476-2-git-send-email-lsun@mellanox.com>
 <20190517175926.GA24535@kroah.com>
 <DB6PR05MB32235A6F891E438131471CE2A10B0@DB6PR05MB3223.eurprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB6PR05MB32235A6F891E438131471CE2A10B0@DB6PR05MB3223.eurprd05.prod.outlook.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2019 at 08:36:53PM +0000, Liming Sun wrote:
> Thanks Greg for the comments!  Please see my response inline.
> 
> Regards,
> - Liming
> 
> > -----Original Message-----
> > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Sent: Friday, May 17, 2019 1:59 PM
> > To: Liming Sun <lsun@mellanox.com>
> > Cc: Andy Shevchenko <andy@infradead.org>; Darren Hart <dvhart@infradead.org>; Vadim Pasternak <vadimp@mellanox.com>; David
> > Woods <dwoods@mellanox.com>; platform-driver-x86@vger.kernel.org; linux-kernel@vger.kernel.org; David S. Miller
> > <davem@davemloft.net>; Mauro Carvalho Chehab <mchehab+samsung@kernel.org>; Jonathan Cameron
> > <Jonathan.Cameron@huawei.com>; Nicolas Ferre <nicolas.ferre@microchip.com>; Paul E. McKenney <paulmck@linux.ibm.com>
> > Subject: Re: [PATCH v5 2/2] platform/mellanox/mlxbf-bootctl: Add the ABI definitions
> > 
> > On Fri, May 17, 2019 at 01:49:05PM -0400, Liming Sun wrote:
> > > This commit adds the ABI definitions exposed to userspace for
> > > the platform/mellanox/mlxbf-bootctl driver.
> > >
> > > Reviewed-by: Vadim Pasternak <vadimp@mellanox.com>
> > > Signed-off-by: Liming Sun <lsun@mellanox.com>
> > > ---
> > >  .../ABI/testing/sysfs-platform-mellanox-bootctl    | 58 ++++++++++++++++++++++
> > >  MAINTAINERS                                        |  1 +
> > >  2 files changed, 59 insertions(+)
> > >  create mode 100644 Documentation/ABI/testing/sysfs-platform-mellanox-bootctl
> > >
> > > diff --git a/Documentation/ABI/testing/sysfs-platform-mellanox-bootctl b/Documentation/ABI/testing/sysfs-platform-mellanox-
> > bootctl
> > > new file mode 100644
> > > index 0000000..19a14db
> > > --- /dev/null
> > > +++ b/Documentation/ABI/testing/sysfs-platform-mellanox-bootctl
> > > @@ -0,0 +1,58 @@
> > > +What:		/sys/bus/platform/drivers/mlxbf-bootctl/lifecycle_state
> > > +Date:		May 2019
> > > +KernelVersion:	5.3
> > > +Contact:	"Liming Sun <lsun@mellanox.com>"
> > > +Description:
> > > +		The Life-cycle state of the SoC, which could be one of the
> > > +		following values.
> > > +		  Production - Production state and can be updated to secure
> > > +		  GA Secured - Secure chip and not able to change state
> > > +		  GA Non-Secured - Non-Secure chip and not able to change state
> > > +		  RMA - Return Merchandise Authorization
> > 
> > A "driver" does not have a lifecycle state, a "device" does.
> > 
> > You are putting all of these attributes in the wrong place.  Put them on
> > your device please, not the driver.  driver-specific attributes are
> > _VERY_ rare, and only for things that can modify/show for all devices
> > attached to that driver.
> 
> This driver is running on the ARM processor of the SoC. The 'device' is
> the SoC itself. That's to say, there is only one device here attached to
> the driver and the driver state will also be the device state.

That might be true today, but maybe not tomorrow :)

Anyway, again, this is device state, not driver state.

> This interface has been used by user-space applications for a couple of
> releases. It'll be great if it could stay in such way for compatibility. Please
> advise if this is strongly preferred to move them under devices.

So this is code that is already in the tree, and is just now being
documented?  What .c file(s) is this referring to?

As for "comptability", sysfs is made such that if a file is not present,
userspace should be able to survive, that is why it is
one-value-per-file.  What tool is using this, and where is the source
for it?

thanks,

greg k-h
