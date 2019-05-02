Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE2AC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2B542081C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556810401;
	bh=DCXLPT/Lmteq0fQs4qeKb09v9nP2El2o41xUYEfUfAE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OJOzT+Tjj9jLA89lK7DyRWkK5lmU/33AyEEk7nwxOqc9zRRQg5yQnhEKFrNVK6PdL
	 nPmhTtCJS7W6/K4aoFDf2Gd9W9axr0+EuzxalRQKfigilKGQRs9cRyOH4GhJLRMEhG
	 m6H8JOpZ5tby1Py1OYV6MkuFoO1P0SqcTAM2p8yY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbfEBPUA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 11:20:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:36288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbfEBPT7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 11:19:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4DBF20675;
        Thu,  2 May 2019 15:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556810399;
        bh=DCXLPT/Lmteq0fQs4qeKb09v9nP2El2o41xUYEfUfAE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eTFHm2XSrq5xvLJy1vuMKDBC0Km3GAn3l2XpjzEtyJjPsHjlakYE2AMziEmXGXmQi
         5NtzDSXE0Blzpoj7AFbu2fZ7COd6CvapyvGYtA8GzZCdSKTgQukka6t91NvOg8mky2
         e9miV/ttakCLVq3/dHtOr2jxMe7COvVcK9ut4xa4=
Date:   Thu, 2 May 2019 17:19:56 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
        liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com,
        srinivas.kandagatla@linaro.org
Subject: Re: [PATCH v4 00/22] soundwire: code cleanup
Message-ID: <20190502151956.GA32587@kroah.com>
References: <20190501155745.21806-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190501155745.21806-1-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 01, 2019 at 10:57:23AM -0500, Pierre-Louis Bossart wrote:
> SoundWire support will be provided in Linux with the Sound Open
> Firmware (SOF) on Intel platforms. Before we start adding the missing
> pieces, there are a number of warnings and style issues reported by
> checkpatch, cppcheck and Coccinelle that need to be cleaned-up.

All now queued up, thanks.

greg k-h
