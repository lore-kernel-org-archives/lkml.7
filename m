Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99900C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 12:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6564A2087B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 12:53:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728939AbfEQMxT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 08:53:19 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52890 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728430AbfEQMxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 08:53:18 -0400
Received: by mail-wm1-f67.google.com with SMTP id y3so6859638wmm.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 05:53:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zcYe+aG05w2UO1ZXKc7jrJL+Ovz86Hm2R29bKoYuqSk=;
        b=anT/6/9I5YdGZK2UEK/cqG3TLXTeE3QpJ+RsLlp01DwBsa87nq2Y2fKwoQYlqiCWf7
         lBWwAxPm8oSrEgNxRkt6h/Pr2aXK3Txxe8nEPZTiSrMuKiAfyv/Jw4exixhlkcVnQK6x
         n8Yc6TZERuMfk7k7Jx3FwPml4rD2nNFBgQI7sctsF/QjkHd4AU5M2CvhWoqjmgPGwmxH
         9YFHk9as2hY1Xs2Nr+g5Wjrrpr4/TuvsBsfNEo/sv7pLCFiCfQuWEM72/z3zOTtxFg3N
         EyQvHmogRHJ/zVcNa/sjfYAP5cj0swTZjQUhc2uDgIDheG/CFvAgMJ3pMzSlmM2ArjSW
         m1AQ==
X-Gm-Message-State: APjAAAUJuZ1tRAsv9pwi6EKV6goX6wszFF7AGt305d6LwMO8dgfgPsbL
        4PXGlPZwlmpR48isld7VW7C8vDrWJ+s=
X-Google-Smtp-Source: APXvYqzvQo4PLIOLgEYS45mThRlVYeoSKfB0i310BFOLRFwKSRuu+NOfl46fdrqxPtJzbnmADzwaFw==
X-Received: by 2002:a1c:7dcf:: with SMTP id y198mr2040524wmc.94.1558097596479;
        Fri, 17 May 2019 05:53:16 -0700 (PDT)
Received: from localhost.localdomain ([151.29.174.33])
        by smtp.gmail.com with ESMTPSA id q3sm6514366wrr.16.2019.05.17.05.53.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 May 2019 05:53:15 -0700 (PDT)
Date:   Fri, 17 May 2019 14:53:13 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE][CFP] Power Management and Scheduling in the Linux
 Kernel III edition (OSPM-summit 2019)
Message-ID: <20190517125313.GJ14991@localhost.localdomain>
References: <20190114161910.GB5581@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190114161910.GB5581@localhost.localdomain>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 14/01/19 17:19, Juri Lelli wrote:
> Power Management and Scheduling in the Linux Kernel (OSPM-summit) III edition
> May 20-22, 2019
> Scuola Superiore Sant'Anna
> Pisa, Italy
> 
> ---
> 
> .:: FOCUS
> 
> The III edition of the Power Management and Scheduling in the Linux
> Kernel (OSPM) summit aims at fostering discussions on power management
> and (real-time) scheduling techniques. Summit will be held in Pisa
> (Italy) on May 20-22, 2019.

Next week!

FYI, final schedule is online (Italy (GMT+2)):

http://retis.sssup.it/ospm-summit/program.html

Live streaming events have been created and are accessible both from the
summit schedule ("live streaming" links) and at:

https://bit.ly/2Vz3yKg

Best,

- Juri
