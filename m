Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D4CAC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26D5920700
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:45:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbfCSQpl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 12:45:41 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45545 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbfCSQpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 12:45:41 -0400
Received: by mail-pg1-f194.google.com with SMTP id y3so5015121pgk.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 09:45:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pRrmxLFmC6NZi2jGiJ2vcOrbJsKHUf7eUS6vXqBp5t0=;
        b=Lt5knT8MeDv4yCxSphX8GymKqluGb9wKjZCu81MeyMTmKlkjK7Z2KfsWw/dL3IRj4Q
         qu6/KsddQHkxU94IvtKWBsmAcsIKYAYPBZDQ78hhwSa1/skxpGGgcUUIXb6PwwbVdKMX
         jNG29row97blQL1d3aFcbLgVI5A9+BWvnGPYzL9P4HnTLgGCjo27JlH7R3z43dTkDlHT
         utHMVX7RkneIXf+odyrgM8c49Si/yMnzzcaXl5EQNgOrFE9khlnAEzzY7YMuCgqOUMIz
         ViyXmUR6IXZGs/RWHuxTj9m/3bCBje0w5kRNnVVCgCYVFGOit0w6XsYCNgQ97/JoHedz
         DbcQ==
X-Gm-Message-State: APjAAAXOltfz3ZSujwa+UlDO+kb0zuGQS9F9WgGxuGiPG5Vh4hgfduz2
        LvqU/9WWhA5dVVW2bDHsOd0=
X-Google-Smtp-Source: APXvYqwsayynyXyewZ/CtwVNUHTx6CDV01WKBK0F73nCCj6mT9YtMmG6PNHU2zPkzXeLHXj0ny7JCQ==
X-Received: by 2002:a63:104e:: with SMTP id 14mr2671424pgq.185.1553013940769;
        Tue, 19 Mar 2019 09:45:40 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id a7sm3952399pfc.45.2019.03.19.09.45.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Mar 2019 09:45:39 -0700 (PDT)
Message-ID: <1553013938.65329.3.camel@acm.org>
Subject: Re: [PATCH v2 11/19] locking/lockdep: Remove unused argument in
 validate_chain()
From:   Bart Van Assche <bvanassche@acm.org>
To:     Yuyang Du <duyuyang@gmail.com>, peterz@infradead.org,
        will.deacon@arm.com, mingo@kernel.org
Cc:     ming.lei@redhat.com, linux-kernel@vger.kernel.org
Date:   Tue, 19 Mar 2019 09:45:38 -0700
In-Reply-To: <20190318085733.3143-12-duyuyang@gmail.com>
References: <20190318085733.3143-1-duyuyang@gmail.com>
         <20190318085733.3143-12-duyuyang@gmail.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-03-18 at 16:57 +-0800, Yuyang Du wrote:
+AD4 Its lockdep+AF8-map argument is not used, remove it.

Maybe update the commit message to reflect that the same unused argument is
also removed from check+AF8-deadlock()? Anyway:

Reviewed-by: Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4


