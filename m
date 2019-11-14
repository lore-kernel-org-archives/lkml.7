Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A89E9C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 06:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86F6A20718
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 06:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573714198;
	bh=Jw0/r2BepvoGiF5aXcailECk8aLZ2syKaUsT4mtsAHs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vxx/brWamkgrapmhG5SqN4D46oWdbHy/qNWCBUWpykJBAnkmspTBiRy/9wOd5JBjq
	 txS/L7sjaQvKoCrIEAFLdrpgbKYmrvKC8u7vqXgYwZsbxRq8RE7GtkU20R/6ahB/8I
	 RJ93lhu2U0rkTc2/cxhdUrosXJHY53czX58DIuRc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbfKNGt5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 01:49:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:39062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbfKNGt4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 01:49:56 -0500
Received: from localhost (unknown [124.219.31.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D051F20718;
        Thu, 14 Nov 2019 06:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573714196;
        bh=Jw0/r2BepvoGiF5aXcailECk8aLZ2syKaUsT4mtsAHs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wY9Aytx6ToNW/crQcr0pjbebpNYYnFqsLvw52JQrlBxSVk44Jep1meRFpB0WhB/nv
         xVXJBdn6aSRdmYfK5o4T3ykDB+N+8RLdtu0VWsih8a95KsPHjYirCiogy0shblq1W3
         E1aCVRY184ab9QVwZUCgJNQULCjjs+7XeqWsKIAQ=
Date:   Thu, 14 Nov 2019 14:49:53 +0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL 0/2] stm class/intel_th: Updates for v5.5
Message-ID: <20191114064953.GA550521@kroah.com>
References: <20191114064201.43089-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191114064201.43089-1-alexander.shishkin@linux.intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 08:41:59AM +0200, Alexander Shishkin wrote:
> Hi Greg,
> 
> This is really small, but I'm including a signed tag anyway. These are
> a bugfix and a documentation update. The fix is for a bug in v4.20, and
> given that it's late -rc7, it makes more sense to me to queue it for the
> merge window, but if you think otherwise, as Linus mentioned the
> possibility of an -rc8, it's also good. Stable CC'd on the fix.
> 
> The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:
> 
>   Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/ash/stm.git tags/stm-intel_th-for-greg-20191114
> 
> for you to fetch changes up to a5e809f25f41a84b31e17ac9422fb191e2495503:

Looks good, I've taken these as patches, thanks.

greg k-h
