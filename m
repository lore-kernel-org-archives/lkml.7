Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C78AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 07:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD14921841
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 07:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553066631;
	bh=DStMdlvTwBeCuUOdxfhcXb+D6wDT2kxMz4VsHLYkZSM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EawNrnUf8V7VpFIpqWTHxNi2lcTlj1hH3p2Wf7o9JhPvo915XaKMak6fXnun4Qcd/
	 VL9e6Sw1qOKTzuHBr29EBHXwV0WXy8+VX7xlEKTdfKqYWIMMkDu2H5B/nAVup3SFug
	 WgY+nk2JF4IWLVUc06qZvz9rscmu4eHUdn96eaHU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbfCTHXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 03:23:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:53602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726303AbfCTHXu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 03:23:50 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E4F521841;
        Wed, 20 Mar 2019 07:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553066629;
        bh=DStMdlvTwBeCuUOdxfhcXb+D6wDT2kxMz4VsHLYkZSM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u8v3BRsvmSv5jBsDcPZLoM8KdpOGJvsoREP20ndnqyLZ0vhxfjQgu2gboYQOl3sKY
         8hQc3219ndOphqBTw+kBDJb/wMsyC/VjGaTDWtEj1s1+xt/BHw6CCE1IOBLlysvAu1
         4ojuXqPhaHB0JPKD24EQ5erbL4a9efcr169sEkx8=
Date:   Wed, 20 Mar 2019 08:23:47 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, Nathan Chancellor <natechancellor@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: rtlwifi: Fix potential NULL pointer
 dereference of kzalloc
Message-ID: <20190320072347.GA2647@kroah.com>
References: <20190319201509.16252-1-pakki001@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190319201509.16252-1-pakki001@umn.edu>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 03:15:08PM -0500, Aditya Pakki wrote:
> phydm.internal is allocated using kzalloc which is used multiple
> times without a check for NULL pointer. This patch avoids such a
> scenario.
> 
> --
> v1: Patch collision with different things, fix as per Greg
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>

signed-off-by has to be above the -- line.  Please fix.

thanks,

greg k-h
