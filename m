Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F3B9C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AF4B2064A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:33:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbfCSQdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 12:33:03 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41988 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726831AbfCSQdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 12:33:03 -0400
Received: by mail-pg1-f193.google.com with SMTP id p6so1388425pgh.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 09:33:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cRl4VBPcJ/W4yBGS6ItJClkO/OB3cJDbqISYoxLGN3A=;
        b=EtkK5PCCNbbEyDNIMOMfQwMi8JlXmn1UCGaBs7Mq+SWkYwsPz67k5o8Jg6kwHR6gC0
         UUkMmCHTn90p5SU7NcHQcRfc0g5oK3kgJw13UeIPi2qwYN22r1KDAPLNwg9a6uyp+mnT
         Na8EUV0lziMwCCXqsbJjyEExxlDsDnSHOt5X5mHNcb4GLHgOMUb2873BZ/mjzO5gvFMR
         zs9ZlmZCLx5fv06IEEfhXNrQ3ABip6bEVH9fzD46oyIqt71PS7uXV9iazhU8v6XicmKK
         I7vgnq3yhhH80Nl4RtfSZxDFmRqY7XtlDsSb17fjHkwOEDeTHryJYSiBDNZx1fZjIW1O
         CLsQ==
X-Gm-Message-State: APjAAAVivHVZV3RotIGckzVc+aeRpi66f2MLGZbAfaUkAjix/NHV5SJ8
        faFXkvue/Yo9C2t2gUTmhfM=
X-Google-Smtp-Source: APXvYqz1iT0db1Kn+djKwtEgc5CZLUGp06p0mK2wfKn+tDRv0HVdcYPBYhL2IB5UC436gWA0xHpl+A==
X-Received: by 2002:a17:902:266:: with SMTP id 93mr3001566plc.161.1553013182891;
        Tue, 19 Mar 2019 09:33:02 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id j20sm9859306pfi.27.2019.03.19.09.33.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Mar 2019 09:33:02 -0700 (PDT)
Message-ID: <1553013180.152266.51.camel@acm.org>
Subject: Re: [PATCH v2 05/19] locking/lockdep: Adjust indents for function
 definitions
From:   Bart Van Assche <bvanassche@acm.org>
To:     Yuyang Du <duyuyang@gmail.com>, peterz@infradead.org,
        will.deacon@arm.com, mingo@kernel.org
Cc:     ming.lei@redhat.com, linux-kernel@vger.kernel.org
Date:   Tue, 19 Mar 2019 09:33:00 -0700
In-Reply-To: <20190318085733.3143-6-duyuyang@gmail.com>
References: <20190318085733.3143-1-duyuyang@gmail.com>
         <20190318085733.3143-6-duyuyang@gmail.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-03-18 at 16:57 +-0800, Yuyang Du wrote:
+AD4 Being paranoid to see function arguments lines are aligned.

This patch changes code that conforms to the kernel coding style into
code that does not conform to the kernel coding style. If you have a
look at the c-lineup-arglist-tabs-only function in
Documentation/process/coding-style.rst you will see that only tabs and
no spaces should be used to indent function arguments.

Bart.
