Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF19FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A99AC20643
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:49:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbfCSQs6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 12:48:58 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33733 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbfCSQs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 12:48:58 -0400
Received: by mail-pf1-f194.google.com with SMTP id i19so14116761pfd.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 09:48:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H9n2COm6nr/Rcp6IsHAzjRaQZOYKhoUBdXfFQIGZ27g=;
        b=KoGELvHQawqSd7SbsmcBNNGTjoEay6UcVTkxX+rzrBfi33XjaC1mv3U0PXXFrQeoFC
         GuJlJITUXYgd1GVpDMk/ggrbhDbcGEb0VYrh3d1ncOTghcyGcM7bIN4eT9ubrw8qz1NV
         WcuDFmalkYlRpQnPPcmDvYNxnGphFQXaomfdjRHq4dbkXYq43grGoSY0JGQJvyKHUG06
         xIzVxbTB+vlRhm6tqicDpr0RwjbrLsHC5y81HzKGLcCQ78rIsiVo9NrcEWzBDtahh5bD
         DQnZOR+88fswYfQxUHavlPai9MZPNPgXB737F+lJGIGRENXrWf0OyEobxv7VuQgdp2SJ
         g5sQ==
X-Gm-Message-State: APjAAAXj00GN4G6nDBRMIZTLxowXZzH39spQ3kNWjN3weV/BKCr3vW9J
        ahyHPVQuCGVcEzkax3QlJd0=
X-Google-Smtp-Source: APXvYqxdmnnlxnW0wct0VgsDjrIBkWupMKkM5E+VDcE2KLnASb26Tv8Q8hpiQJzhZruHrMQSVGpi7g==
X-Received: by 2002:a62:1d90:: with SMTP id d138mr3006172pfd.232.1553014137991;
        Tue, 19 Mar 2019 09:48:57 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id f3sm20329400pfn.100.2019.03.19.09.48.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Mar 2019 09:48:57 -0700 (PDT)
Message-ID: <1553014136.65329.4.camel@acm.org>
Subject: Re: [PATCH v2 13/19] locking/lockdep: Remove unnecessary function
 pointer argument
From:   Bart Van Assche <bvanassche@acm.org>
To:     Yuyang Du <duyuyang@gmail.com>, peterz@infradead.org,
        will.deacon@arm.com, mingo@kernel.org
Cc:     ming.lei@redhat.com, linux-kernel@vger.kernel.org
Date:   Tue, 19 Mar 2019 09:48:56 -0700
In-Reply-To: <20190318085733.3143-14-duyuyang@gmail.com>
References: <20190318085733.3143-1-duyuyang@gmail.com>
         <20190318085733.3143-14-duyuyang@gmail.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-03-18 at 16:57 +-0800, Yuyang Du wrote:
+AD4 check+AF8-prev+AF8-add() always has save+AF8-trace() as an input argument, which is
+AD4 unnecessary.

I think this kind of transformation is called constant propagation. You may
want to mention that name. Anyway:

Reviewed-by: Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4


