Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B251C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 10:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27B0A21924
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 10:53:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389658AbfISKxQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 06:53:16 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:56948 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389585AbfISKxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 06:53:02 -0400
Received: by mail-io1-f72.google.com with SMTP id a22so664074ioq.23
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 03:53:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=jr/hT8uygPGiBuTwaFY7igDD72bmfCnEZQ3lM50QObE=;
        b=NLgGRQQp0pgbNhGgbF5w47fU/SOOeeATPEwRw76y/a0QIB/1xzgOKA7wVhDjjNVwMw
         odOCxSCdX5+hG4j/fTDsONd7RTVQlpfhupQryHdS04lp0hjhs0QcdPsAA8sCia3GyJzx
         VZoAOvqwmFgGole42OQ0Zp/PmK2X+VcQd2JQuHmUgLd8cTIwt3MV0xL1XUdP5tQ2it3e
         K+caMlYJL1eqH/7A/qZDJblzS2w0l2ccwqhQ81Oqd6YC68tpt/U+rkgrEXyq4B8iwS9p
         xNWD4u/VBDkd9EzeVq5vapu/oeYMrZhA/0S+YmdZJSzd0yHMKc4y8BsyosqaxVazyJPR
         E+AA==
X-Gm-Message-State: APjAAAV/BCckbIkE6VuDm+a5Ow5Hm0pAktjZjb7Ig8YVxvpel1pPs9Wq
        hfObSgzxtwBB2jIXxfPs2GTA0D11EVkylibynBVsv8HDXCsA
X-Google-Smtp-Source: APXvYqwBWekg4rlOfT8nn0tmPSwzloIFaVhEADkdzXirXXPPYKk38+p+DJLKH5A4eUO0l/GsUaCDAVmO12kKaHk5yiREht3CTXR5
MIME-Version: 1.0
X-Received: by 2002:a6b:e618:: with SMTP id g24mr10724603ioh.277.1568890380520;
 Thu, 19 Sep 2019 03:53:00 -0700 (PDT)
Date:   Thu, 19 Sep 2019 03:53:00 -0700
In-Reply-To: <20190919103504.GC30545@localhost>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d290e00592e5c17d@google.com>
Subject: Re: KASAN: use-after-free Read in adu_disconnect
From:   syzbot <syzbot+0243cb250a51eeefb8cc@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, dmg@turingmachine.org,
        gregkh@linuxfoundation.org, johan@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
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
syzbot+0243cb250a51eeefb8cc@syzkaller.appspotmail.com

Tested on:

commit:         f0df5c1b usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=5c6633fa4ed00be5
dashboard link: https://syzkaller.appspot.com/bug?extid=0243cb250a51eeefb8cc
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1440268d600000

Note: testing is done by a robot and is best-effort only.
