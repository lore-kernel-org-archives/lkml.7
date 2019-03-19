Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 840C1C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 503282075C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbfCSQvt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 12:51:49 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33054 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfCSQvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 12:51:48 -0400
Received: by mail-pf1-f193.google.com with SMTP id i19so14122243pfd.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 09:51:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/f64lzHrYZFKV+ReOEeRcDJDyKm3d+6RzF2Rb5xxhB8=;
        b=o1uK1kgI9X3f3wXslLw59L2lqfIKpZGuyfjosLTvy1W6iI7LL8Q8vGhSznI8AxLK1x
         GklapWhom9/WcEgyZY+4s7QJGXAcRBZkHDvWsbGC+kDuxOdrHgUoFyEIGTczJ4bbN2wR
         Jdkk61ntD7PRp/Z+mCow/WdYd2qAo7kkjkHaUFXiI5+j2ByLlgMt/6vLQ0qGE8ADsxRX
         IYd1+EMx1kGcf6e4NzHNxpnrlfEH3GMvOFtVjqcVYyfWE803BwBRgENQ/RtjBqELbf13
         cGqLXvF5yMUS8IJIFKdwWlObX8h2w2VKayFa0UvtLn+CaJLgeW+nh0baSWvatTuBCWUQ
         wirw==
X-Gm-Message-State: APjAAAWAaxxRxcfX1A8FFGb2TI9KvLt0bcIrM2aA2LljEDb28tpNbwwg
        MdPzvQTSehjquHZgCotKUYo=
X-Google-Smtp-Source: APXvYqyx65zEFE5X+SdYhDbK+/6NkjOYRQzZWZmRgB4Vmhn3FZrfwhTOGTmcrSyUS24UE7phppQBgQ==
X-Received: by 2002:aa7:8d17:: with SMTP id j23mr2934173pfe.62.1553014308104;
        Tue, 19 Mar 2019 09:51:48 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id h184sm31697774pfc.78.2019.03.19.09.51.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Mar 2019 09:51:47 -0700 (PDT)
Message-ID: <1553014306.65329.7.camel@acm.org>
Subject: Re: [PATCH v2 14/19] locking/lockdep: Change type of the element
 field in circular_queue
From:   Bart Van Assche <bvanassche@acm.org>
To:     Yuyang Du <duyuyang@gmail.com>, peterz@infradead.org,
        will.deacon@arm.com, mingo@kernel.org
Cc:     ming.lei@redhat.com, linux-kernel@vger.kernel.org
Date:   Tue, 19 Mar 2019 09:51:46 -0700
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

BTW, your patch does more than fixing a typo. This patch elaborates the comment
above struct circular+AF8-queue. I think the commit message should mention that.

Bart.
