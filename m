Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33615C3A5A6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 15:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE92322DA7
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 15:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567006731;
	bh=f+rLRoraAUBjFPs0/7ieC5J5Gui8/brNIRnSusLXGs4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ucE7Rtlfay7YYKbE71SxcBrdu5mgto6b/Y7j/WjuQQKPjnpuTVvHMsmGM/uGBYcT7
	 owPzzfrsPz+8nMTM2+nHgREn2nGiFWuxHmfoDWO5XkNI3weV/Cz57VE6qQekaPV9Ib
	 jehNx7CcccGw15HKUV7dm5pYI99vn3lT2EbwmETU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfH1Piu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 11:38:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:35502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726457AbfH1Pit (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 11:38:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E6AC208CB;
        Wed, 28 Aug 2019 15:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567006728;
        bh=f+rLRoraAUBjFPs0/7ieC5J5Gui8/brNIRnSusLXGs4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wpEqKwxLnLvtayCH2/6nb+Bul2WCyZ6p+bqIJWln8xsNapaao//FHPUdy8w/Si+bt
         /JfqZgKT5rnWk3WxC5i2Mob2tPOswRHcQ5cVxrC4bZxzYqYXfOKoXp2oxiUiSfDZGU
         rtIKQihKcByiNZqszHGoCq7qtIu/BwOZkeCjkYKc=
Date:   Wed, 28 Aug 2019 17:38:46 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Kamil Debski <kamil@wypas.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jean Delvare <jdelvare@suse.com>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] hwmon: pwm-fan: Use platform_get_irq_optional()
Message-ID: <20190828153846.GC1413@kroah.com>
References: <20190828083411.2496-1-thierry.reding@gmail.com>
 <20190828083411.2496-2-thierry.reding@gmail.com>
 <20190828150522.GA21494@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828150522.GA21494@roeck-us.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 08:05:22AM -0700, Guenter Roeck wrote:
> On Wed, Aug 28, 2019 at 10:34:11AM +0200, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> > 
> > The PWM fan interrupt is optional, so we don't want an error message in
> > the kernel log if it wasn't specified.
> > 
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> 
> Acked-by: Guenter Roeck <linux@roeck-us.net>
> 
> I assume that Greg will pick up this patch.

Will do, thanks.

greg k-h
