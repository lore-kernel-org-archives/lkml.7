Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0100AC00454
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 14:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAE3820836
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 14:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575988952;
	bh=fo4Ig2GCo7sLhJYHhhz6hQKFMZeSD+SQc5ZCTQZ7Fn0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WpBVK3AgaGp2q4z7G5b3/BGrkD0KPzbqcm3mKm04HMm2ar/tnP4CiTpoyIWinCWhX
	 3toY+nmxGSnRL3VJDCxQhtPXn/QVCynRzTlARr6//8mVVa0hhB47FX9d1yW83KZXXq
	 +nuL39ihsZPuVnKPQx95D5PjD9het8tcKTHykWZM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727642AbfLJOmb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 09:42:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:55034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727627AbfLJOma (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 09:42:30 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CD3720828;
        Tue, 10 Dec 2019 14:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575988950;
        bh=fo4Ig2GCo7sLhJYHhhz6hQKFMZeSD+SQc5ZCTQZ7Fn0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QINYYuE12L3diIi6rGVdGnWyLYKBuPqFUs0uVK/eE9fFntivkXgtFqNJz79s/Amzo
         CP/k3h66us6DwLCAGXrdMFcLzNJRccUJEh/gm/Oqlu80FRmNIB7jVrVGh1LZbvZM4V
         E05DjsWMZiF+6Gcm61gok6fQPnYpSfyei6rLgvQc=
Date:   Tue, 10 Dec 2019 15:42:28 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     devel@driverdev.osuosl.org, alsa-devel@alsa-project.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Scott Branden <sbranden@broadcom.com>,
        Ray Jui <rjui@broadcom.com>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH for-5.6 0/4] staging: ALSA PCM API updates
Message-ID: <20191210144228.GA3937513@kroah.com>
References: <20191210141356.18074-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210141356.18074-1-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 03:13:52PM +0100, Takashi Iwai wrote:
> Hi,
> 
> this is a patch set to adapt the latest ALSA PCM API to staging
> drivers.  Basically these are merely cleanups, as shown in diffstat,
> and there should be no functional changes.
> 
> As the corresponding ALSA PCM API change is found in 5.5-rc1, please
> apply these on 5.5-rc1 or later.  Or if you prefer, I can merge them
> through sound tree, too.  Let me know.

Because of some future most driver changes that will be happening
(hopefully soon), I'll just take all of these in the staging tree now,
thanks!

greg k-h
