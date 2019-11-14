Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B05FC43215
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 04:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41E05206F0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 04:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573707520;
	bh=Fd1b+rYUESVNJ8lzpuKxKsrWmMvEjnh2hBaOkjbvHzA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HG3J7blM9tYOmBHgeFtAESiQobHt4wfTQi+PW/GAM/q9lPljhVycBaZbnxhAnfbym
	 1acuVtQbQWFxQVimcr5j7tbQDQcBPdZ3Lq3q4Q5yfBKeZyvGmr0qb2+OmC0cjcnXfo
	 PO8gqEHIHVjop8YICN7agvrhX5dUlYtzfpNlTPBU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbfKNE6j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 23:58:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:40150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726557AbfKNE6i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 23:58:38 -0500
Received: from localhost (unknown [223.226.110.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E803206EF;
        Thu, 14 Nov 2019 04:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573707518;
        bh=Fd1b+rYUESVNJ8lzpuKxKsrWmMvEjnh2hBaOkjbvHzA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OagkJEyxcElj+s5uTZAoBD9igV+zTZt9A07difmejLDyapMnPsItTqk3hJzfTJcv4
         p901RqVmPxOmrLE9QOOTcHuRZxJYAHQQ8ZtkdnlLXl4q1RmykRccnRf12L4yRwTkZR
         cSuD8uELftWJ5JvNrmCnNE6zKfiixktn0p26cIF0=
Date:   Thu, 14 Nov 2019 10:28:34 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: iop-adma: clean up an indentation issue
Message-ID: <20191114045834.GK952516@vkoul-mobl>
References: <20191112191143.282814-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112191143.282814-1-colin.king@canonical.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-11-19, 19:11, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a statement that is indented too deeply, remove
> the extraneous indentation.

Applied, thanks

-- 
~Vinod
