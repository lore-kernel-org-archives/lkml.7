Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87901C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 11:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5998C20B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 11:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560339395;
	bh=63nitglJh99FdndHZpzl4MSwEtWHUGXLcVjkbpEnGWA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XcpjL1WaVRnwfsKIydGDmcOCWADxj9Ol/cCNTKA5QSRy6WeW8/LkfhKKPvui17kS8
	 peBYaVZ5eDDrXDSSp4rJzJB6rj7BCbGz3WbDCK6YL2O52Y8cVbGbl8Zk66GeN0gsC6
	 Kat3oTOjF7bECJ7DqGl8J+NcykRByVJejevlTrUQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409075AbfFLLge (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 07:36:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:38578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406901AbfFLLge (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 07:36:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 668D7208CA;
        Wed, 12 Jun 2019 11:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560339393;
        bh=63nitglJh99FdndHZpzl4MSwEtWHUGXLcVjkbpEnGWA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mbgPs45pUip6O6HnBxDKIMsyDdvKRfS2UaBcxIohQZBxPO6/vWrJH/gVL4/TIpmQA
         2Ee0K139VKWQLYJ8Gm4ZNcXKl+DhEhz2I5ZmdqRkL3mHhhEcwxouf1gtW1B9S6qf48
         qFtive3uzZlRzB42jq9UZj5Eemun7UpoTSmMTNEs=
Date:   Wed, 12 Jun 2019 13:36:31 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lkdtm: no need to check return value of debugfs_create
 functions
Message-ID: <20190612113631.GB14793@kroah.com>
References: <20190611183213.GA31645@kroah.com>
 <201906111343.5961D3B@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201906111343.5961D3B@keescook>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 01:43:56PM -0700, Kees Cook wrote:
> On Tue, Jun 11, 2019 at 08:32:13PM +0200, Greg Kroah-Hartman wrote:
> > When calling debugfs functions, there is no need to ever check the
> > return value.  The function can work or not, but the code logic should
> > never do something different based on this.
> > 
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Acked-by: Kees Cook <keescook@chromium.org>

Thanks for the review!

greg k-h
