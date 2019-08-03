Return-Path: <SRS0=Iotr=V7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D9AC433FF
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 16:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 540FD2075C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 16:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564848605;
	bh=ODawwwsyBVPy0OVWuEwfhGEAUxZNG56pqH6fdbLM8/k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=X6g8yp4XQdtmH1OiBfRzSIwoXU1e2xWZSI0lUKSlz8hd5fSF4hsOiMj049DDjX0W9
	 nnmNXdDgVB7/CKrwQxUag4ZopMrbzpv1edbtYPfTRipmaRdmow14t7+TCXL2erxC8V
	 1eCydD5PjMD1I8Ktv1d9RQxOC/dw0CYFMVfR7TPg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387920AbfHCQKA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Aug 2019 12:10:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:47942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387464AbfHCQKA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 12:10:00 -0400
Received: from X250.getinternet.no (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93EFB2075C;
        Sat,  3 Aug 2019 16:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564848599;
        bh=ODawwwsyBVPy0OVWuEwfhGEAUxZNG56pqH6fdbLM8/k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JVidYy3KNME2+E/+uMV7O1BF/f0/S0twyiru3cgFcS6TkWeds+PcTQ0wpVXYtVR3d
         zzF0BPcY0t4+G6Glx9b5M4NnAHlUXapRmcTO8jQos7Pl06SYXS+SxQLEOmCHw6WqT5
         y4OgDfkbLEKtQOgvs+HX2PN26wNB2Dz620lDYYq8=
Date:   Sat, 3 Aug 2019 18:09:53 +0200
From:   Shawn Guo <shawnguo@kernel.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Chris Healy <cphealy@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Peter Chen <peter.chen@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: imx: Drop imx_anatop_init()
Message-ID: <20190803160952.GW8870@X250.getinternet.no>
References: <20190731180131.8597-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731180131.8597-1-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 11:01:31AM -0700, Andrey Smirnov wrote:
> With commit b5bbe2235361 ("usb: phy: mxs: Disable external charger
> detect in mxs_phy_hw_init()") in tree all of the necessary charger
> setup is done by the USB PHY driver which covers all of the affected
> i.MX6 SoCs.
> 
> NOTE: Imx_anatop_init() was also called for i.MX7D, but looking at its
> datasheet it appears to have a different USB PHY IP block, so
> executing i.MX6 charger disable configuration seems unnecessary.
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Peter Chen <peter.chen@nxp.com>
> Cc: linux-imx@nxp.com
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org

Applied, thanks.
