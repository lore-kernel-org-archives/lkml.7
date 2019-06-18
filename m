Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA3EAC31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 06:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF70320665
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 06:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560840592;
	bh=bIi66gaYK+wfzmGH4HMnydyY0rtpJnZnNJJbf+Jgc8M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0s0rrK+C36XCSEp0lahtCD7j/vrwRRMUqwlUgsyIWb6JqR8jUeSkmz1sUvt51qUfE
	 rWuwWpLiO9d802OV5JnUr8dh14VkM82ko9OjQO8kD18HXXUDS0vEYfYey8PRxild1U
	 oICesuMKGV4AmvDAmCgBXJgpFRhhKVDodhn/dHJ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728518AbfFRGtv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 02:49:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:54828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726985AbfFRGtu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 02:49:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8566F20665;
        Tue, 18 Jun 2019 06:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560840590;
        bh=bIi66gaYK+wfzmGH4HMnydyY0rtpJnZnNJJbf+Jgc8M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iS19t7OMR5MWIylWzImy5y/xOzvn3RG+Euuhzse92eoz9CgEZNO27qb9RzwVMbtC8
         9cQAup9O7sol9MsqrEK5FTGqCq2zjaAtpGv4kY+3d3TtDb50qqIXPxxpH/Zdko0mqn
         B/CN6uj4yFxndJ3rPGrMiwfQyCFRqm47nvpwvwCA=
Date:   Tue, 18 Jun 2019 08:49:47 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        "open list:USB MASS STORAGE DRIVER" <linux-usb@vger.kernel.org>,
        "open list:USB MASS STORAGE DRIVER" 
        <usb-storage@lists.one-eyed-alien.net>
Subject: Re: [PATCH 2/2] usb: storage: scsiglue: Do not skip VPD if
 try_vpd_pages is set
Message-ID: <20190618064947.GB22457@kroah.com>
References: <20190618013146.21961-1-marcos.souza.org@gmail.com>
 <20190618013146.21961-3-marcos.souza.org@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618013146.21961-3-marcos.souza.org@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 10:31:46PM -0300, Marcos Paulo de Souza wrote:
> If BLIST_TRY_VPD_PAGES is set for a device, even for an USB, it should
> be honored, so only set skip_vpd_pages is try_vpd_pages is not set.
> 
> Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
> ---
>  drivers/usb/storage/scsiglue.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Where is patch 1/2 of this series?

confused,

greg k-h
