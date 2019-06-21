Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53578C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 23:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27E3E2084E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 23:50:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbfFUXuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 19:50:12 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:38118 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbfFUXuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 19:50:12 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id C0A2423EC0;
        Fri, 21 Jun 2019 19:50:09 -0400 (EDT)
Date:   Sat, 22 Jun 2019 09:50:24 +1000 (AEST)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
cc:     Douglas Gilbert <dgilbert@interlog.com>,
        Bart Van Assche <bvanassche@acm.org>,
        James Bottomley <jejb@linux.ibm.com>,
        Martin Petersen <martin.petersen@oracle.com>,
        SCSI <linux-scsi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v1] scsi: Don't select SCSI_PROC_FS by default
In-Reply-To: <5d9d0851-f864-6d78-7e7d-9d018bea5704@free.fr>
Message-ID: <alpine.LNX.2.21.1906220920320.180@nippy.intranet>
References: <2de15293-b9be-4d41-bc67-a69417f27f7a@free.fr> <621306ee-7ab6-9cd2-e934-94b3d6d731fc@acm.org> <fb2d2e74-6725-4bf2-cf6c-63c0a2a10f4f@interlog.com> <alpine.LNX.2.21.1906181107240.287@nippy.intranet> <017cf3cf-ecd8-19c2-3bbd-7e7c28042c3c@free.fr>
 <f8339103-5b45-b72d-9f87-fd4dd7b3081e@interlog.com> <f1f98ab0-399a-6c12-073d-ee8ad47d5588@free.fr> <48912bc0-8c79-408d-7ed2-c127b99b8bcc@interlog.com> <e04e14b7-e1ee-c0c1-9e6d-2628d2c873a9@free.fr> <alpine.LNX.2.21.1906210942560.131@nippy.intranet>
 <5d9d0851-f864-6d78-7e7d-9d018bea5704@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jun 2019, Marc Gonzalez wrote:

> On 21/06/2019 01:43, Finn Thain wrote:
> 
> > On Thu, 20 Jun 2019, Marc Gonzalez wrote:
> > 
> >> How likely is it that distro kernels would *not* enable CHR_DEV_SG? 
> >> (Distros tend to enable everything, and then some.)
> > 
> > How likely is it that embedded developers would *not* disable 
> > CHR_DEV_SG? They tend to disable everything, and then enable only what 
> > they need.
> 
> I don't see where you're going with this line of reasoning?
> 

Exactly. This sort of reasoning goes nowhere.

> Below is my current (as of next-20190612) defconfig.
> 
> Notice the options marked as "not set". These are options that are 
> enabled by default (and which I've disabled).
> 
> Everyone thinks "their" option is critical (and it is, *to them*) but, 
> in fact, few really are -- universally. 

The relevant policy is documented in 
Documentation/kbuild/kconfig-language.txt.

If there are useful generalizations about the choice of defaults for 
Kconfig symbols (or changing those defaults) that are not documented then 
they probably should be.

-- 
