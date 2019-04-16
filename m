Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C59AEC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9789820868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555415321;
	bh=bSHjAC7YDa94OsJOO9d57vDyeGhJHCpU31Ru+EEnwQY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QpgSROnWFJFBDj7wgD4fO2gvvsoimDQzcUTFvGDaU3OcX8hqoWlnrpRzxelDLTgNI
	 IZEUajvkbEOwsXDlT7yjXfcfIaiGzChCMB8dKQGPyODah3Z7aCucQQp7oQBzogXnb/
	 fcIk1WnblPtSmjM3BcszlZ+QMQ5TQh6AZNUwmSDM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729225AbfDPLsk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 07:48:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:58108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727355AbfDPLsj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 07:48:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDB6320821;
        Tue, 16 Apr 2019 11:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555415319;
        bh=bSHjAC7YDa94OsJOO9d57vDyeGhJHCpU31Ru+EEnwQY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X+BJlyhQPMVZmDGtyvi5QXKpDRAKMZ7bqdpkx/a794yVHsOHKpmmVwbTBEABuqMmA
         4eiA/J3pyF/jUbucK84RN7z/88NVVaIv1hfnMPTOkqgzzywKtQgqGQKNladZsNWkHv
         knIhMxjiwwtASQuJfPxQEcjDv7oPFhJaLvEacFMQ=
Date:   Tue, 16 Apr 2019 13:32:42 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Caio Salvador Rohwedder <caiosalvador96@gmail.com>
Cc:     devel@driverdev.osuosl.org, lkcamp@lists.libreplanetbr.org,
        linux-kernel@vger.kernel.org, johnfwhitmore@gmail.com
Subject: Re: [PATCH v2] staging: rtl8192u: ieee80211: fix checkpatch space
 errors
Message-ID: <20190416113242.GA30256@kroah.com>
References: <20190406220222.20331-1-caiosalvador96@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190406220222.20331-1-caiosalvador96@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 06, 2019 at 07:02:23PM -0300, Caio Salvador Rohwedder wrote:
> Fix checkpatch space coding style errors, warnings and checks on rtl819x_TSProc.c
> 
> Signed-off-by: Caio Salvador Rohwedder <caiosalvador96@gmail.com>
> ---
> Changes in v2:
> 	- change commit message
> 	- fix remaining space errors
> ---
>  .../rtl8192u/ieee80211/rtl819x_TSProc.c       | 112 +++++++++---------
>  1 file changed, 56 insertions(+), 56 deletions(-)

This patch did not apply at all to my tree :(
