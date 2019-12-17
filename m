Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA3FC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 13:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BF6C20733
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 13:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576589848;
	bh=NPVLdtzDEmDrIxPSb+Hk1MytZK2QGLyQ5/dukrqS4GI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WPFGiTqg3D4SF1lSFftQwX3tceJCFhBlnaXvC0czMtcaSTYSj0EiX2m2qp+BRWgvb
	 j9cqv/8Qqvf54e46n/zxwVu0ofDHrLYuNHgmW4EyjRrLnKfR+fbOZv05SuT5Gj9xfh
	 WfJkcQgp9fVYPcPZDHuWp4eLimS+3oPb91iqSEpg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbfLQNh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 08:37:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:38104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726164AbfLQNh0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 08:37:26 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E17D6206B7;
        Tue, 17 Dec 2019 13:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576589846;
        bh=NPVLdtzDEmDrIxPSb+Hk1MytZK2QGLyQ5/dukrqS4GI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fMIPzDax0f4MXDQ/hA5SpOphLe0Q3Q3HxJx1KJNITkb+0qRj/Ase8Q6AKmuqHfaRm
         CMTf9zhcZBfFiO+K62rbFhfWmh6qSi0dHpUcCqAetjbubPRyyFh35BO+p8SPErEvQy
         clP750hlBOwdQG1eXkZ88LM3ANSpj0dj9hhtXX/k=
Date:   Tue, 17 Dec 2019 14:37:24 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dave Kim <david.kim@ncipher.com>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        Tim Magee <tim.magee@ncipher.com>
Subject: Re: [PATCH 1/1] drivers: misc: Add support for nCipher HSM devices
Message-ID: <20191217133724.GD3362771@kroah.com>
References: <20191217132244.14768-1-david.kim@ncipher.com>
 <20191217132244.14768-2-david.kim@ncipher.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217132244.14768-2-david.kim@ncipher.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 01:22:44PM +0000, Dave Kim wrote:
> +#ifndef PCI_VENDOR_ID_INTEL
> +#define PCI_VENDOR_ID_INTEL			0x8086
> +#endif

This is already defined by the kernel, no need to do so again.

thanks,

greg k-h
