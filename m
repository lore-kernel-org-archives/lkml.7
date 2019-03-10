Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF26C10F03
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 16:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E056E206DF
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 16:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="liVvnSOo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfCJQwt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 12:52:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40504 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbfCJQws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 12:52:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=g6cQ4474axMeYuY5lZKzZp4LO3T/ZhhWOowPQNrMNIc=; b=liVvnSOo+iwdffZaWJhlQgCFi
        jbymRpENKohvZSJshDUZq3qBEVkVv7Ge5reDjW79Tpsqg+0O07Bv69usFI6FI6sc76sT1Z+z25i+t
        yXDAgsYiB0VJ6epxJUNZ2UKGZgAanthvUuYU6BNLoaUKfEoSyXZFFks0+15/GCqHGXdU0qadlgypO
        mLl6gepVcQvdeud+7ufhF++bgIcJ1Rwf/83LURdLuzFqIzvHZnczSwwNTI3qbapU+eYZuv8S34P2q
        PL7AVbB5mX5TmCWLYuZUp2m4tAtMbfnIKt+TIfseIqtYXLT0wzqDlm0duh7oLlmlzpi1bHI3NBBJO
        5ToKXmgEA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h31gu-0002bj-55; Sun, 10 Mar 2019 16:52:48 +0000
Subject: Re: PROBLEM: kernel build fails with CONFIG_BPFILTER_UMH=y
To:     "rwarsow@gmx.de" <rwarsow@gmx.de>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <44e23aba-bb8b-e7a0-a10c-e475210a17f7@gmx.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <b3d3ee0b-0fc9-4598-cdb6-dfea631da89c@infradead.org>
Date:   Sun, 10 Mar 2019 09:52:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <44e23aba-bb8b-e7a0-a10c-e475210a17f7@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[add other mailing lists]

On 3/10/19 9:47 AM, rwarsow@gmx.de wrote:
> hallo
> 
> care to look into this:
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=202681
> 
> 


-- 
~Randy
