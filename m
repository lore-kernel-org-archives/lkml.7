Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B33B1C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 12:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83A712186A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 12:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554467571;
	bh=84+e49qfpIylAjSyF1r9JWmeh5PjwXW4nKe4P0pFARM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Z7aoJhCAtdcnYr5k/rfj3pQlXpDzwCwL6KHPHlqqdK5yOUyEk5uKtheGcEeu8XhHE
	 aOThaOOST3n/QedrYh7o9skAogayN04T2YYMjwFXOraslNuhNd1QAwSKdr7jlRcTBA
	 QJUFnOaxn53cVFMqCUFaRMJjqoEOEROO8O/DMuTo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730870AbfDEMcu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 08:32:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:51578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729820AbfDEMcu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 08:32:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D9C6217D4;
        Fri,  5 Apr 2019 12:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554467569;
        bh=84+e49qfpIylAjSyF1r9JWmeh5PjwXW4nKe4P0pFARM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WJcNkx6zcahkIhahxvORy0Q6XfXvN4Ww3paNsgl/DZnCEW2I5CTKru/ZGmoYns/Vu
         ixFcyGHqjrYyCtLtkwC0VcfH/2VVC42pm4o9XVI3ps+LVhCOUDunN6qOww5ClGAo0m
         IlxlTccN3vNwOiHJ9+8JC25+ytt7OOEacxZpqhho=
Date:   Fri, 5 Apr 2019 14:32:46 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Chengguang Xu <cgxu519@gmx.com>
Cc:     dan.carpenter@oracle.com, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] chardev: code cleanup for
 __register_chrdev_region()
Message-ID: <20190405123246.GE2299@kroah.com>
References: <20190405112711.25275-1-cgxu519@gmx.com>
 <20190405112711.25275-3-cgxu519@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190405112711.25275-3-cgxu519@gmx.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2019 at 07:27:10PM +0800, Chengguang Xu wrote:
> It's just code cleanup, not functional change.
> 
> Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
> ---
> v1->v2:
> - Split fix and cleanup patches.
> - Remove printing minor range in chrdev_show().
> 
> v2->v3:
> - Set variable ret to '-EBUSY' before checking minor range overlap.

Can you just send the follow-on patch that does the v3 change as I have
already taken your series.

thanks,

greg k-h
