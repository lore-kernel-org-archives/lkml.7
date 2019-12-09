Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE45DC04E30
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 23:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B311C206D5
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 23:46:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbfLIXqC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 18:46:02 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:56493 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbfLIXqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 18:46:01 -0500
Received: by mail-il1-f200.google.com with SMTP id 12so3806561iln.23
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 15:46:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=hWaIex+koh6jdBsw/jvRJQ3HQOaL7kSrdmI8OfB4npk=;
        b=MQjQgToVFZg5zQZ9Psj6dXTWvteQuZe8o+o53cyIsKSsUkate5fERZh1f8V1hF1IeT
         a/iJOz7B7ZNmcepbmz1Nu0vNb+J3lr00rDG1ndb3JvQMuSX48ATjPcs8k2vJLnV2eT/n
         eidxyV/3raVusN/1+y5LTClLz0+uUihVHQ/GX+Cl3VRmqS+zp0f5nK3Tt1TMTecK2H/c
         /4rTaPKgF2xvVZgecsKLJeSvdlHvpusCo/aeCyvDu7/nRYMouxDY5fhblj7swGgZ88Xy
         vIsiTRoj97BCD+HbvqNdQU/QXPhiaSd9jAwViq07bQy3tha9/Fucb4mCwpHYkLzysXk4
         iv9Q==
X-Gm-Message-State: APjAAAVDJGqGgzflR3tfMDRj/wZcVgIRXh8oStEi0tYIUJRx/yeqwWE6
        6cEMiBXmZDYe7qk21KJxqL2d0q94D+Y6zEnVKFmHqBILRzPM
X-Google-Smtp-Source: APXvYqycbY+HQGkGdjQbePP8cr8ECSXGxrDkL3BMEEnHcpRL29CgV9t9BGQj2mNNgZ2EV+ADomhx9vWT9AVPvaH1ZJgv29P59Yt5
MIME-Version: 1.0
X-Received: by 2002:a5d:96c6:: with SMTP id r6mr9224856iol.236.1575935160916;
 Mon, 09 Dec 2019 15:46:00 -0800 (PST)
Date:   Mon, 09 Dec 2019 15:46:00 -0800
In-Reply-To: <Pine.LNX.4.44L0.1912091448420.1462-100000@iolanthe.rowland.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000074a59505994dfff0@google.com>
Subject: Re: KASAN: slab-out-of-bounds Read in hid_field_extract
From:   syzbot <syzbot+09ef48aa58261464b621@syzkaller.appspotmail.com>
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
syzbot+09ef48aa58261464b621@syzkaller.appspotmail.com

Tested on:

commit:         1f22d15c usb: gadget: add raw-gadget interface
git tree:       https://github.com/google/kasan.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=8ccee2968018adcb
dashboard link: https://syzkaller.appspot.com/bug?extid=09ef48aa58261464b621
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=146cae41e00000

Note: testing is done by a robot and is best-effort only.
