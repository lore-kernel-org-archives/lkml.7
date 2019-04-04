Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26468C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 13:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 021F521734
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 13:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730002AbfDDNaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 09:30:18 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:60439 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727398AbfDDNaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 09:30:15 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 08B578043B; Thu,  4 Apr 2019 15:30:05 +0200 (CEST)
Date:   Thu, 4 Apr 2019 15:22:30 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     robh+dt@kernel.org, jacek.anaszewski@gmail.com,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH 2/5] leds: TI LMU: Add common code for TI LMU devices
Message-ID: <20190404132230.GB6190@xo-6d-61-c0.localdomain>
References: <20190325142403.30447-1-dmurphy@ti.com>
 <20190325142403.30447-3-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325142403.30447-3-dmurphy@ti.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2019-03-25 09:24:00, Dan Murphy wrote:
> Create a TI LMU common framework for TI LMU devices that share
> common features.
> 
> Currently the runtime ramp and brightness setting have
> been identified as common features with common register settings.
> 
> This work is derived from Milo Kims TI LMU MFD code.
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>

Acked-by: Pavel Machek <pavel@ucw.cz>
