Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 465F0C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 05:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A4FD206BF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 05:36:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbfD2FgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 01:36:02 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:50926 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbfD2FgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 01:36:01 -0400
Received: by mail-io1-f71.google.com with SMTP id b26so8010531ioa.17
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2019 22:36:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=3oF4+oEYyzAK0lmDHIO2D2jMP56B/wkYH6h2bOwtiuk=;
        b=emJVLa7C73AYCvjyqDlh9/gT8dlQKrM3y/2Cuj2sUpgc3XdPgb6916cvOw0M/bxNXv
         asSuuklxbZRnAhUzuc1X02KnaaleHuHZcnikDP58Nak6kJs6KMzpwRRQJ4cjxfwjWbbC
         GUpYR9ayMbiy2DK+6ZTtA2hvyzeV+81nSAdpZnlT9xYGyEc3ITg1MLaaNHKqO6ylUhKo
         z7tn66rb/xusABgl9oXmEsOS78EOEXsDHkNWHBbhdKg7bRCgL2vwliuZld3f5pRn5fIq
         JBj4Nlt1lznrz+cVzRNtY8I4XCuqw9kxXteS3hWeO7+jHd4hFnhfw8FErPBa9iL5tYoU
         BVjA==
X-Gm-Message-State: APjAAAWJyzRvcFzZ21ZbDuaUWyVy42aY/dzfryILlC1PqxL2eM9jtnEn
        Px3PAzRfRYgMvyeZ5ucyUhor4w93S5lrTMhIhEBjF0F969m6
X-Google-Smtp-Source: APXvYqxAbd7inE54NKKA41ooTkUqRm9jbppXNucHcGQfURYA7C+U0uUHQ41zM5uD2MQe0Q1gNW6Zt1FsTc19tDgmuKaSE6eizrUq
MIME-Version: 1.0
X-Received: by 2002:a6b:6405:: with SMTP id t5mr23042078iog.190.1556516160955;
 Sun, 28 Apr 2019 22:36:00 -0700 (PDT)
Date:   Sun, 28 Apr 2019 22:36:00 -0700
In-Reply-To: <20190429021039.GB29678@quack2.suse.cz>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dc6b2d0587a4a87f@google.com>
Subject: Re: general protection fault in fanotify_handle_event
From:   syzbot <syzbot+15927486a4f1bfcbaf91@syzkaller.appspotmail.com>
To:     amir73il@gmail.com, jack@suse.cz, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger  
crash:

Reported-and-tested-by:  
syzbot+15927486a4f1bfcbaf91@syzkaller.appspotmail.com

Tested on:

commit:         b1da6a51 fsnotify: Fix NULL ptr deref in fanotify_get_fsid()
git tree:        
git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify
kernel config:  https://syzkaller.appspot.com/x/.config?x=a42d110b47dd6b36
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Note: testing is done by a robot and is best-effort only.
