Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3186C3A5A0
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 16:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C85BC22CE3
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 16:13:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbfHUQNB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 12:13:01 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:52596 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbfHUQNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 12:13:01 -0400
Received: by mail-io1-f72.google.com with SMTP id q5so3073287iof.19
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 09:13:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Yd53F92BJf3zn8wGZ0U/s186p5/9JYi4U18PT1EI33k=;
        b=lc5tRNWUv3dNTPbqlZ4f6hHbgZhSeI02daPeDZFWictr4m8lDRM0SGkd1gjHXU9LZo
         1Bz/ocHJ6yCutrmBEhsSD4EAtS5C2l2k3x1WZgtKuToewUoSJXfnJBbnNms8qSO8WZwb
         GXoM+lWMqikPXaCjIxd2wr9F3tDnuD6KwqSB5QViGCW0pt+BtVI9u+1R4/ep1VsAok3A
         59+i6pTwN0au4GFgh2Jb0I2P8jUXWoYBwJIWBQnLm6IjEBzr1NSDxMtzjR9zb7sw5qjn
         cFUtgP8kObIjTLBy40jyIhI4/moj8mvh2/Hhb4txz5nq+zpxK+LaLZTv38nTZf0CtzWs
         fKNA==
X-Gm-Message-State: APjAAAV264GPCV+HEdyPojHXbjVK5r2JyUhtTJ5JMgQaVUTE9y4/2FJ0
        4fFDtGD/U7earqRdG9Tfpo67w+zOJx4NGn+b/710w8W6ZxVn
X-Google-Smtp-Source: APXvYqxcWw4L/Vqh6e7csZoUh1Wfmtb8A9sqnIV6jLU54MAVbBAkuO9AjSyCECyy2tXi/H0bOGqXzMrcgTX9GXvsiDZcYJ+jvrY/
MIME-Version: 1.0
X-Received: by 2002:a5d:9681:: with SMTP id m1mr6432416ion.291.1566403980448;
 Wed, 21 Aug 2019 09:13:00 -0700 (PDT)
Date:   Wed, 21 Aug 2019 09:13:00 -0700
In-Reply-To: <Pine.LNX.4.44L0.1908211152230.1816-100000@iolanthe.rowland.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d45a4c0590a2d8bd@google.com>
Subject: Re: KASAN: slab-out-of-bounds Read in hidraw_ioctl
From:   syzbot <syzbot+5a6c4ec678a0c6ee84ba@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, benjamin.tissoires@redhat.com,
        jikos@kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
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
syzbot+5a6c4ec678a0c6ee84ba@syzkaller.appspotmail.com

Tested on:

commit:         e96407b4 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=cfa2c18fb6a8068e
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13dca42e600000

Note: testing is done by a robot and is best-effort only.
