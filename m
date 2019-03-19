Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92DFAC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6848820643
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbfCSQuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 12:50:19 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39689 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbfCSQuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 12:50:19 -0400
Received: by mail-pg1-f194.google.com with SMTP id h8so14245994pgp.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 09:50:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0GrTmZqlCohRu7Fl4sG4uwqXY0w9opF/U+4YcVfXxGA=;
        b=seMzmLelXDpuI2YAZKPv3+gmeTedNHvWhZ31TPlCM9SO8c47BjKVXnvVQxlE3T27q0
         Av6kgXgKjEwRsgvO/UjG+/FUbO7DmkSkHGnnSGu8DS6jN2I6kTq5MBRu8b5ZWzs7yTyD
         i7ty01Rp3TK6m4u8MBTRCBmzjcCY7OSRzobX2mLIqm9C6wn3lqa/ZAU9cSJhBlo2ggDJ
         Lkgvwpl559XwvFbX4/xO3XUwhzNaBUsddh9MSGTrUQP1nhvuuCkwoWvfVElmjJRXJOgg
         pM79GHsSrrTUPUZdXdoLgUVccqwureO47jkgNo4faaZ/j/fIyoq/3Diw6Uhaz7M0p5pO
         g0Lg==
X-Gm-Message-State: APjAAAWkgUw8P8KaCeObtH6hpi+nIH9F4KP5RFl6u1/4I836Nirm+KFA
        ksYovEXt1Thiwv+5GzRA7XBuXSKXba0=
X-Google-Smtp-Source: APXvYqyskS3QBq1wuQEtD2vhGuN3V8o71TMfrV00TOQIRNvxuRN5lb8Ai7FM/tbBbp2QZcZREgApbg==
X-Received: by 2002:a62:b517:: with SMTP id y23mr2828837pfe.144.1553014218934;
        Tue, 19 Mar 2019 09:50:18 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id s15sm4974449pga.71.2019.03.19.09.50.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Mar 2019 09:50:18 -0700 (PDT)
Message-ID: <1553014217.65329.5.camel@acm.org>
Subject: Re: [PATCH v2 14/19] locking/lockdep: Change type of the element
 field in circular_queue
From:   Bart Van Assche <bvanassche@acm.org>
To:     Yuyang Du <duyuyang@gmail.com>, peterz@infradead.org,
        will.deacon@arm.com, mingo@kernel.org
Cc:     ming.lei@redhat.com, linux-kernel@vger.kernel.org
Date:   Tue, 19 Mar 2019 09:50:17 -0700
In-Reply-To: <20190318085733.3143-15-duyuyang@gmail.com>
References: <20190318085733.3143-1-duyuyang@gmail.com>
         <20190318085733.3143-15-duyuyang@gmail.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-03-18 at 16:57 +-0800, Yuyang Du wrote:
+AD4 The element field is an array in struct circular+AF8-queue to keep track of locks
+AD4 in the search. Making it the same type as the locks avoids type cast.  Also
+AD4 fix a typo.
+AD4 
+AD4 No functional change.

Reviewed-by: Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4


