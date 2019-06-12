Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC38C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 16:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F12E215EA
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 16:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407586AbfFLQ7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 12:59:02 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:46877 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730431AbfFLQ7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 12:59:01 -0400
Received: by mail-io1-f69.google.com with SMTP id s83so12825529iod.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 09:59:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=w+d58fwxVEghqdBTL6OdFKQGL56looaKOR87EN5fMyI=;
        b=PHCDH60nRvz/d9Q7KiUHq4EaM92WJagpdPtEYTOwEJhoFQ5fTS4NDJr8TpeguX94Yr
         PxIk6hv0DFRqh6faYtvANvIzh7j3ULHUYz8Pw0DL6u+vq9mz6uiRZRGGFoaSiblaeUsT
         dvGclg+PQeFHZ4BHdp8Kyz4dzn2yb6SAjLvAGCkmjz9E8eqqjaeyNzN8YONvDP5iuQ0d
         nqxOSn27345RX6wSS98tvQxz4roWuoV0ja5J99xJS/3SmikfXyyLSBQcRYMAzH/L1rVO
         dzxGTSqWfq9BBSIlLA7Yg2MBdC11LAOkjDQ2JwyfNqIwY/fLUMwAm1WFJRRF3bFa60iE
         Qd4w==
X-Gm-Message-State: APjAAAW0xZ+dK6DNqohzfil6/pXa9vt4P+arzuXDtXvYBDGl1TAKF853
        iYZmT/z/RALZUgV/ZC2jxQdIiXhi0Y/kU4V8Ep3kbgFUHKq9
X-Google-Smtp-Source: APXvYqy+d3bgPSksKj/GZ6l17+4OtmOMiusgDBDhfkPRefGdUEPiGlxdnCa9vMOOT8gqL3aVm/rMw7s9G7469ZfCQsjH5cNtRoZr
MIME-Version: 1.0
X-Received: by 2002:a02:4484:: with SMTP id o126mr4901697jaa.34.1560358740768;
 Wed, 12 Jun 2019 09:59:00 -0700 (PDT)
Date:   Wed, 12 Jun 2019 09:59:00 -0700
In-Reply-To: <CAAeHK+wpzHG73AbB+199-TN35Kb1kEjGrKScSqU++7q7RSUGGg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007741b1058b235467@google.com>
Subject: Re: INFO: trying to register non-static key in del_timer_sync (2)
From:   syzbot <syzbot+dc4127f950da51639216@syzkaller.appspotmail.com>
To:     amitkarwar@gmail.com, andreyknvl@google.com, davem@davemloft.net,
        dvyukov@google.com, gbhat@marvell.com, huxinming820@gmail.com,
        kvalo@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, nishants@marvell.com,
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
syzbot+dc4127f950da51639216@syzkaller.appspotmail.com

Tested on:

commit:         69bbe8c7 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git usb-fuzzer
kernel config:  https://syzkaller.appspot.com/x/.config?x=39290eb0151bec39
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14171fd2a00000

Note: testing is done by a robot and is best-effort only.
