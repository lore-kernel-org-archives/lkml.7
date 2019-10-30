Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5776DCA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 09:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2885020874
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 09:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572428454;
	bh=v2VPGzmwzTx7M7vLZa8QbUcX7fBOpSfiiK/n0DFbQ1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dbkVs1014aCWQfVWXEFofnYDBxdWAaVx3PF8ZCRSqqjVJnTXyenaZ/Dg0QcH8aM6E
	 9tBvE/zKhaQCrmIibWDieFyQ9r52hxNSCiVGlMq1JuQxfymhoO3A4WoXTMfAJEvjzQ
	 RWYe6boPDVA9GmL1HFgTCscUFsjpqrkChIxizXh4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbfJ3Jkx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 05:40:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:42624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726073AbfJ3Jkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 05:40:52 -0400
Received: from localhost (unknown [91.217.168.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 915FF20874;
        Wed, 30 Oct 2019 09:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572428452;
        bh=v2VPGzmwzTx7M7vLZa8QbUcX7fBOpSfiiK/n0DFbQ1c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=teLC9UHiGJUAq5pRLSA/gRsvVZXir0xuU7lSsK8x1XPPalvs/Q+VDYbUtdzcLY7wM
         ygwqzA3nSYRdk/+yY80K6hhGnEWiR6mQB7J/73ZoQiC0HFt0MbOWJY59vlJ7opU4wh
         6LVGhoNpCaPRt3OosGChWLOgfMObma9ICXp7ANhY=
Date:   Wed, 30 Oct 2019 10:40:49 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
Cc:     outreachy-kernel@googlegroups.com, kim.jamie.bradley@gmail.com,
        nishkadg.linux@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org
Subject: Re: [PATCH v2 1/3] staging: rts5208: Eliminate the use of Camel Case
 in files ms
Message-ID: <20191030094049.GA676265@kroah.com>
References: <20191029145517.630-1-gabrielabittencourt00@gmail.com>
 <20191029145517.630-2-gabrielabittencourt00@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029145517.630-2-gabrielabittencourt00@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2019 at 11:55:15AM -0300, Gabriela Bittencourt wrote:
> Cleans up checks of "Avoid CamelCase" in file ms.h and ms.c
> 
> Signed-off-by: Gabriela Bittencourt <gabrielabittencourt00@gmail.com>

The subject line seems odd, what does "in files ms" mean?

Same for other patches in this series, please clean that up to make it
more informative.

thanks,

greg k-h
