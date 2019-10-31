Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3520CA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 13:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9843C2080F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 13:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="a2e4cvGV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbfJaNv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 09:51:29 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38298 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727511AbfJaNv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 09:51:29 -0400
Received: by mail-lf1-f68.google.com with SMTP id q28so4746483lfa.5
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 06:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JBx+knSIw23E0kFzMffIcgfzLeLZsagWEAkRYzy0snk=;
        b=a2e4cvGVs6luaA0dnUH3cnEwCfsZjoiIHFbjGfXgfJPAFrWBDNKGXh3GSX6eaI4Ejv
         Uio0Ye2PW0sgV9rD4MYCDt/pMf3UgykOhYFXVS2Ou+7r5l/ySKehSA1KPrwIbf7BwURd
         8p3TBGHeM0kkqxSF7Qq765TJGTATFoXzTJBR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JBx+knSIw23E0kFzMffIcgfzLeLZsagWEAkRYzy0snk=;
        b=SruYaTG5IsxTmL4xH/3TVI2HFmLjWuCzDzpiTpKBLPSMg7spQzQDObM+Q9vHWSbteN
         JYUps/jTgNBVP01jVHVU5cL7kU9VDAhRTrspQzVzxcFm7WidQS61E0Ybbz6Re+Qb/aGv
         g+y0L9p1FXBVOECMFq3NAvsKNIsDHmtR3O4deiH0+WKe55Eeq7RxKiQXJSjx2puVDj8m
         8UAmywi2PfVPLYVFMJnKxzXnij7LX4uZJ83hZrsVlvvEKD8Zqg9ExAitM0lSj5dXQM83
         J8XESvBcjUseidpnSAeHPumB99Bg1D/eKU7HOChLrs7Omi7pQODNDUQV5MGFo+S69SWH
         cGgA==
X-Gm-Message-State: APjAAAWOLnbGrGEgdezgipJdQ/SAO+bVcCSdUe7Sus77tkq9wUcv2Fqe
        UYF+WAkL7vqL495bXskOgxb5QA==
X-Google-Smtp-Source: APXvYqwiweGIG9nHtJ4BxHdQTne7zKoKjAheb3eRHombzQHcHc0Y0XSkKF/lH9B3uroo7Xe6SIzjnA==
X-Received: by 2002:a19:7f15:: with SMTP id a21mr3676212lfd.169.1572529886145;
        Thu, 31 Oct 2019 06:51:26 -0700 (PDT)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id i17sm1451542ljd.2.2019.10.31.06.51.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Oct 2019 06:51:25 -0700 (PDT)
Subject: Re: [PATCH] MAINTAINERS: Add VSPRINTF
To:     Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>,
        Joe Perches <joe@perches.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
References: <20191031133337.9306-1-pmladek@suse.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <975eccc7-897c-fd14-ef4f-2486729eb67c@rasmusvillemoes.dk>
Date:   Thu, 31 Oct 2019 14:51:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191031133337.9306-1-pmladek@suse.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/10/2019 14.33, Petr Mladek wrote:
> printk maintainers have been reviewing patches against vsprintf code last
> few years. Most changes have been committed via printk.git last two years.
> 
> New group is used because printk() is not the only vsprintf() user.
> Also the group of interested people is not the same.

Can you add

R: Rasmus Villemoes <linux@rasmusvillemoes.dk>

to that?

Thanks,
Rasmus
