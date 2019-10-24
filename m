Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D2FCA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 15:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9D06205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 15:22:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503087AbfJXPWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 11:22:05 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:34798 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403837AbfJXPWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 11:22:04 -0400
Received: by mail-il1-f198.google.com with SMTP id s17so15932063ili.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 08:22:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=RqIARasz4PZZfM4Zlv+NGn5c1w9s+0zeajPkvbZDLG8=;
        b=VfleQBOQk8dQYXcoeKFhDXCsuhxhaeuvjWIl2+vOqOVTGIQLAqEG5yrRXii1lNWJ0p
         z6hesrKI0VdjfHRv1OfUVETKiWx2+JbXQz7BccIEHNOb+zuMUt26rhp9IrpPlO2nckwK
         5Pvc8CZfzzdnyqVVuAkDTFxFDLPyayRQEYHXBS22imkWHssp3mr2nI351UXu4n+xy+rU
         Amlg1jm1OijFkndVgpLgJgyK24goIG/DdyooGGrKBMOQC9FGmVHVdFauAVRMvCyO7WAM
         v72rU5yzKTwkpfPvwVQUTJ+dJFhms/ug2NKX9EQzvhfUaNWF5/GWpafNNEJ/ikPRVurY
         MjZw==
X-Gm-Message-State: APjAAAVNGBjZLcybEwTfg5QDEbBGTjTzNAdYnA394BildwI/vkK/udMf
        /h+9wkNZlha8iiPSlsCHVCqG7N1ssgvLzpm8/3ubZtVcVv57
X-Google-Smtp-Source: APXvYqz6vdsYutSN8ENa8kZoFnbo8JHWDQwsquQngY3sXxodHpUDPiFWzl7IoLyB1BKrLE8AbVM57hBZFomIkEzJJH8XROc00gIS
MIME-Version: 1.0
X-Received: by 2002:a92:8394:: with SMTP id p20mr4880575ilk.73.1571930521777;
 Thu, 24 Oct 2019 08:22:01 -0700 (PDT)
Date:   Thu, 24 Oct 2019 08:22:01 -0700
In-Reply-To: <Pine.LNX.4.44L0.1910241053590.1676-100000@iolanthe.rowland.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005cc1890595a998a7@google.com>
Subject: Re: divide error in dummy_timer
From:   syzbot <syzbot+8ab8bf161038a8768553@syzkaller.appspotmail.com>
To:     Jacky.Cao@sony.com, andreyknvl@google.com, balbi@kernel.org,
        chunfeng.yun@mediatek.com, gregkh@linuxfoundation.org,
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
syzbot+8ab8bf161038a8768553@syzkaller.appspotmail.com

Tested on:

commit:         22be26f7 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=5fe29bc39eff9627
dashboard link: https://syzkaller.appspot.com/bug?extid=8ab8bf161038a8768553
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14f2fda7600000

Note: testing is done by a robot and is best-effort only.
