Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5CFBC48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 11:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 937F5208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 11:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbfFZL0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 07:26:41 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:40482 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbfFZL0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 07:26:40 -0400
Received: by mail-yw1-f67.google.com with SMTP id b143so979421ywb.7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 04:26:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=KHFytg747JkFq6clGmR7aJK1huz8uziX9oTGDlDLd/M=;
        b=MPyeY/DUaW+dBXHBnOfOv9XDF31f6k7zIDwXfJLx33UW1WPx+5lv2Py9QAZYRQYOsZ
         CpMWsvMF1zVVORp6vu7Zhh6olw3rT5NTfME4PO8jCKKDKP8RiP86qqMGGZUNLvQ9wbc1
         SFH5YfrwZ73ma0S+h2onzVej/3wPXekHeF/dy9NTKN0eLUwAJkvYUzLSR3HnwNfeHfpy
         iWqmK2JzLpgksFuf3LqBPm6WVVWuq0M+8N/4tNKG0T5JTyUo4+FLnsBz6WwRACB9AqgF
         fKkz0kqRAZ0NZljomXx09EAt2Vu4IqHSysiM9WjHRt9zyxUiI6wFS0zph9tPF6WzO9b8
         Qdrw==
X-Gm-Message-State: APjAAAW1a/llISA/GjmjUmjOT8BzgIaPlZcdLM5z3/zZMGIq/sfE9dBZ
        GvsA4a4iTcTW0dhFUE1u4z3bshaorho=
X-Google-Smtp-Source: APXvYqxhNEP2EQRhWOcNJVBd0njCM2XIvztZ9nrzePl5N9fpyvC7scQXuQ0tidm25VUsOi+aqwO1+g==
X-Received: by 2002:a81:3bd4:: with SMTP id i203mr2410395ywa.116.1561548399345;
        Wed, 26 Jun 2019 04:26:39 -0700 (PDT)
Received: from tleilax.poochiereds.net (cpe-2606-A000-1100-37D-0-0-0-C58.dyn6.twc.com. [2606:a000:1100:37d::c58])
        by smtp.gmail.com with ESMTPSA id 200sm4468605ywq.102.2019.06.26.04.26.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 04:26:38 -0700 (PDT)
Message-ID: <b6056c07d6bfaeee50924d8845504f88e4477c50.camel@redhat.com>
Subject: Re: New CephFS kernel client maintainer
From:   Jeff Layton <jlayton@redhat.com>
To:     "Yan, Zheng" <zyan@redhat.com>,
        ceph-devel <ceph-devel@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Wed, 26 Jun 2019 07:26:36 -0400
In-Reply-To: <23249968-661b-2d50-9261-8bcd114d7984@redhat.com>
References: <23249968-661b-2d50-9261-8bcd114d7984@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.3 (3.32.3-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-05-30 at 22:07 +0800, Yan, Zheng wrote:
> Hello everyone.
> 
> I'd like to introduce new CephFS kernel client maintainer Jeff Layton 
> <jlayton@redhat.com>. Jeff is a long time Linux kernel developer 
> specializing in network file systems. He has worked on CephFS for three 
> years. He also has made significant contributions to the kernel's NFS 
> client and server, the CIFS client and the kernel's VFS layer.
> 
> I will continue to work on CephFS, but spend more time on improving 
> CephFS metadata server.

Sorry for taking so long to respond and thanks for the intro. You leave
some big shoes to fill!

I've finally gotten around to sending a patch for the MAINTAINERS file.
I'm assuming (for now) that you don't want to stay on as co-maintainer.
Let me know if that's incorrect and I'll fix up the patch.

Cheers,
-- 
Jeff Layton <jlayton@redhat.com>

