Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2479C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 13:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CE5320868
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 13:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559826042;
	bh=m2yDFC82OQAP33VYAy3DKxB8YB97pCe7BR47Cxgssho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bmMnjlPLHRR5wz85BxPepfC6FHX1aWGYnbOvzvfnFnGJTu6MFJm7QQj5OWgDVOZyA
	 WcWdnf2foWI4loEzX8I44NSKOZoDxwBDiUBxO7NnoO21vgPDas2otBcoGuZvPCes6T
	 jm4DvvIJAPQaNWrT4WTN1lACQH6Kj/vxObhbC1fs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbfFFNAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 09:00:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:37756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726092AbfFFNAl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 09:00:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6202C2070B;
        Thu,  6 Jun 2019 13:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559826040;
        bh=m2yDFC82OQAP33VYAy3DKxB8YB97pCe7BR47Cxgssho=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=avW8WximDCunfWhQHPz2ZYDLdZoDqou2iz6ZZY1+69gagcpKTgq4RpB3K8tHOWcZA
         S5Cm4u/75EwSNb5o/W/Ba49ao1kEFGSgYEGo9dvb1mhpxAF+2tTeynEIaHGqrAzEVJ
         d64IxDpmMI/7amrK7f7DI4XMq5rIHgbCaVjiPnns=
Date:   Thu, 6 Jun 2019 15:00:38 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Deepak Mishra <linux.dkm@gmail.com>
Cc:     linux-kernel@vger.kernel.org, joe@perches.com,
        Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com
Subject: Re: [PATCH v3 1/4] staging: rtl8712: Fixed CamelCase for
 EepromAddressSize and removed unused variable
Message-ID: <20190606130038.GB1140@kroah.com>
References: <cover.1559615579.git.linux.dkm@gmail.com>
 <23fdeda6601c9a40e90882ea52171ae43079e012.1559615579.git.linux.dkm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23fdeda6601c9a40e90882ea52171ae43079e012.1559615579.git.linux.dkm@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2019 at 09:51:33AM +0530, Deepak Mishra wrote:
> This patch renames CamelCase EepromAddressSizefrom to eeprom_address_size in
> struct _adapter and in related files drv_types.h, rtl871x_eeprom.c, usb_intf.c
> 
> CHECK: Avoid CamelCase: <EepromAddressSize>
> 
> This patch removed unused variable ImrContent from struct _adapter and
> struct pwrctrl_priv and redundant lines from rtl871x_mp_ioctl.c

Your sentances do not read very correctly.  Each one seems unique, so
that means this patch does two different things?

Only do one type of thing per patch, this really should be two different
ones, right?

thanks,

greg k-h
