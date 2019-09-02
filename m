Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE7FCC3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 18:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5DB4216C8
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 18:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbfIBSF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 14:05:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44740 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726506AbfIBSF0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 14:05:26 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D898985539
        for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2019 18:05:26 +0000 (UTC)
Received: by mail-io1-f72.google.com with SMTP id t8so19810987iom.8
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 11:05:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UkgUaL8VzlklW86uya8kYZjjavCTUDQ8aI35FGVFq8s=;
        b=jgoa/KM65HeMqe2BHrTFVbOmbjLy/aZCOkmODVAz1j0b6G1dVWeBicwqBe+5i/AhBK
         WaLUEGVsXusUNB3lv+1gnQBGudro7oF4CLE72bi04vl6jJn1/fYwS3rqwyIDfEuqBNVL
         ft0BeCPmMCRuO4gDtfvLYqFB4D2ovu21Wxx/dHQhNe00c+d7LD297E5QV9SO6xaAr6zc
         OTGP/hZelN2ngQYwQYIzvYUEcXOK9hgtIKJZQMGUpnQGJS0fBAcOUTcPCoLHhqCYVFSm
         zpFc0LcbE7MTM1Z5NzC1THPc6Bd0NqGyghSS1IAIwzhySUVMmhyuUih/nx+fhjHwGElw
         LPCw==
X-Gm-Message-State: APjAAAUsj7QnL/JAokkRdJREkb2ahGYZsKBRV90ovyGNuXoWOW8+mKUJ
        Tb3wOucSvi0o08jf2WBVejXaKMb1Df+Z/SZ1kOZ+guI+89P3iBFOPuM1X5hBeNarIjrw9MZ5dEW
        uRL+K2EQ3wS473Ebuki3PxJfLgbuju6x2c3WvA91L
X-Received: by 2002:a02:9a12:: with SMTP id b18mr26263196jal.70.1567447526342;
        Mon, 02 Sep 2019 11:05:26 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxnLzafJ6PcT24LmpFEMVCZaodz/wkINz7GVGLbos75Tlsx/zjDptZUOJTEX5bD3/97D/+Tpax1FDlAP1hMiDE=
X-Received: by 2002:a02:9a12:: with SMTP id b18mr26263171jal.70.1567447526101;
 Mon, 02 Sep 2019 11:05:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190902143915.20576-1-yuehaibing@huawei.com>
In-Reply-To: <20190902143915.20576-1-yuehaibing@huawei.com>
From:   Miklos Szeredi <mszeredi@redhat.com>
Date:   Mon, 2 Sep 2019 20:05:15 +0200
Message-ID: <CAOssrKdfyd0=Vod6DC9AiN=wNnPaT2nN5MY8tSq73m80BLoANg@mail.gmail.com>
Subject: Re: [PATCH -next] virtio-fs: Add missing include file
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 2, 2019 at 4:43 PM YueHaibing <yuehaibing@huawei.com> wrote:
>
> fs/fuse/virtio_fs.c: In function virtio_fs_requests_done_work:
> fs/fuse/virtio_fs.c:348:6: error: implicit declaration of function zero_user_segment;
>  did you mean get_user_pages? [-Werror=implicit-function-declaration]
>       zero_user_segment(page, len, thislen);
>       ^~~~~~~~~~~~~~~~~
>       get_user_pages
>
> Add missing include file <linux/highmem.h>

Thanks, folded.

Miklos
