Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E35AC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 19:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CC78240BB
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 19:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559589046;
	bh=bEvD0r2Sjt48o7ToqRmBYPk7t1raS7UySLlJA9KDfRI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WX5VNzcqCVO8M6hwjYokdOnzsKCwlUaC2ZG79XlENtfuFsPV4uy0j9dadZ3D18RN/
	 mIpeVhZcV2bFgitBGT/sQDYpRyeV/53MPPIZhxAP6mB6D2bVUqczHAbt6al02rVQkR
	 i/Q2GaVMi+nOHhItLOxCHSyV5JXUzZ3ujP4AaatA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbfFCTKp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 15:10:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:46318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726136AbfFCTKo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 15:10:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD17E2409E;
        Mon,  3 Jun 2019 19:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559589044;
        bh=bEvD0r2Sjt48o7ToqRmBYPk7t1raS7UySLlJA9KDfRI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hbhGBAvCFK6tM2OvL9Rjf90WdEyNTYYQkv3OQJM4f1JRT+kaUgxrNeWf8khJe3TqY
         mjffvnK1oP2wldomOdciz6GvAp91IHPxxaRrXm6SAJJUKL3OIvWgSlfqG0HUWC+z+y
         6R/HOlA/d1L7woJMf51ldEQg+lIlfZPGvq5GZbzc=
Date:   Mon, 3 Jun 2019 21:10:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org
Subject: Re: [RFC PATCH 46/57] driver: Add variants of driver_find_device()
Message-ID: <20190603191041.GD6487@kroah.com>
References: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
 <1559577023-558-47-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559577023-558-47-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2019 at 04:50:12PM +0100, Suzuki K Poulose wrote:
> Add a wrappers to lookup a device by name for a given driver, by various
> generic properties of a device. This can avoid the proliferation of custom
> match functions throughout the drivers.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  include/linux/device.h | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)

You should put the "here are the new functions that everyone can use"
much earlier in the patch series, otherwise it's hard to dig out.

And if you send just those as an individual series, and they look good,
I can queue them up now so that everyone else can take the individual
patches through their respective trees.

thanks,

greg k-h
