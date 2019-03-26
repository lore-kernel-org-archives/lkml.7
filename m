Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE4B6C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 11:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FA112075D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 11:48:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731428AbfCZLso (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 07:48:44 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35080 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbfCZLsn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 07:48:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E5051596;
        Tue, 26 Mar 2019 04:48:43 -0700 (PDT)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 07F9F3F59C;
        Tue, 26 Mar 2019 04:48:41 -0700 (PDT)
Date:   Tue, 26 Mar 2019 11:48:36 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Parav Pandit <parav@mellanox.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, michal.lkml@markovi.net,
        davem@davemloft.net, jiri@mellanox.com
Subject: Re: [RFC net-next 1/8] subdev: Introducing subdev bus
Message-ID: <20190326114836.GA4000@e107981-ln.cambridge.arm.com>
References: <1551418672-12822-1-git-send-email-parav@mellanox.com>
 <1551418672-12822-2-git-send-email-parav@mellanox.com>
 <20190301071727.GA8975@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190301071727.GA8975@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2019 at 08:17:27AM +0100, Greg KH wrote:
> On Thu, Feb 28, 2019 at 11:37:45PM -0600, Parav Pandit wrote:
> > Introduce a new subdev bus which holds sub devices created from a
> > primary device. These devices are named as 'subdev'.
> > A subdev is identified similarly to pci device using 16-bit vendor id
> > and device id.
> > Unlike PCI devices, scope of subdev is limited to Linux kernel.
> 
> But these are limited to only PCI devices, right?
> 
> This sounds a lot like that ARM proposal a week or so ago that asked for
> something like this, are you working with them to make sure your
> proposal works for them as well?  (sorry, can't find where that was
> announced, it was online somewhere...)

Thanks for pointing this out and sorry for the delay in chiming in.

Blog post and white paper are available here:

https://community.arm.com/developer/ip-products/processors/b/processors-ip-blog/posts/high-performance-device-virtualization-approach-to-standardization

It would be certainly good to reach a degree of convergence in this
design space, which eventually will be beneficial for the kernel
interfaces required.

Thanks again for pointing this out.

Lorenzo
