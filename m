Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF2AC04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 13:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1FB320684
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 13:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559826998;
	bh=TRXhSdXKig3VGjlO45Outp2cNhHODyIbhNjwqGZ0bNI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DP+nzHwPgUv877AV42/8enCJxFBthOU6hSkLFenEsF94x9CDXQkV3oUL5oDE4jBrl
	 alavpg4Gbs2gYS+/Nr5/0e6h5t7UxuGOuWSBFiGbPs8pQmpKDXQwjUwTiZBSIF7w14
	 AambmzlDT6UCvn4ZCR4w5l/l8Rs5zHludg387ilk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbfFFNQg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 09:16:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:47518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726092AbfFFNQg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 09:16:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54AF620684;
        Thu,  6 Jun 2019 13:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559826995;
        bh=TRXhSdXKig3VGjlO45Outp2cNhHODyIbhNjwqGZ0bNI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DRZF1Um0aGw7FODFhChM6tXuk6buZOijpRa75Ec5gti62p1Z0l5nC4TqsoYyo3ZKK
         KWYZQcYrvGQglvWanFzkBQbsL/LAZUC71m3M9DXGjTU6v2yRACOi0b6g6/RzIJ3ytX
         p+Cdr0+1khSh6Z/26f78mSsfa25KheP5JVdrknrk=
Date:   Thu, 6 Jun 2019 15:16:33 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tomas Winkler <tomas.winkler@intel.com>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: Re: [char-misc-next 3/7] mei: docs: update mei documentation
Message-ID: <20190606131633.GA6083@kroah.com>
References: <20190603091406.28915-1-tomas.winkler@intel.com>
 <20190603091406.28915-4-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190603091406.28915-4-tomas.winkler@intel.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2019 at 12:14:02PM +0300, Tomas Winkler wrote:
> The mei driver went via multiple changes, update
> the documentation and fix formatting.
> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> ---
>  Documentation/driver-api/mei/mei.rst | 96 ++++++++++++++++++----------
>  1 file changed, 61 insertions(+), 35 deletions(-)

This patch is corrupted and can not apply.  Did you try to edit it by
hand after generating it?

Can you resend it alone?

thanks,

greg k-h
