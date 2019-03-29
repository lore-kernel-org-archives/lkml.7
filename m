Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27312C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 00:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB18C20811
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 00:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbfC2AUB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 20:20:01 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:33440 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728012AbfC2AUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 20:20:01 -0400
Received: by mail-io1-f69.google.com with SMTP id n15so447400ioc.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 17:20:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=WljGOgr6+V0So5MSNDm2U/a9k/KnU7qagWjQqFfr+r4=;
        b=bYWArz4Gbl5s9ojHfzZE0W5E/y5HgcSpXEeHYELKGBRL/x9pYFcsG95LwASyV9oPZq
         irJ7oVgYmN+qbq3NhJLRxGNJW81GL9jHhywlHIvQWEMVIv6bYF6cYIFI+FSVKRg1+aMC
         Dxa8b7z/HdSPxPzCoV6VX6ZMVKj91RkSa1JXV6L/Hb86SPXi0ZPXAogI+bQOXQZjl1eO
         sMIZVTl5xpvPVIzGOukQ6VhU7JqeqJAWqfm6QCVGduqAolQHJjsz03f1VK+WHxny0ZjD
         TtXvqCK3PuwSg7DDVy4QoXwPHvtYValvtaCKFYbry0lRV+0837mHlqWSHgINM/87VQxx
         N1Gw==
X-Gm-Message-State: APjAAAXmBNhWkxfKhR5bnZUbVco3WM7Lc7anhNzK/S1guejMdu9qh8gS
        PMFn1++tuAx2oX0KnYNZ+408sE844WWWo11RHnV3GsH4O+og
X-Google-Smtp-Source: APXvYqwznfpHktjc7pzobmaq2euNxjjFSlfghV3aG+rNsx1BzCwHfD8bKWX/D7H8wcfU33ED7uZsMSvWK/OMDLOxRSYcqfTv6RAz
MIME-Version: 1.0
X-Received: by 2002:a05:660c:885:: with SMTP id o5mr888604itk.27.1553818800665;
 Thu, 28 Mar 2019 17:20:00 -0700 (PDT)
Date:   Thu, 28 Mar 2019 17:20:00 -0700
In-Reply-To: <CAHRSSEzGaZw4y4gKzyJzxmrkL20NpTAtB8mDeDs+JzsTWeDZKA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a8bbbb058530a12a@google.com>
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

syzbot tried to test the proposed patch but build/boot failed:

timed out






Tested on:

commit:         0532a1b0 virt: vbox: Implement passing requestor info to t..
git tree:        
git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git  
char-misc-linus
kernel config:  https://syzkaller.appspot.com/x/.config?x=8dcdce25ea72bedf
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

