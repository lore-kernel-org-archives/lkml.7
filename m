Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A754BC04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 14:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79F0420684
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 14:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559832714;
	bh=tiANf+pBKCzeD2jjyDmmykgxeSOjgjpksWqL5V9cfjA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vC3HK0aXS42eECT4GkkZxi8dbsVdD54nnhW7LSIcUbhBNA9P29bumyrfTyPZOHfh2
	 gosEhRRz94cJFGky4w1aUx4fO5AaCcHovQBaNDmhF+2U3J3o6hMb+G2V0G8mCZqYH1
	 f7KLR1iB6T7z2oEWHc1OXaJvjnNcw5xuQB2E9tps=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729015AbfFFOvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 10:51:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:54072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727559AbfFFOvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 10:51:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A536B20684;
        Thu,  6 Jun 2019 14:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559832713;
        bh=tiANf+pBKCzeD2jjyDmmykgxeSOjgjpksWqL5V9cfjA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H+o98MPtJVm4/ztFTeOAiDoOihA4Iafo1uzQmpX2CJ4p9c5tRQksuJ+9PHLpC5bgh
         0dpxsTATSuqJV3zHFulHVdPCLEONLguOHdTBWs+3ym0mtETia2urRb18kkZWmk0LRH
         YCqLdiuODD0jrPfNMpu3d9ZNqbVMAmiWGPTnr300=
Date:   Thu, 6 Jun 2019 16:51:50 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tomas Winkler <tomas.winkler@intel.com>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: Re: [char-misc-next 3/7 RESEND] mei: docs: update mei documentation
Message-ID: <20190606145150.GA17421@kroah.com>
References: <20190606133108.26964-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606133108.26964-1-tomas.winkler@intel.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 06, 2019 at 04:31:08PM +0300, Tomas Winkler wrote:
> The mei driver went via multiple changes, update
> the documentation and fix formatting.
> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> ---
>  Documentation/driver-api/mei/mei.rst | 96 ++++++++++++++++++----------
>  1 file changed, 61 insertions(+), 35 deletions(-)

that worked, thanks!

greg k-h
