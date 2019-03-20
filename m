Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA03C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 05:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3960421871
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 05:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553058842;
	bh=fuU2SLtnf9SBoqGPehDltdoaDhsbIzuemeBH6A4mk2s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Q/5jPxrfB0LeZlvPpLdBLj7dY+CwWeJraqwBZadTn1t/1XraGLGPY5IhLxuyMg5DT
	 6UKPrk54i2APEAv2E3GpEOK5VtF0sx3bCWKtdIiItUlehuToE3UDGUd3VHgFxwKvJS
	 GdAJxVV5V2xvw4TOnDEKKZSTx7vb3h8glB0Q7wp0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbfCTFOB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 01:14:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:45730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727716AbfCTFN5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 01:13:57 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36C9C2175B;
        Wed, 20 Mar 2019 05:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553058836;
        bh=fuU2SLtnf9SBoqGPehDltdoaDhsbIzuemeBH6A4mk2s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GBgLtg3XmABe3ooXxpcUVNZm5XluS2s41jAG2xDrY6w4t5AjM2AfSspx8DUvY9lI7
         XYhs8rhfDwsbLXb/+6SoF4bEb3knV150vk1+TSdYzYX4cDd/lIGyHAcG5FMeXEao/7
         RG6rJpiN0WiXbEQu2AF0r5P3wZy+I3opb8oE6vNA=
Date:   Wed, 20 Mar 2019 06:13:53 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Yifeng Li <tomli@tomli.me>
Cc:     Jiri Kosina <trivial@kernel.org>, linux-fbdev@vger.kernel.org,
        devel@driverdev.osuosl.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND][PATCH 0/2] staging: sm750fb: trivial style fixes.
Message-ID: <20190320051353.GB16864@kroah.com>
References: <20190303165532.23727-1-tomli@tomli.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190303165532.23727-1-tomli@tomli.me>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2019 at 12:55:30AM +0800, Yifeng Li wrote:
> Hello.
> 
> >From January to February, there have been two trivial sm750fb patches
> submitted to linux-fbdev, one by me, one by Jin Chen, but both without
> any response. Further, it seems both maintainers, Sudip Mukherjee and
> Teddy Wang, are currently unavailable, getting an "Ack-by" would be
> unfeasible.
> 
> Since they're extremely trivial. Hereby, I picked them up, reworded
> commit message, and now resubmit them as trivial patches, and send them
> to trivial@kernel.org. I hope it could be directly applied by either a
> fbdev, a staging maintainer or by Jiri Kosina.

staging patches need to go to me, as get_maintainers.pl says to send
them.  I'll queue these up in a bit, but no need to bother trivial@ with
staging stuff, otherwise that would be all it did :)

thanks,

greg k-h
