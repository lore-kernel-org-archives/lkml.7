Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8733FCA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 09:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FF512087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 09:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572428547;
	bh=HRKTHKDlz6q42RvW+t8ISuLjVtmTQEedPBjCfZxFMFk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XVLzmKlp22GIHf67DEHeijjWYQ7Xt59aiX6sBlB5CPYGZaOD1XFN97v7lDoCzwpDE
	 FyS4yylTc32nnGeKJILwrJIQyhkENxfXRor23PusWv0UXog68WsCpWVPTNsBRHeZ5J
	 ktruFPF/upbsEIuXiQRuZLoCtNwxX6k/EPKMFp4M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbfJ3Jm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 05:42:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:43096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726032AbfJ3JmZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 05:42:25 -0400
Received: from localhost (unknown [91.217.168.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 850DC20874;
        Wed, 30 Oct 2019 09:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572428545;
        bh=HRKTHKDlz6q42RvW+t8ISuLjVtmTQEedPBjCfZxFMFk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x6HHOqoRviik/ApDaPm4bGwA5mS2lTczgm2Qlb0ZZA/Ej4kXYF2ER60/eyBijYI5Y
         ma1okAxGnpSYoRQqvbb+i1D0nmJzqNP+2A+CYHik8jiaYt0XDyYiXIuSHvD0bvch25
         YJUX+NVPhh8Jl3NzGYLAek5LtBDXIsDHvgG7UqaQ=
Date:   Wed, 30 Oct 2019 10:42:22 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Roi Martin <jroi.martin@gmail.com>
Cc:     valdis.kletnieks@vt.edu, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] staging: exfat: replace kmalloc with kmalloc_array
Message-ID: <20191030094222.GA678631@kroah.com>
References: <20191030010328.10203-1-jroi.martin@gmail.com>
 <20191030010328.10203-7-jroi.martin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030010328.10203-7-jroi.martin@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2019 at 02:03:28AM +0100, Roi Martin wrote:
> Replace expressions of the form:
> 	kmalloc(count * size, GFP_KERNEL);
> With:
> 	kmalloc_array(count, size, GFP_KERNEL);
> 
> Signed-off-by: Roi Martin <jroi.martin@gmail.com>
> ---
>  drivers/staging/exfat/exfat_core.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

This patch failed to apply.  Please fix it up and resend it as a new
version.

thanks,

greg k-h
