Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE6C1C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 23:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3A7920674
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 23:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573599856;
	bh=ulumy6jaRowMqKe2WImM8RXemRc2G5E/BwfFfPJzRJc=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=YmKKarDt3JJiyvEG2fMW8ishFNxSetBoQfwTZNPAbLSB5F7AMtH5UYQbkEpRwlkL1
	 QS9QmbjFtxllia1wN5wH9+4Gbz6DH+8HOicbyzskrMwcfe5uxKYdgTglAHPgbOJGvI
	 ylroEXve+//lymwOnS5fdrOTYgtwCiec3dsWEi/o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfKLXEP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 18:04:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:35354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726910AbfKLXEP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 18:04:15 -0500
Received: from localhost (unknown [8.46.76.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A554020674;
        Tue, 12 Nov 2019 23:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573599854;
        bh=ulumy6jaRowMqKe2WImM8RXemRc2G5E/BwfFfPJzRJc=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=1ENLFoOPOa8e2UQmpt3efX5qWWH1K0t/L0HcP74raKcGkMZwRXGpP/RHpLyrWB6ZO
         ukAcn9s3VAGxcrBOqhauwwxVRzVxaUtZNEQKU+FgfSRz3c7sRUJBuWLpvKHrYf6gV2
         ebppaR1vQTeQ00TgVfev5SwkQdPl4UDmmtMArnA4=
Date:   Wed, 13 Nov 2019 00:04:05 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: Re: [PATCH 5/9] staging: rtl8723bs: Add necessary braces
Message-ID: <20191112230405.GA1904763@kroah.com>
References: <cover.1573577309.git.jarias.linux@gmail.com>
 <9653d1c5ea7ebd7b4137edea4f5eef74ea65703b.1573577309.git.jarias.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9653d1c5ea7ebd7b4137edea4f5eef74ea65703b.1573577309.git.jarias.linux@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 11:54:32AM -0500, Javier F. Arias wrote:
> This patchset adds braces when they should be used on all arms of
> the statement.
> Issue found by Checkpatch.
> 
> Signed-off-by: Javier F. Arias <jarias.linux@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_xmit.c | 31 +++++++++++++++--------
>  1 file changed, 20 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_xmit.c b/drivers/staging/rtl8723bs/core/rtw_xmit.c
> index fdb585ff5925..42bd5d8362fa 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_xmit.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_xmit.c
> @@ -370,8 +370,9 @@ static void update_attrib_vcs_info(struct adapter *padapter, struct xmit_frame *
>  	/* 		Other fragments are protected by previous fragment. */
>  	/* 		So we only need to check the length of first fragment. */
>  	if (pmlmeext->cur_wireless_mode < WIRELESS_11_24N  || padapter->registrypriv.wifi_spec) {
> -		if (sz > padapter->registrypriv.rts_thresh)
> +		if (sz > padapter->registrypriv.rts_thresh) {
>  			pattrib->vcs_mode = RTS_CTS;
> +		}
>  		else {

The } should be on the same line as the "else {"

thanks,

greg k-h
