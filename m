Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64DD0C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 07:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B9F12184B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 07:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558684584;
	bh=bXD6QdoJrj8nxRE6cBPxuj0h6h954JnbAXNYAFv5zSc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XahkQ3ySUtYbXDuvqPwmSaenB8MLw4rFTg/gv5Q/xhzQ1zno16Q3JYKMBk64yBD/p
	 jDez0Q+rYRsVXGItWREIGwsX6nm9kaUFjnnAXmZJ+WEvXtRzpgsgwi0FM7jyoXv6IS
	 Y5cb3yyOqm8F2rDsrj7nWaFtcux9WWLjlIrJZ/kA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389223AbfEXH4X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 03:56:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:38084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389197AbfEXH4W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 03:56:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10FB820879;
        Fri, 24 May 2019 07:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558684581;
        bh=bXD6QdoJrj8nxRE6cBPxuj0h6h954JnbAXNYAFv5zSc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BTsYSM/SGgpLTTjkF6vD8AxB0UHlJeCDNcHJ5G+5lAeOCW8Qq1rUfN2Klr23mO/U6
         KVFBv6BW3E0CMDFZ4n+hURGKqz6STou24e9sTPtf5jOvUGGDWx6WiPt1jQE5su1Ye3
         MlRV7XGBrOQK0CQB6LQmzL22JCCiCv5ZTSQwA/Mw=
Date:   Fri, 24 May 2019 09:56:19 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Stefan Roese <sr@denx.de>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Yegor Yefremov <yegorslists@googlemail.com>,
        Giulio Benetti <giulio.benetti@micronovasrl.com>
Subject: Re: [PATCH 1/2] serial: mctrl_gpio: Check if GPIO property exisits
 before requesting it
Message-ID: <20190524075619.GB31438@kroah.com>
References: <20190522121117.14347-1-sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522121117.14347-1-sr@denx.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 02:11:16PM +0200, Stefan Roese wrote:
> This patch adds a check for the GPIOs property existence, before the
> GPIO is requested. This fixes an issue seen when the 8250 mctrl_gpio
> support is added (2nd patch in this patch series) on x86 platforms using
> ACPI. Please find a details problem description here:
> 
> https://lkml.org/lkml/2016/8/9/357

Can you change this to a lore.kernel.org link instead?

Actually, just put the information in here, no one should ever have to
search somewhere else to determine what happened in a changelog entry.

thanks,

greg k-h
