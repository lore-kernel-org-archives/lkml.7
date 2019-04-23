Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3072DC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01A2720811
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728578AbfDWQGC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:06:02 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:45715 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728295AbfDWQGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 12:06:01 -0400
Received: by mail-io1-f70.google.com with SMTP id j25so7329608ioj.12
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 09:06:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=oQ+5RDeXMVUx96sriKP1rnJUCvzHQET4JfCD0yTqnK4=;
        b=f8Y2v4OlMhA8awV2zdhkWE25qVRsuti/ktws9gr9ZZWhw6yl8URY2fLdKP7IMf93pY
         4lqbSRQ77cg2j7mdPqHaiQh1pux2L+133rwTbm7xYbR1OPZS0/j5zp98nhSQH7rIow3J
         VHxZF4DYwm15XefM8mVkkDRxI9QjsCghcBhBfO+tldIJAR6uj32BG07QLOjdx1Vn2zxu
         nAmS2OumRXVC7XTRzanwOxwcerSBlnYtyru8XsHexIfQUgW8Qaj71feSNZG/+o/GFmBq
         W/JP3KCudqy2K4VSEFeqaQ0ENiOGQCtAjMFKc/XFtG8181f3ku5yRJDycQpLcaEQPr5M
         2hTA==
X-Gm-Message-State: APjAAAWhQQum6p18IA2kq8HK3xvUCfQU+KmIrHmGlC7XghTER+L+0286
        xgLiEaD6GqyrGCt2F53LVOENDavj6o+TVENlGnDTS6OkST+Y
X-Google-Smtp-Source: APXvYqyO1a8WQjH8I/ukNixhpBGC4KoWjNMgCAiNTPMHTKh/n7na1JXv/Ne2ae0IIThU+LyHskWfggdNwLOlse9EQTS9vIlh+E4o
MIME-Version: 1.0
X-Received: by 2002:a05:6602:9:: with SMTP id b9mr10562226ioa.133.1556035560840;
 Tue, 23 Apr 2019 09:06:00 -0700 (PDT)
Date:   Tue, 23 Apr 2019 09:06:00 -0700
In-Reply-To: <Pine.LNX.4.44L0.1904231126500.1461-100000@iolanthe.rowland.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dca2f3058734c255@google.com>
Subject: Re: general protection fault in __dev_printk
From:   syzbot <syzbot+2eb9121678bdb36e6d57@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, dvyukov@google.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, rafael@kernel.org,
        stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger  
crash:

Reported-and-tested-by:  
syzbot+2eb9121678bdb36e6d57@syzkaller.appspotmail.com

Tested on:

commit:         d34f9519 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan/tree/usb-fuzzer
kernel config:  https://syzkaller.appspot.com/x/.config?x=c73d1bb5aeaeae20
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15909780a00000

Note: testing is done by a robot and is best-effort only.
