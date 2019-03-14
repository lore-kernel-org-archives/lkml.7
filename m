Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CBFC10F06
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 21:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33C922186A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 21:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552600744;
	bh=ZCF+gDLbKs6mubh+LiudrB9PeUo6QXQHpRyDzRsIELE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RSt//l45Z7/sfsFpVXnlW/e/6E5PNySS8qBFRRMQqTR396cntLhtk6X6rOXegpwXe
	 4RuCZWUIWO6yHs2Q0mEVzsRx0AyAFf2ZdQZ86H1dTZNDaMwRSaVXcRQmmuXNRCSyQ9
	 8mcPnK0faKctd1Xcfg3qT/PWRbIugrNBaEP/Guc8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbfCNV7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 17:59:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:53736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726635AbfCNV7D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 17:59:03 -0400
Received: from localhost (unknown [12.27.65.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4462820854;
        Thu, 14 Mar 2019 21:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552600742;
        bh=ZCF+gDLbKs6mubh+LiudrB9PeUo6QXQHpRyDzRsIELE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aSLALUxbqlkkRrFOayQCC8MagBdU5JCwSO7gfWwxo5tBGDgSM9YbXook6NgaAdcyD
         reMmUdrhpnKQgm3H79d9DWA4WPdwixMraA4t+29/1ASpBg3KRR3ytNYN5FTKzd9vSZ
         8JRoDNBSF1eWIivyXDwtrnbvIHOweXoIN+kinoTA=
Date:   Thu, 14 Mar 2019 14:59:01 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Alan J. Wylie" <alan@wylie.me.uk>
Cc:     Alec Ari <neotheuser@gmail.com>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [Regression] Re: Linux 5.0.2
Message-ID: <20190314215901.GA19535@kroah.com>
References: <20190314162756.GA20704@kroah.com>
 <87pnqtkz23.fsf@wylie.me.uk>
 <20190314200709.GA16125@kroah.com>
 <87ftrpkx0d.fsf@wylie.me.uk>
 <20190314215250.GB17893@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190314215250.GB17893@kroah.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2019 at 02:52:50PM -0700, Greg KH wrote:
> On Thu, Mar 14, 2019 at 08:43:14PM +0000, Alan J. Wylie wrote:
> > 
> > (Adding Linus, since his tree is also broken)
> 
> Again, can you try running 'git bisect' to find the offending commit?

Ah, looks like Guenter found it, nevermind...
