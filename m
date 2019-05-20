Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12ECEC04E87
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 06:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7F0C20815
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 06:03:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730303AbfETGDD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 02:03:03 -0400
Received: from verein.lst.de ([213.95.11.211]:49827 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbfETGDC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 02:03:02 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id DF07C68B20; Mon, 20 May 2019 08:02:39 +0200 (CEST)
Date:   Mon, 20 May 2019 08:02:39 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] PM: sleep: Add kerneldoc comments to some functions
Message-ID: <20190520060239.GA31977@lst.de>
References: <11319987.O9o76ZdvQC@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11319987.O9o76ZdvQC@kreacher>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  
> +/**
> + * pm_suspend_via_firmware - Check if platform firmware will suspend the system.
> + *
> + * To be called during system-wide power management transitions to sleep states.
> + *
> + * Return 'true' if the platform firmware is going to be invoked at the end of
> + * the system-wide power management transition in progress in order to complete
> + * it.
> + */

Ok, so this only returns true if the firmware gets invoked for this
particular transition we are currently in.  That was my main confusion
here.  Also any chance to add an example of why this might matter?
