Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59FFBC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21E5020652
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbfCGPus (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 10:50:48 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39852 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbfCGPus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 10:50:48 -0500
Received: by mail-qt1-f193.google.com with SMTP id o6so17583464qtk.6;
        Thu, 07 Mar 2019 07:50:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jjresbL271MtvsCuFuXYFr/fyGJfd81Ak8kg2xEYgsE=;
        b=e3qHtQC8SMea0lAYsOIbZYDiD91exQOTxmRUB92kdUFVm+DufhrgYJuERPeAIxKNBZ
         8q88aUMseY3Up8uzomlqpAOSN150wGMZpTaZOImk2oxnp0/GXBEP10dL+A1E5oItcyag
         TR/RVQH3v7nJAmqrzqdJl9fEjwVq+F7WmfuLy6PQrRWmu/gBjypy15vzoCrRSl1ObaNM
         XFrMRIgk81m7kV6KLn6rqyuMog9UoBqUxrD5nI7FySJV3mtpHkT3j8c82ugsNFVQi5mg
         A7nRSOhqsC1JQCkz1XcnO5SOrC/TBbjOurQ1wflxKRJcyh9mLsW/Zqu7ZWSF+nlIh4EY
         vfAw==
X-Gm-Message-State: APjAAAWsO8yDabMk8nhsSznHMOWciQ2vklkgIPb3eyMtQl6XUpaAzDo1
        2eIf7kt0aAsyghw16nvNz6bZ2k0lC4rmrsDU1Lk=
X-Google-Smtp-Source: APXvYqxBfY1W0pOIwQnyVMlvIRMTFJ2sVqReuYy9ZyPBPSxOnXNfe5kynGBk6ZaTE+lLWjNWLDvUM3CUKGOiIV9nDSw=
X-Received: by 2002:ac8:2bcf:: with SMTP id n15mr10334095qtn.96.1551973847152;
 Thu, 07 Mar 2019 07:50:47 -0800 (PST)
MIME-Version: 1.0
References: <20190307093311.3406888-1-arnd@arndb.de> <20190307151437.GA20201@archlinux-ryzen>
In-Reply-To: <20190307151437.GA20201@archlinux-ryzen>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 7 Mar 2019 16:50:29 +0100
Message-ID: <CAK8P3a2cLEU=wjbV2RvbNSoZSQDkzR0sGWZ0OOGQKQnEYVz13Q@mail.gmail.com>
Subject: Re: [PATCH] enic: fix build warning without CONFIG_CPUMASK_OFFSTACK
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Christian Benvenuti <benve@cisco.com>,
        Govindarajulu Varadarajan <_govind@gmx.com>,
        Parvi Kaustubhi <pkaustub@cisco.com>,
        "David S. Miller" <davem@davemloft.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 7, 2019 at 4:14 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> A slightly less intrusive change would be using cpumask_available, which
> was specifically introduced for this purpose in commit f7e30f01a9e2
> ("cpumask: Add helper cpumask_available()").

Ah nice, I wasn't aware of that function. I'll send a v2.

     Arnd
