Return-Path: <SRS0=BIzH=UB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A728BC28CC5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 06:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7330E24F6A
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 06:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559456493;
	bh=vhBKwCxwAgvEEdMJpzjBTxKgav4wSMPXDFR+K4mBLm8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pwH/wX1OdvrEjv7fAgL0SU/d16nes/ueFc+Q724xcLao6+GtFZYmmbURimbFeAJIf
	 /kjD8F0bfc9cUuuS/PNUUnR35y+DxE8KIM59Yskh2lIebAl4NdaY+cHUa52ObFz+ip
	 vFRtq2erDytWepmQdWgPpvtuw4aGNvExkZpvFIKI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726136AbfFBGUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 02:20:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:40900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725871AbfFBGUv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 02:20:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01E2124F6A;
        Sun,  2 Jun 2019 06:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559456450;
        bh=vhBKwCxwAgvEEdMJpzjBTxKgav4wSMPXDFR+K4mBLm8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FnYNb4YAy5jvKsdSs5P79OE5CNT9qtCcKA9hBr4W+qmUs/+UeTKaMRZXENw8A0i0A
         JSle85ss5/U+eNgxkyQm3cWV/9g40GbDz5IwpPjOiqLPB/s/kVvowVK9XUyexmfEyI
         qDnI5XqhBBogc5exi+uc5HR4B0VsjA5HArGN3xis=
Date:   Sun, 2 Jun 2019 08:20:47 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Deepak Mishra <linux.dkm@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Larry.Finger@lwfinger.net,
        florian.c.schilhabel@googlemail.com, himadri18.07@gmail.com,
        straube.linux@gmail.com
Subject: Re: [PATCH 0/8] staging: rtl8712: Fixed CamelCase in struct _adapter
 from drv_types.h
Message-ID: <20190602062047.GA12076@kroah.com>
References: <cover.1559412149.git.linux.dkm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1559412149.git.linux.dkm@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 02, 2019 at 12:13:34AM +0530, Deepak Mishra wrote:
> This patchset fixes CamelCase checks in struct _adapter in drv_types.h
> and in files where struct _adapter is used by renaming the variables
> without camel case. 
> 
> These check were reported by checkpatch.pl
>   
> Deepak Mishra (8):
>   staging: rtl8712: Fixed CamelCase in struct _adapter from drv_types.h
>   staging: rtl8712: Fixed CamelCase in struct _adapter from drv_types.h
>   staging: rtl8712: Fixed CamelCase in struct _adapter from drv_types.h
>   staging: rtl8712: Fixed CamelCase in struct _adapter from drv_types.h
>   staging: rtl8712: Fixed CamelCase in struct _adapter from drv_types.h
>   staging: rtl8712: Fixed CamelCase in struct _adapter from drv_types.h
>   staging: rtl8712: Fixed CamelCase in struct _adapter from drv_types.h
>   staging: rtl8712: Fixed CamelCase in struct _adapter from drv_types.h

All of these patches had the same subject line, yet did diffferent
things, that's not ok :(

Please fix this series up to have unique subject lines and resend.

thanks,

greg k-h
