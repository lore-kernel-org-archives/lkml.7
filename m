Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BBB9C31E54
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 13:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 044F02080A
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 13:52:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbfFPNwc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 09:52:32 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:41014 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbfFPNwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 09:52:31 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 659889E8FF9;
        Sun, 16 Jun 2019 14:52:29 +0100 (BST)
Date:   Sun, 16 Jun 2019 14:52:27 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Patrick Havelange <patrick.havelange@essensium.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan.Cameron@huawei.com
Subject: Re: [PATCH 1/1] MAINTAINERS: add counter/ftm-quaddec driver entry
Message-ID: <20190616145227.6198d6c1@archlinux>
In-Reply-To: <20190612150221.GA6631@icarus>
References: <20190612145223.8402-1-patrick.havelange@essensium.com>
        <20190612150221.GA6631@icarus>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jun 2019 00:02:21 +0900
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> On Wed, Jun 12, 2019 at 04:52:23PM +0200, Patrick Havelange wrote:
> > Adding myself as maintainer for this driver
> > 
> > Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
> > ---
> >  MAINTAINERS | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 57f496cff999..6671854098d6 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -6218,6 +6218,14 @@ M:	Philip Kelleher <pjk1939@linux.ibm.com>
> >  S:	Maintained
> >  F:	drivers/block/rsxx/
> >  
> > +FLEXTIMER FTM-QUADDEC DRIVER
> > +M:	Patrick Havelange <patrick.havelange@essensium.com>
> > +L:	linux-iio@vger.kernel.org
> > +S:	Maintained
> > +F:	Documentation/ABI/testing/sysfs-bus-counter-ftm-quadddec
> > +F:	Documentation/devicetree/bindings/counter/ftm-quaddec.txt
> > +F:	drivers/counter/ftm-quaddec.c
> > +
> >  FLOPPY DRIVER
> >  M:	Jiri Kosina <jikos@kernel.org>
> >  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jikos/floppy.git
> > -- 
> > 2.19.1  
> 
> Thank you, this should take care of those files.
> 
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>

Given I took the last patch related to this driver, I'll pick this
one up as well.   William, let me know on each series whether you want
me to.  I would imagine that sometimes you'll have a enough going on
you'll want to do something more efficient, but whilst it's individual
patches this works fine.

Applied to the togreg branch of iio.git and pushed out as testing.

Thanks,

Jonathan


