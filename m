Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18CADC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 16:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2E6220C01
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 16:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407428AbfHIQ2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 12:28:18 -0400
Received: from ms.lwn.net ([45.79.88.28]:48024 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726556AbfHIQ2R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 12:28:17 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 299C3737;
        Fri,  9 Aug 2019 16:28:17 +0000 (UTC)
Date:   Fri, 9 Aug 2019 10:28:16 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Chao Yu <chao@kernel.org>
Cc:     Chao Yu <yuchao0@huawei.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, jaegeuk@kernel.org
Subject: Re: [PATCH] mailmap: add entry for Jaegeuk Kim
Message-ID: <20190809102816.52b3b310@lwn.net>
In-Reply-To: <fd14e8d4-7468-ed3a-a679-6167eac72626@kernel.org>
References: <20190802012135.31419-1-yuchao0@huawei.com>
        <20190802072626.405246e3@lwn.net>
        <fe9cd2bc-76ed-5371-e0c3-b538e7a805e7@kernel.org>
        <fd14e8d4-7468-ed3a-a679-6167eac72626@kernel.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Aug 2019 22:37:41 +0800
Chao Yu <chao@kernel.org> wrote:

> > IMO, when we use git-blame to find out who is response for specified code, w/o
> > mailmap we may just found old obsolete email address in the related commit; even
> > we can search full name for his/her new email address, how can we make sure they
> > are the same person... so anyway, it can help to find last valid/canonical email
> > address of someone.  
> 
> Any thoughts?

I'm not fully convinced that we want to maintain a database of every
developer's email history.  But I did merge this patch a few days ago.

Thanks,

jon
