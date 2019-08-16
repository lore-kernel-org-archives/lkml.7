Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C57C3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 10:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D0C92133F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 10:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565951836;
	bh=9emNeGo6hLV8aIOpirPl/lIwJ9cslOuODXUDs0WL2Iw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TDRqYDGptPUZiA7lcX80vHlNC/BhLHNGq8DAdXripIBqtDzY1HIK2MKTdiLgPzVvt
	 c4N3VyOxPYFOzll48IlPC1rlt4OgU8U9ExD8Hj17yNuh5B6rym3QZz6EO8QuGDaDoj
	 v8gdNP8WT9+eBHqUI+pVn9KyVhJ4C9K+8O/Wm3Vg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbfHPKhP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 06:37:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:49386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727034AbfHPKhP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 06:37:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1F57206C2;
        Fri, 16 Aug 2019 10:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565951834;
        bh=9emNeGo6hLV8aIOpirPl/lIwJ9cslOuODXUDs0WL2Iw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QdduGeCw1ucfuENsGseUGlrGs860qVAitOSzn3M6pPRIUwhxK5bUbL1t6GkbFZMS7
         a7n3vfLlrwzDMLYe7OGfa0CBiQJ6Qsm4TJfQwtYef2eiBmXLeWq8O4FoPrCd16zMJF
         eWgeVUgn2q8Db7F/oNgP6oKkLM7u7dhcVT3ajuDo=
Date:   Fri, 16 Aug 2019 12:37:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] soundwire fixes for v5.4-rc5
Message-ID: <20190816103711.GA1419@kroah.com>
References: <20190816095709.GC12733@vkoul-mobl.Dlink>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190816095709.GC12733@vkoul-mobl.Dlink>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 03:27:09PM +0530, Vinod Koul wrote:
> Hi Greg,
> 
> We have couple of fixes queued up, please pull. Some more are in review,
> will send them later.
> These fixes are in linux-next as well.
> 
> The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:
> 
>   Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/soundwire-5.3-rc5

Pulled and pushed out, thanks.

greg k-h
