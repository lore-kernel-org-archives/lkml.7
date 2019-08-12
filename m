Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7711C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 14:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B88A8208C2
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 14:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565621058;
	bh=toCXGAQlrQmqPbXzj6Yxdb8DV5WuBICAjIActn4W/3o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=V1S8Hn4MOmjjA2E4rcmqja1UhFXWhaTvdRv09TsnOWFpAZbG6p3ww5yrhNgH0sMPo
	 o/KR/mZ++PXDrIbYp6SGodQXC/dbyOqBZr5MmgSILl/kvvOr5NNoEHZy8kwb8l1cfW
	 WLKgmrlZR7qkcBogglojzRAlPc5hBy43qPRfUVzs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfHLOoR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 10:44:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:57524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726581AbfHLOoR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 10:44:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65C10206A2;
        Mon, 12 Aug 2019 14:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565621056;
        bh=toCXGAQlrQmqPbXzj6Yxdb8DV5WuBICAjIActn4W/3o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZrtXwCYVP8fgAJ9kDPkA3Me2GdYBMgm7VIjH+4qrRFJXyYo/UCaHmj+HqUHuES8bQ
         3Kuor05CCt6Oz8cuwxTH9jHuDUky7tNEqwv9ogMlQQHfGnO5Eqfj/vRCiPWul/5Wgn
         nxg+Wv4MppJoOJcdqMBGlWtZoagMo+NjyH+N4Z4M=
Date:   Mon, 12 Aug 2019 16:44:14 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ioana Ciornei <ioana.ciornei@nxp.com>
Cc:     linux-kernel@vger.kernel.org, andrew@lunn.ch,
        ruxandra.radulescu@nxp.com
Subject: Re: [PATCH 03/10] staging: fsl-dpaa2/ethsw: add line terminator to
 all formats
Message-ID: <20190812144414.GA25512@kroah.com>
References: <1565602758-14434-1-git-send-email-ioana.ciornei@nxp.com>
 <1565602758-14434-4-git-send-email-ioana.ciornei@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565602758-14434-4-git-send-email-ioana.ciornei@nxp.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 12:39:11PM +0300, Ioana Ciornei wrote:
> Add the '\n' line terminator to the string formats missing it.
> 
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> ---
>  drivers/staging/fsl-dpaa2/ethsw/ethsw-ethtool.c |  2 +-
>  drivers/staging/fsl-dpaa2/ethsw/ethsw.c         | 10 +++++-----
>  2 files changed, 6 insertions(+), 6 deletions(-)

Are you sure none of these patches should have a "Reported-by:" tag on
them?  These were all done based on a review, so someone did that
review...

Please fix up the whole series and resend.

thanks,

greg k-h
