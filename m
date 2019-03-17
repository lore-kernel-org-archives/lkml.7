Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7838CC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 11:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37D7A21019
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 11:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552820866;
	bh=USQHz+aGdC7+BK/EcwOa3BSyY3OIxuAZlio0lygrY7w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=B2Iml7Wu9rc1RDZmZpsB1Y5+5avx0Ppde1yFlgVTmGuBbOEVJOiVmvLoALVoZaaxG
	 9fbGg6U0+V1FDcHH/MqU9gLrjMx8uR8WvTXzUTsfbdzicdgjTATw54uIW3dC9ziloC
	 VvqA6EU7ZUMaOuWQsXDiuMPjqoKLusrduKEV27kg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbfCQLHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 07:07:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:52898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726763AbfCQLHo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 07:07:44 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9526921019;
        Sun, 17 Mar 2019 11:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552820864;
        bh=USQHz+aGdC7+BK/EcwOa3BSyY3OIxuAZlio0lygrY7w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bLiZkgf3I1lY9PpwTmUwUXg71t8e76sxqXKc9JFq9x/kC8KBf2TWBOtJ0zTDk0NKs
         6eHGmrrkpcd8Xf0tBEPZpd32OPapodes9UUWIN5YS/D6RzLs849GCNwR2SC0gCNY1l
         qUvXzhk1fhCKgU7jPpnbcYDOTN5ePVWEER+TxXZs=
Date:   Sun, 17 Mar 2019 12:07:40 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Guilherme Tadashi Maeoka <gui.maeoka@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] Fix several coding style errors
Message-ID: <20190317110740.GA4123@kroah.com>
References: <20190309183047.10781-1-gui.maeoka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190309183047.10781-1-gui.maeoka@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 09, 2019 at 03:30:42PM -0300, Guilherme Tadashi Maeoka wrote:
> Fix space around operators, pointer definition, constant on the right
> side, assignment outside of if condition and else to follow close brace
> at staging: rtl8723bs: os_dep.
> 
> Guilherme Tadashi Maeoka (5):
>   Staging: rtl8723bs: os_dep: Fix assignment in if condition
>   Staging: rtl8723bs: os_dep: Fix space required coding style
>   Staging: rtl8723bs: os_dep: Fix else to follow close brace
>   Staging: rtl8723bs: os_dep: Fix space in pointer definition
>   Staging: rtl8723bs: os_dep: Set constant on right side
> 
>  .../staging/rtl8723bs/os_dep/osdep_service.c  | 52 +++++++++----------
>  1 file changed, 26 insertions(+), 26 deletions(-)

The 0/X email should also say the subsystem and driver that the series
modifies.

thanks,

greg k-h
