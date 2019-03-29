Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F22AEC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 09:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B678C20811
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 09:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbfC2JzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 05:55:02 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:56766 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbfC2JzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 05:55:02 -0400
Received: by mail-io1-f69.google.com with SMTP id s184so1272650iod.23
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 02:55:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=avfpukgdqe4iAiO3rcIBNXbqaJszeeVXwZ0Nr113DU4=;
        b=nQGiEDDxpbPBpqf5O/xEmQqpwJ3BWbpR8DQh2COlGpiDypeCA+6CInfQxDE6i8pI2f
         IOXg6iIFp3mBSDzgNgOfbdBF3U/FtUu4RSOx5/yABGM+/DpJK4E6noORZCzOoHWnN8f5
         QA21oOGLXMGXudHnmf18/JQMdZG3Nn7FNSQ6Ihk3/bAz1dZTYq+xGdHmlSqUsUGZm7/+
         JMvLyRnKtFJN8fkHJyIGuzVe14peRsrZYSFWveRPUkwghl/GU+rILiEZv0rFqdYolfvu
         GDslRxRDEJmtRdlMXWWHdSGhynYGkZmWHBQ0O+3DniefF88aGbw31Q1htdmvF4YJvs27
         D6pA==
X-Gm-Message-State: APjAAAVG+xSoZVylXLmN9sKaTtXHsgIzfxVIH2zbeGj7F2CXDByXkR57
        TdcvIQtdyMCEdWhGyBE82zsc+RPhHw1rlkJl1a0bGqvIhtUE
X-Google-Smtp-Source: APXvYqyXg9qPCLeY4BysNPdxmA7djSNzAxgQingqnSeE4EK7wR/Dsfimh2u1AQ2NGCNckfaQjL4ZHU7W0OkBswkNhzFGIx2zev3a
MIME-Version: 1.0
X-Received: by 2002:a6b:251:: with SMTP id 78mr4930151ioc.39.1553853301479;
 Fri, 29 Mar 2019 02:55:01 -0700 (PDT)
Date:   Fri, 29 Mar 2019 02:55:01 -0700
In-Reply-To: <CAHRSSEy3od0-7HMCOjbHprc9ihu3VqkJi1-5OKew0oN-2BcPvA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001165cb058538aaee@google.com>
Subject: Re: kernel BUG at drivers/android/binder_alloc.c:LINE! (3)
From:   syzbot <syzbot+f9f3f388440283da2965@syzkaller.appspotmail.com>
To:     arve@android.com, christian@brauner.io, devel@driverdev.osuosl.org,
        gregkh@linuxfoundation.org, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, maco@android.com,
        syzkaller-bugs@googlegroups.com, tkjos@android.com,
        tkjos@google.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger  
crash:

Reported-and-tested-by:  
syzbot+f9f3f388440283da2965@syzkaller.appspotmail.com

Tested on:

commit:         8c2ffd91 Linux 5.1-rc2
git tree:        
git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git master
kernel config:  https://syzkaller.appspot.com/x/.config?x=8dcdce25ea72bedf
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10fed663200000

Note: testing is done by a robot and is best-effort only.
