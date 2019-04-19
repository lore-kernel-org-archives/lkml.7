Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=DATE_IN_PAST_06_12,
	FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E9DC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE39120645
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbfDSSuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:50:12 -0400
Received: from mail-it1-f198.google.com ([209.85.166.198]:59619 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727038AbfDSSuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:50:12 -0400
Received: by mail-it1-f198.google.com with SMTP id 75so6220402itz.9
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 11:50:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Kf/mLZwwDGuwydxNf3kA3IzwdmfZD8nAnja7XQe90tI=;
        b=Xmzj6cElL/+/qF1AUJt0diBtqdE3ZzyUy/Fd/Rj5wmr8WiFMVWomRhnsQxM3j8lohh
         qI4Aka8kXYeYCqPCREWnK396/lfp2osKJZOEZaP3wzW22et1QOuYfW14nmt3GDGCVabU
         YO90UX05er1CMjPi9+pFrXDjIBMrjUh5AVFrVWEHeuyCp/JFPuk5MZJrL/pkD+vsj3VS
         MuYOncjtjFe2LqJGBqqWIDtK4H0KCDYGv9Ab1nhaLyeEIElT3xX33UoBTHfmxA4Lbj8A
         +79WM2K0Ut2JGVXGYJ1NET9uYN8pqxb7lAdBMiSxWWZWbLB8/BwnUr2D8pM6INijZE8T
         dg2w==
X-Gm-Message-State: APjAAAV2ZFaR/v/QHE/6ZB1Jv8xXgq9FJaNhZ9k3i9mKMPDe6yLOCf7S
        owKZZtMvIZMo+/qwuYzTMmGhXMPlq/OZVEQHmDkxsGMMUIx7
X-Google-Smtp-Source: APXvYqzSFYToQgXxO8Dw1/Ul4k8N6ZQOVhQVQ4nOFyqZCJdphRXTSHQ3+K/mPlVqcmCFzuCixB4UX6Mq8VIYn7MDQ7eB1Z2QuZOW
MIME-Version: 1.0
X-Received: by 2002:a24:90:: with SMTP id 138mr1955088ita.69.1555663980540;
 Fri, 19 Apr 2019 01:53:00 -0700 (PDT)
Date:   Fri, 19 Apr 2019 01:53:00 -0700
In-Reply-To: <CAOQ4uxjOm+VFyTbm=2k1d0774qu2tK5gzEgKNnRPjd0GvMnihA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f33b220586de3e9b@google.com>
Subject: Re: WARNING in ovl_instantiate
From:   syzbot <syzbot+9c69c282adc4edd2b540@syzkaller.appspotmail.com>
To:     amir73il@gmail.com, dvyukov@google.com,
        linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        miklos@szeredi.hu, mszeredi@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger  
crash:

Reported-and-tested-by:  
syzbot+9c69c282adc4edd2b540@syzkaller.appspotmail.com

Tested on:

commit:         59ef64de ovl: detect overlapping layers
git tree:       https://github.com/amir73il/linux.git ovl-check-overlap
kernel config:  https://syzkaller.appspot.com/x/.config?x=f3ee46e9dfc8a383
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Note: testing is done by a robot and is best-effort only.
