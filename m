Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9786FC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 07:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63DD921994
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 07:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564125364;
	bh=zJWJBjkRpcLJu+URN3e9D3pBiEBb1jjOl6ikK2TAeGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yMzYn9OEyhm6CURbh9ny5YtynUyxur1/H44m3woofKF9+DOGIyHoBRBwuABNxyjLm
	 HckhLPmjPiCdhIodNzmH0qa5WK5xnyl7aMO36Ebu2Lq/fWUyVTBZkXJD2N31pGr5XZ
	 I9KlibpdROTt/ofsjPuoFJJBhJaM5gp2Ro/8FRBw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbfGZHQD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 03:16:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:46906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725864AbfGZHQD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 03:16:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF8B521852;
        Fri, 26 Jul 2019 07:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564125362;
        bh=zJWJBjkRpcLJu+URN3e9D3pBiEBb1jjOl6ikK2TAeGg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v3pIMDcpOMcXWIL1OzO19BJu1NcKbbSZ85bfX8RThqQJaDkq/xkGBBfnsoPenarFI
         0LnqXoLp/D7c1LF3NQN1t/mO1YyDNBtnvxd1zUMCuQUVe5LVdaUVPDBvQr3SNdivtZ
         EM9AWb2nGSBGRz7pH7jFQEVkWmXoYcGz3aZnwhTE=
Date:   Fri, 26 Jul 2019 09:16:00 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     jeyentam <je.yen.tam@ni.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] serial/8250: Add support for NI-Serial PXI/PXIe+485
 devices
Message-ID: <20190726071600.GA12610@kroah.com>
References: <20190726024046.5873-1-je.yen.tam@ni.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190726024046.5873-1-je.yen.tam@ni.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 10:40:46AM +0800, jeyentam wrote:
> Add support for NI-Serial PXIe-RS232, PXI-RS485 and PXIe-RS485 devices.
> 
> Signed-off-by: jeyentam <je.yen.tam@ni.com>

You messed up the From: and signed-off-by: lines this time :(

v4 had it "correct", please fix up and send v6.

thanks,

greg k-h
