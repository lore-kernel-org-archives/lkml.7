Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A11C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 12:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04F632186A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 12:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554467546;
	bh=Tv42Q/zIsxgIwqtFLpyMDyzOoahqBUNR6njs6Q0g8jo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=beZlfHMPkmevhX/K5t+NnXz4WTVkeCXh2ews5dDWY2qzn/3x9ewLCRxZ1+34UnMev
	 wxGDCHz3HG1oFHln1S65AA9ja5ECbzsGKr1lMDwGWKmloSxGnaS0QnPfi6s0NHoyGe
	 zkENfrwCuc0uqQ/7toJm52C5noUPz/lM1BCKe6hI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731035AbfDEMcY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 08:32:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:51100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726806AbfDEMcY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 08:32:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E343217D4;
        Fri,  5 Apr 2019 12:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554467543;
        bh=Tv42Q/zIsxgIwqtFLpyMDyzOoahqBUNR6njs6Q0g8jo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PlR/mqoXQGpaIFRLRm6NtwN3trgdQz2m7Zih9FnVgebkuKP8Wg3ab3gCgTytHKlwf
         WSg4oQ9G36Lcuvaz1RySoJ2z+AFRzdGWCuCERibkWSlj4XN1Ub6jYKBOBsfvDUYJtY
         ccx5DGl/WRtT4IXJIyt7EtdQWXvShHvbaP0MHjoY=
Date:   Fri, 5 Apr 2019 14:32:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Chengguang Xu <cgxu519@gmx.com>
Cc:     dan.carpenter@oracle.com, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] chardev: add additional check for minor range
 overlap
Message-ID: <20190405123221.GD2299@kroah.com>
References: <20190405112711.25275-1-cgxu519@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190405112711.25275-1-cgxu519@gmx.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2019 at 07:27:08PM +0800, Chengguang Xu wrote:
> Current overlap checking cannot correctly handle
> a case which is baseminor < existing baseminor &&
> baseminor + minorct > existing baseminor + minorct.
> 
> Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
> ---
> v1->v2:
> - Split fix and cleanup patches.
> - Remove printing minor range in chrdev_show().

What is the difference for v3?  And didn't I already take v2 of this
series?

thanks,

greg k-h
