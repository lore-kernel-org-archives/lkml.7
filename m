Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C63C48BD3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75D2A208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561596225;
	bh=cfCOpi8KsQzsG8pIhY5vKFm9xYtkwvLnUKwVstIjLbU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LkNFsbrimBIEw/RMUKJ/J3D1of8Q/cwXkNNoBU59B6iWFq/ghDToWJJPMDK0WFI4+
	 rzIg3XuGFhGoSIN2MKSLfIIE2cSEubS3l0tUiywyT5NVPmNKoJ7tVWCmQvZ4PV8QiC
	 e8dqEawFsNC/JLnUlV+vMMEjyQ7AEF5Nbe2t97hU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729914AbfF0Ano (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 20:43:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:47452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729887AbfF0An3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 20:43:29 -0400
Received: from localhost (unknown [104.132.1.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 664F4216E3;
        Thu, 27 Jun 2019 00:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561596208;
        bh=cfCOpi8KsQzsG8pIhY5vKFm9xYtkwvLnUKwVstIjLbU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZxLM1pZtWw3JP1mhbpjvsyHwqEeWoayVJ0zvyaXInB8J3qrVntyVUbckL4tYWyarZ
         PRu/eXYmti7j69c+jKkxxGsoieAxUAaUPMWGPrU72owfIQ/0Rf4vQ52sbexEx8umKO
         lKtP+Nivz5GJUS/xvtoR+cUAhkSK56fUkfQ/GrRE=
Date:   Wed, 26 Jun 2019 17:43:27 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the f2fs tree
Message-ID: <20190627004327.GA43824@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190627095522.457b7511@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190627095522.457b7511@canb.auug.org.au>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/27, Stephen Rothwell wrote:
> Hi Jaegeuk,
> 
> Commit
> 
>   dfc06c892ea3 ("f2fs: fix is_idle() check for discard type")
> 
> is missing a Signed-off-by from its committer.

Thanks. I've added and uploaded it.

> 
> -- 
> Cheers,
> Stephen Rothwell


