Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E90B7C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 12:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B75F921D81
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 12:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570193528;
	bh=WqlDNg8S8OuSkb9b25DHAZ1G6+OOGdlt/5Jwh2jA7fo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rFrK2EOX1b3dL8Xv8CPBDOjYgleBG7C5V3wbPXO7UZAYyntip6vFJGMD70fHGup4T
	 pdVTNYmbwJIb0mPTFiYQULgnHmM4CBw1G5D98bnFLFzZgAVI2B9+6yp5QfmUCv3wQ5
	 gT1DkVeV0imi3Zc2j7uwp/V7YSPnUd9ymMNhDpn8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387876AbfJDMwI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 08:52:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:32948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387545AbfJDMwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 08:52:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 662DC2070B;
        Fri,  4 Oct 2019 12:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570193525;
        bh=WqlDNg8S8OuSkb9b25DHAZ1G6+OOGdlt/5Jwh2jA7fo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2HO6pFR+mwiaYeowV/EK8iLj1OCuQhfmaLxL5twOFHecZ9MPzzUo7Szwj5ERMCkbf
         lbRoi/5i4NQ2eThQ9uf47iLzQxgffEhozvqfP6Zr2HgeuTiB/HPph+XzdqqHPsqWrx
         xeJEUHcNDCw+8Dpyz9QR6D5l9xlW807icdSlneDs=
Date:   Fri, 4 Oct 2019 14:52:03 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com,
        Paul Thomas <pthomas8589@gmail.com>,
        Jiri Slaby <jslaby@suse.com>,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: uartps: Fix uartps_major handling
Message-ID: <20191004125203.GA583048@kroah.com>
References: <00a269bc15c4f8c0a73c14958c5d7a5d37ff70ce.1568359707.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00a269bc15c4f8c0a73c14958c5d7a5d37ff70ce.1568359707.git.michal.simek@xilinx.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 13, 2019 at 09:28:29AM +0200, Michal Simek wrote:
> There are two parts which should be fixed. The first one is to assigned
> uartps_major at the end of probe() to avoid complicated logic when
> something fails.
> The second part is initialized uartps_major number to 0 when last device is
> removed. This will ensure that on next probe driver will ask for new
> dynamic major number.
> 
> Fixes: c9712e333809 ("serial: uartps: Use the same dynamic major number for all ports")

This is not a valid sha1 in Linus's tree :(

Please fix up and resend.

thanks,

greg k-h
