Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3442CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 19:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 829EB20684
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 19:16:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394207AbfJXTQC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 15:16:02 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:41673 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390636AbfJXTQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 15:16:02 -0400
Received: by mail-io1-f69.google.com with SMTP id s19so6425676ioe.8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 12:16:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=oWvayPa8/qITxDBwdBc/3IWa6QYEf1QCLunKd9Be+j0=;
        b=aGBkr0Jd9PXdVFqH4eTmwzDvTrGSbrpjgKlaOfuGpnZOhHfTJmLYQqimx1no+psu7L
         +ovGgoGLK2McoEh2AjiDA0+5pyJubNeECSen1gaxUn3pkQdxFoFNorornpuo3hSNua2M
         CxxWLITYzlLomUNUSOziSNnjUJ833xWRToqad6/hbO0R9WOD3WMMTj3r8x0buADFpUti
         JKOQGmdk3Cpx96FBl7N0D9csjrv4FzwPcfo0A8kVjxy5vKIFq3rn/sU/VSjE1is4gEWi
         iyIeClZZrJ9i6nwLLV4dmrOqBoVp0L4JUtMl6Ih7mvJ8BcGh2w9uS8U/vVErCXy1LqFH
         oN2w==
X-Gm-Message-State: APjAAAVJ8dG0LftoNfVZxcP5fHBC9r35jSgKV+AFE6IclVw/hPBi7oXB
        UnobeBuZCcRECdRSzYXa2HGOelsfp8uvk1BNnTJEDvLa5xdm
X-Google-Smtp-Source: APXvYqwe8GT6GAjZs6JEFcWMgn/Q7D3kSdYBY7PBs66z7ClA63d8QJwXcvJHy94nUGaZ4jACfdU6/DHtdIbwE739i+P9yBfsp6or
MIME-Version: 1.0
X-Received: by 2002:a02:8585:: with SMTP id d5mr3599919jai.128.1571944561419;
 Thu, 24 Oct 2019 12:16:01 -0700 (PDT)
Date:   Thu, 24 Oct 2019 12:16:01 -0700
In-Reply-To: <Pine.LNX.4.44L0.1910241419210.1318-100000@iolanthe.rowland.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000030af530595acdd8b@google.com>
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
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17f50728e00000

Note: testing is done by a robot and is best-effort only.
