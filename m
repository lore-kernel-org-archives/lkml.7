Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7672BC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 16:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40A332173B
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 16:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574181414;
	bh=/SA9QPvK+rLYNCNQenmCwWQSgdcVh5/AQolDX78I4O8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oeH3TjVIDHx2Wy2z4kR15OLW3v54ijf/QN41gQhUarw5BlD+SE/SPweVuR5utEAal
	 F7RzX2/e8OMsBfJbU924EoxviS3+Dlx2Di6RJmOV3rKdmq+LlVvAemT2ce2xBuHktg
	 vd2C8Gfb1ULo4SpmmZekC2NVWMffsA4/o8DzztJE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbfKSQgx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 11:36:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:40160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727299AbfKSQgx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 11:36:53 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1016E208CC;
        Tue, 19 Nov 2019 16:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574181412;
        bh=/SA9QPvK+rLYNCNQenmCwWQSgdcVh5/AQolDX78I4O8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WtQnde7YHwT/YDzIxNthCR9VDDRNWH/aNGTDuTr4jrven8M0IFH7p16dIG025cEjQ
         uSWJ+oZdhCzW6TxJ45X3i6UO5MKoyF49lPAOG0gTM4kkVqv+FXyLZEu6aSGXlqiRqp
         wn8D+quVdpMxtEKqi7gGkjpNQNvYgGQXS2Cj4pgE=
Date:   Tue, 19 Nov 2019 17:36:50 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Lukas Wunner <lukas@wunner.de>, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Thunderbolt change for v5.5 part 2
Message-ID: <20191119163650.GA2031621@kroah.com>
References: <20191119130751.GK11621@lahna.fi.intel.com>
 <20191119160022.GA2027670@kroah.com>
 <20191119162018.GN11621@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191119162018.GN11621@lahna.fi.intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2019 at 06:20:18PM +0200, Mika Westerberg wrote:
> On Tue, Nov 19, 2019 at 05:00:22PM +0100, Greg Kroah-Hartman wrote:
> > On Tue, Nov 19, 2019 at 03:07:51PM +0200, Mika Westerberg wrote:
> > > Hi Greg,
> > > 
> > > There is one more Thunderbolt driver improvement that I would like to
> > > get into v5.5 merge window. Please consider pulling.
> > 
> > Hey, that sounds like the problem my laptop was having!  :)
> > 
> > Should this also go to stable for 5.4.y?
> 
> Yes, I think it makes sense to have it there. Do you want me to mark it
> for stable or you do it?

I've now done it.  I had to rebase/rewrite the description, so watch out
for that if you pull from my tree.

thanks,

greg k-h
