Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F53C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 13:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7675B20869
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 13:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575034365;
	bh=Cfq5ZK607ycaOvEhaKgpcopj1W/rScjfdVMbA32VOQE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ilYPYn8N/dIQnR68LylBlqfqd0izK8/fW/Va1MWSsj4m+PD0HGrhS27xbN53iGY9J
	 ZJ3Ut7J4Fqg2OiV8+RCU7BHx2bg3zmWxVAUN+tIgUJV3WfqC/afrfr0MX8ff7K3NY0
	 izCtt/H9eIYUePfZ7tiOxXDFUlEYYmFcW2e5fUZo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbfK2Nco (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 08:32:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:42408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726763AbfK2Nco (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 08:32:44 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E7E120869;
        Fri, 29 Nov 2019 13:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575034362;
        bh=Cfq5ZK607ycaOvEhaKgpcopj1W/rScjfdVMbA32VOQE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qxbH69XdPxZ6BmRWFheMW6GbMmQrJuQVVyBywQW6+vy9oPSY56QlEkRbjXj7Pl7sL
         fcjRYOQtfFNNJrx1WXcnwDPbbwATOJm6cWrNpFFCZ39I2FuC4jIGocdJkeyUcLdlx/
         m5LlegVXCkmbuJEgkd/EMRltQFjv9KkOo3gjvg48=
Date:   Fri, 29 Nov 2019 14:32:39 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH 0/4] staging: gigaset: fix crashes on probe
Message-ID: <20191129133239.GA3703941@kroah.com>
References: <20191129101753.9721-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191129101753.9721-1-johan@kernel.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 29, 2019 at 11:17:49AM +0100, Johan Hovold wrote:
> Syzbot has been reporting a GPF on probe in the gigaset ISDN driver,
> which have since been moved to staging.
> 
> The first patch fixes that issue, and the next one fixes a second crash
> found during testing.
> 
> The third patch addresses a benign warning in USB core which syzbot is
> bound to report once the crashes have been fixed.
> 
> And while I hate playing checkpatch games, the final patch addresses a
> checkpatch warning introduced on purpose by the third patch.

I'll take these after 5.5-rc1, but then it is time to just delete all of
drivers/staging/isdn/ from my tree, so don't worry about them after that
:)

thanks,

greg k-h
