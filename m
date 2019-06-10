Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A64C31E41
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 15:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EB7D2173B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 15:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560182317;
	bh=sZXqk7pAEtJoem/AucfWWlCwFu9S6F9epByGnk5rihQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RFMCGe8uSsiAvnQ+7yIOtVUY3dMS2m66z/N/8/j/w3yB7+TUxNdY12DPaEnp2MN+i
	 cRGbfTcsljjg6NfAlyE7cVTMCCe/MuYhoryg/w8zlnAuVEo5AVfHK7B4U+gfgZdnoA
	 WFGnJaNpvoJx2DZSN0hWDRPAG/nSiaiVabFy2Ryk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391371AbfFJP6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 11:58:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:41890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389356AbfFJP6g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 11:58:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32C8621726;
        Mon, 10 Jun 2019 15:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560182315;
        bh=sZXqk7pAEtJoem/AucfWWlCwFu9S6F9epByGnk5rihQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aKCZ9rZ/h0YbjIY7TbMLRxuu2fEG9VRJt8DmrlVWjTPhjEbKoy4tZu3qGDrLnVptV
         kuoaf/CBKqDmhYo/49KCQSG2bDe0nvViJsTJdzxPa+gswNDMfUkFrow5zzk/GNUpKV
         vAcfkhVkHiwP8Fi/3dVYjouZRluvTKs2xKWsXjNE=
Date:   Mon, 10 Jun 2019 17:58:33 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Deepak Mishra <linux.dkm@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Larry.Finger@lwfinger.net,
        florian.c.schilhabel@googlemail.com, straube.linux@gmail.com
Subject: Re: [PATCH v5 5/6] staging: rtl8712: Renamed CamelCase wkFilterRxFF0
 to wk_filter_rx_ff0
Message-ID: <20190610155833.GA25769@kroah.com>
References: <cover.1560081971.git.linux.dkm@gmail.com>
 <565142f388450d86b9457e4d40ca8dac9051d4b6.1560081972.git.linux.dkm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <565142f388450d86b9457e4d40ca8dac9051d4b6.1560081972.git.linux.dkm@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 09, 2019 at 06:01:44PM +0530, Deepak Mishra wrote:
> This patch renames CamelCase variable wkFilterRxFF0 to wk_filter_rx_ff0 in
> drv_types.h, rtl871x_xmit.c and xmit_linux.c
> 
> This was reported by checkpatch.pl
> 
> Signed-off-by: Deepak Mishra <linux.dkm@gmail.com>
> ---
>  drivers/staging/rtl8712/drv_types.h    | 2 +-
>  drivers/staging/rtl8712/rtl871x_xmit.c | 2 +-
>  drivers/staging/rtl8712/xmit_linux.c   | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

This patch, and the next one, did not apply to my tree :(

Can you rebase and resend the remaining ones?

thanks,

greg k-h
