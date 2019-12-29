Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E85C2D0C6
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 13:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A346120718
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 13:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577624582;
	bh=MLl8udGdOmbEWmqPwM88Z3x+HeHspaQqIow+p9hDDPc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HzIsK01crHVcL7nIIEKyf+6ZBTagB02pftICt3PQn64hjJSR3auWdcgCgWiGSaq3S
	 1MpxGkKum0njAzwrhQZkZMDWnYwwPUQ1otvK+jSs4+zLH2/xcAiHWQ6u3tpR2+Dv4a
	 eJjO0UXqAR54qqYN4sxtmeeRjzSoELpPeKUSBOrg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbfL2NCs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 08:02:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:60904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726189AbfL2NCr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 08:02:47 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF938207FD;
        Sun, 29 Dec 2019 13:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577624567;
        bh=MLl8udGdOmbEWmqPwM88Z3x+HeHspaQqIow+p9hDDPc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2p/S+ioDdgb2PVa5C/ctTX2J3HIqi+ZadIOR2Pxbz7ObOU8IZvXdRF9pgtp3PqHYh
         86CS02vXDATqUj7fk4G2Pc2WU9/oEzC07Czp3MZVmtmyYeAT3D3t9Rw+GwF+iFFhlH
         qu4hRKi+RVZI1xZAUS1nldY6YskB2H2f9XHoXW54=
Date:   Sun, 29 Dec 2019 14:02:41 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     "Getz, Robin" <Robin.Getz@analog.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Drivers for obsolete devices
Message-ID: <20191229130241.GA2614@kroah.com>
References: <1B3D4336-F843-463A-9E90-5783E0FD6D4A@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1B3D4336-F843-463A-9E90-5783E0FD6D4A@analog.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 28, 2019 at 11:37:24PM +0000, Getz, Robin wrote:
> Greg:
> 
> I was using some of the holidays quiet time to go through the list of
> drivers for ADI peripherals in the kernel, and was trying to note the
> ones that were based on “obsolete” or “not recommended for new design”
> devices.
> 
> I understand supporting old hardware is a goal, but it should be clear
> to users that they shouldn’t be designing in old/obsolete hardware
> just because a driver exists...

That sounds like something the hardware company that makes the chips
does, not selling them to companies for new devices, not something that
the operating system should be worried about :)

Go yell at your salespeople.

good luck!

greg k-h
