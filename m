Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42347C3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 08:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1930C20870
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 08:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566721713;
	bh=LyyuVacUgp0QI5+McQ246IhEd+pkcxaG0db7hV8Z3xk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ghfb0LyTS27HEU6tdajwaNf8TvUVuTL5nyHH3hqYM3DEnJIWUr3TxNOEliufw4qRe
	 FBamZO/xZUEQsBw9SinOySZMqJXDF1HNCmmQI3tpZ5GpFF8snhsQl3AKvVWZWG62Gz
	 szynmQwyj5VlqlvUMtSSGSIsm5143ZJ9H7sNwKqA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbfHYI20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 04:28:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:51372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725995AbfHYI20 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 04:28:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3361720870;
        Sun, 25 Aug 2019 08:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566721705;
        bh=LyyuVacUgp0QI5+McQ246IhEd+pkcxaG0db7hV8Z3xk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CCw9OWnIGjaeTxR+9Xx5LnDUbjfhCIuB5F5w9FFfzf7SuOwbxMJ+4cVtc8wI7S20T
         SE5DNlPlCPNTNlIWUq2enwtwY657PeQaQ3WdZmv8nS3QGrG3LfvDIjqra5BizdLoT0
         nXqLqWTXPCfJDdbzEu081JoguF9/gZIHRaiJDkrU=
Date:   Sun, 25 Aug 2019 10:28:23 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Stephen Brennan <stephen@brennan.io>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8192u: Fix indentation
Message-ID: <20190825082823.GA4301@kroah.com>
References: <20190822175228.3419-1-stephen@brennan.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822175228.3419-1-stephen@brennan.io>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2019 at 10:52:28AM -0700, Stephen Brennan wrote:
> Checkpatch reports WARNING:SUSPECT_CODE_INDENT in several places. Fix
> this by aligning code properly with tabs.
> 
> Signed-off-by: Stephen Brennan <stephen@brennan.io>
> ---
>  .../rtl8192u/ieee80211/ieee80211_crypt_ccmp.c |   2 +-
>  .../staging/rtl8192u/ieee80211/ieee80211_rx.c | 112 +++++++++---------
>  .../staging/rtl8192u/ieee80211/ieee80211_tx.c |  18 +--
>  .../staging/rtl8192u/ieee80211/ieee80211_wx.c |   8 +-
>  drivers/staging/rtl8192u/r819xU_firmware.c    |   2 +-
>  5 files changed, 71 insertions(+), 71 deletions(-)

This patch does not apply to my tree.  Please redo it against the latest
staging-next branch of the staging.git tree and resend.

thanks,

greg k-h
