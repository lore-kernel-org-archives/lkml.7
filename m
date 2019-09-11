Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50DB0C5ACAE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 12:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2261020678
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 12:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568205054;
	bh=EB/xTS3V+NQTSXHN7JsctMIp/7LjYGOKMCwob5l6arU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=18Oq6fIlXXVvVvR7pPBFEA5bybDkVCG1+Gvw+gIuvtIs+wnRJPvn24/DNVXAwCMcs
	 eV9VFlNZbU3ZUFKtR/y3JJVenr13sgwHewuvMhGHl+AWWnt83BsJFixrNGQ3Iv7Epx
	 wUx1UI154QlyGFL4dSCZC1VydAKUTtwri+4/8qX0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbfIKMaw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 08:30:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:34952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728036AbfIKMau (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 08:30:50 -0400
Received: from linux-8ccs (unknown [92.117.136.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06FB221D79;
        Wed, 11 Sep 2019 12:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568205050;
        bh=EB/xTS3V+NQTSXHN7JsctMIp/7LjYGOKMCwob5l6arU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=syfGzBwLR8Fp48PZj07IK8SfCV9cSpvzmms+hBfSzXg/sxIQTVqiUbhYBM0h23Hhr
         eMZdXYSEfvLlHuriU7fgT1Yjlree6tYvs4iapAFdWOC5o3tFK7tjAYdqQm740BExc3
         jH1+6MJ+2mucxSDcn1XauL9HC1b02Oz2C7FbiuLw=
Date:   Wed, 11 Sep 2019 14:30:45 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module: remove unneeded casts in cmp_name()
Message-ID: <20190911123044.GA7837@linux-8ccs>
References: <20190909113902.3096-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190909113902.3096-1-yamada.masahiro@socionext.com>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.61-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Masahiro Yamada [09/09/19 20:39 +0900]:
>You can pass opaque pointers directly.
>
>I also renamed 'va' and 'vb' into more meaningful arguments.
>
>Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Looks good, I'll queue this up in modules-next.

Thanks!

Jessica
