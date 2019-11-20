Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32289C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 20:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 068702088F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 20:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574283597;
	bh=aoWgyxRhafDxDPmg+aC2iuXY5EUTf778ue28Q7SjB/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CHad5e7fgKmq50K9vOcKi6/5sApVGwATgeZ44iPkbIc+c4XjkMY5ed5lNPFU5ww2d
	 WnPO12bPUIxLELb4SUU9GHaTEsaN5iPFm9laU1tEeBM+epSI5NLs7OLF0MdviLv1xH
	 9qATN1y9Cwa9F5g1z9KUgtMOynPBDH51ji2tHUyw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfKTU74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 15:59:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:58190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725306AbfKTU7z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 15:59:55 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8BB32075E;
        Wed, 20 Nov 2019 20:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574283595;
        bh=aoWgyxRhafDxDPmg+aC2iuXY5EUTf778ue28Q7SjB/8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OEQx394opefmEwWrkM+Uc5hj2T3ROcbC7fzhZtN+YKxhd4ldbwp4ZSSIuW+9Zqb8p
         VjfOp+vzZRL+17Qb0E7v3xjmUNZGBKwREfUjIQKOZ0C4CmTU6J/mtnKFTYqoZFMEJs
         ZFwu5qO5MAr9LVdXmzf1Cck9Edu+Cak9i3/Qr7IQ=
Date:   Wed, 20 Nov 2019 21:59:52 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Evgeniy Polyakov <zbr@ioremap.net>
Cc:     Angelo Dureghello <angelo.dureghello@timesys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] w1: new driver. DS2430 chip
Message-ID: <20191120205952.GA3113184@kroah.com>
References: <20191019204015.61474-1-angelo.dureghello@timesys.com>
 <49814061574280989@sas2-7fadb031fd9b.qloud-c.yandex.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49814061574280989@sas2-7fadb031fd9b.qloud-c.yandex.net>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 11:16:29PM +0300, Evgeniy Polyakov wrote:
> Hi Angelo, Greg
> 
> 19.10.2019, 23:38, "Angelo Dureghello" <angelo.dureghello@timesys.com>:
> > add support for ds2430, 1 page, 256bit (32bytes) eeprom
> > (family 0x14).
> >
> > Signed-off-by: Angelo Dureghello <angelo.dureghello@timesys.com>
> 
> Looks good to me.
> Greg, please pull it into your tree.
> 
> Acked-by: Evgeniy Polyakov <zbr@ioremap.net>

I don't have a copy of this anywhere :(

Angelo, can you resend it and cc: me and add evgeniy's ack?

thanks,

greg k-h
