Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D860C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 062972064A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbfCSQfw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 12:35:52 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35450 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfCSQfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 12:35:52 -0400
Received: by mail-pf1-f194.google.com with SMTP id j5so14099666pfa.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 09:35:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j8iCJ0cMpwgCdtoCoT1ZKVV69uNY2z7tYXnK+yTMauY=;
        b=OjXQagzAASdjJ4FuVeOYG6tP4n16irtq9dByXJWmR1qVFGMsDnR1ENXTCqDNSIvuod
         x7sSM2s+qSoC/V8qDl0l1MNb6u5Xc4IVRxbs+Tg1D8kducy9BTLwGUYI5lSzr5hn33Ch
         8x2Cz/+2mAvM9jcNNA+QfbTT0yxTaWnZOEyrxK1ECm2/trZePj9a5mMuuAk06Uc2gf4Q
         qnjjWFtgLjeb/C6G4uFtaYOOE5THGqKfhG0qXTIysaBfSHx1to5BVdb9OwOZtf6Ge3N9
         lmhRnfouWDEQYC71Btudr5Z9H84JlyEPWyo9UIGCbCjFbMam93PoZ1U17ASMUvllCD3A
         6JDw==
X-Gm-Message-State: APjAAAWgZDZYpI6rCrHp+6XpWTlGfRiOckXpK62QasJuJfJzmP9wHAU6
        Ofslr2P6wKupJ7R9WG4z+zE=
X-Google-Smtp-Source: APXvYqybijhsdaOeWxqe46FOX6D1SVHDYnCpGh8SSVbcAbwiWjBXwhVZpQG8XMCqKhuQUUi7B7QKEw==
X-Received: by 2002:aa7:8384:: with SMTP id u4mr2757410pfm.190.1553013351630;
        Tue, 19 Mar 2019 09:35:51 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id b15sm25416390pfj.167.2019.03.19.09.35.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Mar 2019 09:35:50 -0700 (PDT)
Message-ID: <1553013349.65329.0.camel@acm.org>
Subject: Re: [PATCH v2 07/19] locking/lockdep: Update obsolete struct field
 description
From:   Bart Van Assche <bvanassche@acm.org>
To:     Yuyang Du <duyuyang@gmail.com>, peterz@infradead.org,
        will.deacon@arm.com, mingo@kernel.org
Cc:     ming.lei@redhat.com, linux-kernel@vger.kernel.org
Date:   Tue, 19 Mar 2019 09:35:49 -0700
In-Reply-To: <20190318085733.3143-8-duyuyang@gmail.com>
References: <20190318085733.3143-1-duyuyang@gmail.com>
         <20190318085733.3143-8-duyuyang@gmail.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-03-18 at 16:57 +-0800, Yuyang Du wrote:
+AD4  struct lock+AF8-chain +AHs
+AD4 -       /+ACo see BUILD+AF8-BUG+AF8-ON()s in lookup+AF8-chain+AF8-cache() +ACo-/
+AD4 +-       /+ACo
+AD4 +-        +ACo irq+AF8-context: the same as irq+AF8-context in held+AF8-lock below
+AD4 +-        +ACo depth:       the number of held locks in this chain
+AD4 +-        +ACo base:        the index in chain+AF8-hlocks for this chain
+AD4 +-        +ACo-/
+AD4         unsigned int                    irq+AF8-context :  2,
+AD4                                         depth       :  6,
+AD4                                         base        : 24+ADs

Have you considered to use the kernel-doc style for documenting these
structure members?

Thanks,

Bart.
