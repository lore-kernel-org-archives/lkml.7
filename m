Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92573C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 13:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61419208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 13:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561125012;
	bh=Lmr5nEZa64/acE0s9PGYlSzHVsyNLy1MxjbIMXj9agk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UyvxTxFv6NnKnZ+WGTaou+jr/ns9t0yLndc0XSKi3ch6D77p1H7Ra+XIil33hQtW0
	 iD0GZbCfqmb0LjEzE2V88VwqoaFxn4q38ruDCEVh+EaOk+c0WFXnZWNGKjXvQQmGU1
	 wvphsCWuY8+A+301DuDnUTX5qq+eI0Y3nRiTcBWc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbfFUNuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 09:50:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:54688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbfFUNuK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 09:50:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69123206B7;
        Fri, 21 Jun 2019 13:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561125009;
        bh=Lmr5nEZa64/acE0s9PGYlSzHVsyNLy1MxjbIMXj9agk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q/7vVsu8Op6pp/Fm1q3G8VIy0Pe3ZEtMquDoeyeKmFkxqfVjM2XnwvtnnmOUChYRp
         Hs7zaNCVv58z20v9+sKOF+2+NVw+qTkWQA5xroDpm9PGShLPhFaI5a2yGoGDfAY847
         VQJ/0GCXAcmi1iZIH91hW9LKVZpHGYaF9GaX34ZQ=
Date:   Fri, 21 Jun 2019 15:50:07 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Colin King <colin.king@canonical.com>,
        Arnd Bergmann <arnd@arndb.de>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] lkdtm: remove redundant initialization of ret
Message-ID: <20190621135007.GA27890@kroah.com>
References: <20190614094311.24024-1-colin.king@canonical.com>
 <201906201112.AE06471@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201906201112.AE06471@keescook>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 11:13:32AM -0700, Kees Cook wrote:
> On Fri, Jun 14, 2019 at 10:43:11AM +0100, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > The variable ret is being initialized with the value -EINVAL however
> > this value is never read and ret is being re-assigned later on. Hence
> > the initialization is redundant and can be removed.
> > 
> > Addresses-Coverity: ("Unused value")
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> 
> Thanks!
> 
> Acked-by: Kees Cook <keescook@chromium.org>
> 
> Greg, can you take this please?

Will do, thanks.

greg k-h
