Return-Path: <SRS0=HQPa=VE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A587C5B578
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 03:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDD4D2063F
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 03:03:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727203AbfGGDCw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 23:02:52 -0400
Received: from namei.org ([65.99.196.166]:33944 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727115AbfGGDCw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 23:02:52 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x6732cmU004446;
        Sun, 7 Jul 2019 03:02:38 GMT
Date:   Sat, 6 Jul 2019 20:02:38 -0700 (PDT)
From:   James Morris <jmorris@namei.org>
To:     Carmeli Tamir <carmeli.tamir@gmail.com>
cc:     serge@hallyn.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] security/commoncap: Use xattr security prefix len
In-Reply-To: <20190706150738.4619-1-carmeli.tamir@gmail.com>
Message-ID: <alpine.LRH.2.21.1907062002050.4231@namei.org>
References: <20190706150738.4619-1-carmeli.tamir@gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Jul 2019, Carmeli Tamir wrote:

> Using the existing defined XATTR_SECURITY_PREFIX_LEN instead of
> sizeof(XATTR_SECURITY_PREFIX) - 1. Pretty simple cleanup.
> 
> Signed-off-by: Carmeli Tamir <carmeli.tamir@gmail.com>

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-lsm

Thanks! 

-- 
James Morris
<jmorris@namei.org>

