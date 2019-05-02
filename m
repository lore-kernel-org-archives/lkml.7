Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D48C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 08:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCC3F20651
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 08:55:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfEBIzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 04:55:12 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33158 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfEBIzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 04:55:12 -0400
Received: by mail-lj1-f193.google.com with SMTP id f23so1475622ljc.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 01:55:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XcwQBg8J7QsNVW/WrwQtCeiLPV6+gS2aQiC/Sl4nM9M=;
        b=Df+faCU04EUsievLCwbpDqrJZsHumtr5v8DBab0pn/1hW81Nupem0P3epjIIQ55/FS
         lg75B93uvJ1NB7kCUfFdNjZT8VI84h5eABbs7DZxkLUwkW1UK318yxd3bcCXgOHTsCgu
         6VjCIjlpOCvPRRXRXqNJzwplpwoTUuyyirJtfPnmimelmG6Ac3bwyYBQAcpn6pDAD7G1
         ch1kxb6FSiqxjvPcoSvbXDHDV1rhETqJUtpc643DZ0Cf4Knm4t34zKM5VVqXK5/hCQ7l
         hbiwcEfy0hxsdxdvRuCAJGoXMCQOgdZ6Sy+svPloiqg6lCo0tSfr8JC9g8C/i2EtBUz1
         bAEQ==
X-Gm-Message-State: APjAAAVKBjdD56ymOs/UlaomYvczf5p4MED9YXbWdwD15s2UHYfmaldR
        ZoMV+qicWBAeYU3vHc3EsABPsUWVk7gcDZeI6f8IYQ==
X-Google-Smtp-Source: APXvYqz2pqQelrV7mW5UIHU/z27RQVBlfb9cw8OqwPI7xGo8xR/m90tdJZzhWRDEb/SHdQyQANIdyO2H6klgOfE8Btw=
X-Received: by 2002:a2e:9f53:: with SMTP id v19mr1269972ljk.0.1556787310088;
 Thu, 02 May 2019 01:55:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190502085105.2967-1-mcroce@redhat.com>
In-Reply-To: <20190502085105.2967-1-mcroce@redhat.com>
From:   Matteo Croce <mcroce@redhat.com>
Date:   Thu, 2 May 2019 10:54:34 +0200
Message-ID: <CAGnkfhwWnST_uMOOpBtz4scN50T_9X+bJnVYaHeFvLzPHgRGtA@mail.gmail.com>
Subject: Re: [PATCH net] cls_matchall: avoid panic when receiving a packet
 before filter set
To:     netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 2, 2019 at 10:51 AM Matteo Croce <mcroce@redhat.com> wrote:
>
> When a matchall classifier is added, there is a small time interval in
> which tp->root is NULL. If we receive a packet in this small time slice
> a NULL pointer dereference will happen, leading to a kernel panic:
>

Hi,

I forgot to mark it as v2. Will someone handle it, or I have to
resubmit a v2 or v3?

Regards,
-- 
Matteo Croce
per aspera ad upstream
