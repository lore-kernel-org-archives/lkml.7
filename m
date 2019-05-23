Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D4C4C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 14:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30DC82177E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 14:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558620412;
	bh=yofAkuO3oZzRvvqq5kG2GDeskEKQSmQTEizV/SzhN4A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ii/BFXVTnKVf/IYiqBVntjPsZ04+MUcG+GPyxPDFoAh1Uf2RLg7Zx+Degz2FYdGPJ
	 InhUEvWT+OoIAUxz3eL6sY5OOAxiioMhvXlTJkEsKVIqS6sEesiAapsYab/cJolx3x
	 LPNAHnupTMmGAa5wMpmpWz6M0dBWSUR/Xf9VR26g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730849AbfEWOGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 10:06:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:54052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730323AbfEWOGv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 10:06:51 -0400
Received: from localhost (unknown [104.132.1.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DF0F2133D;
        Thu, 23 May 2019 14:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558620410;
        bh=yofAkuO3oZzRvvqq5kG2GDeskEKQSmQTEizV/SzhN4A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SAfBYJHG3KlTOphWdnGYnm5SsRKuGuX62xESRZY43Oa0iZGdAB7IKn+hXruCGinlJ
         DNxWBhSlCB8l3eMfL64ASJ+TfZfJVPz9jaDQYRF8gQt7kbJmx3Ll/iBvB8+prrww5z
         DdGgGV4rsuzcrWp8VpsLLTuxgy1qCK5IQ0yr+X3Y=
Date:   Thu, 23 May 2019 07:06:49 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: add missing sysfs entries in
 documentation
Message-ID: <20190523140649.GA10954@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190521180606.10461-1-jaegeuk@kernel.org>
 <20190522175035.GB81051@jaegeuk-macbookpro.roam.corp.google.com>
 <14672901-54a2-120f-a2ce-52f7d6fb3008@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14672901-54a2-120f-a2ce-52f7d6fb3008@kernel.org>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/23, Chao Yu wrote:
> On 2019-5-23 1:50, Jaegeuk Kim wrote:
> > This patch cleans up documentation to cover missing sysfs entries.
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> 
> > + reserved_blocks	      This parameter indicates the number of blocks that
> > +			      f2fs reserves internally for root.
> > +
> 
> I mean we can move below entry here.

Ah, I'd like to keep the order defined in sysfs.c.

> 
> current_reserved_blocks	      This shows # of blocks currently reserved.
> 
> > + reserved_blocks	      This shows # of blocks currently reserved.
> 
> Thanks,
