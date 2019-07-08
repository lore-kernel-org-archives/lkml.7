Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82EF9C606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 14:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58441216B7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 14:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562595411;
	bh=sleWZ930yek+6NmAYJ3H6wphPKORK+DVGdr0bMUX9QA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ENyM8V4qzSlU3PK0JTt0h2zb7hjXI61icgV95spSlgQegcsE98Z6zn9eBaRqnxSF/
	 yBF3PRsA684/nSQkspnjmJq8BU73sQAxikxZPFppKHCm73VIrgw/njwdCdJyxwt4Ht
	 BBWhe+kC9KW5EJS4yJMRKQg0CdhSaTyRlXHj7D7E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731761AbfGHOQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 10:16:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:43296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728596AbfGHOQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 10:16:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E24821670;
        Mon,  8 Jul 2019 14:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562595409;
        bh=sleWZ930yek+6NmAYJ3H6wphPKORK+DVGdr0bMUX9QA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SlYjvlQ3DDyLrqPaKG+7BopCNv5julgpEUBDaHP2FpJcx5Od+o7LryVrCnsdNKGWg
         jIoYBjlV/qQ4ghftjEbNBFPzcQhbPCw+7WXDEbwJP4np7F/1jhBN6XhHBd0z6Q7YVV
         XdtSpn1H3vb0NsL8dyPyW8H3HUQWt7AP94Ua72WU=
Date:   Mon, 8 Jul 2019 16:16:46 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai
Subject: Re: [PATCH] habanalabs: remove write_open_cnt property
Message-ID: <20190708141646.GA24852@kroah.com>
References: <20190708141141.15300-1-oded.gabbay@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190708141141.15300-1-oded.gabbay@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 08, 2019 at 05:11:41PM +0300, Oded Gabbay wrote:
> This property has attempted to show the number of open file descriptors on
> the device. This was a stupid and futile attempt so remove this property
> completely.
> 
> Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
