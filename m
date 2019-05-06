Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C41C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 21:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57C14206BF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 21:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfEFVVB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 17:21:01 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:49460 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbfEFVVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 17:21:01 -0400
Received: by mail-io1-f70.google.com with SMTP id e129so1935342iof.16
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 14:21:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=3WXXuM4jc1H6fTU0L4fqfM+2De6q8C/mSZo5MFiBbqA=;
        b=M89zXrrbk/mkTA/NoDcEs040jvIVhcuv1nKTEdNHqFIxDaPjkX4y2EyfR2TstAPiND
         JeIYVwSQBq3IpbeDTVRdqYRNWy44l+pHlbjhbNuVUfBp75kOKifvuoS+wXI/SdiFqzvF
         ZNKJ4eFE6Ydep1OwRYvNUavVwsZ2FS2hosuxQE+okflrUkSEXNnc6bLFFg3CWcctx+t7
         xqogD/ZAHP8vrUoxWujVS8zq2jmZtKOpXTDub/oNfRIq67HUXp4dDeZ+UvSJvho6Z7VJ
         WdJ2K4KOPq6z0Z51Kg0cvCipHSXypXSSgTGq0YxCf8VTI7K/vfAeqk50hOFahsejpMKH
         sLaw==
X-Gm-Message-State: APjAAAWfhX+R1oI7SJHYq2Ch0QaAaXN/PmEj91ywCOys+A3Li68Fj7CV
        Lr5Jdf7jPrlls8/xqCves8yYtFSLn7EsmYoxLQYffcaW1ZyA
X-Google-Smtp-Source: APXvYqznI2fnTDVloYMj/zQyCyUvoYQHrX8gdFMohsJBIw//BIN2L+HbvAMaPk6Zg0MMg16PBeg2Lyhg/NYzxVv35PxgqwHFjqAP
MIME-Version: 1.0
X-Received: by 2002:a6b:f701:: with SMTP id k1mr18203142iog.240.1557177660211;
 Mon, 06 May 2019 14:21:00 -0700 (PDT)
Date:   Mon, 06 May 2019 14:21:00 -0700
In-Reply-To: <Pine.LNX.4.44L0.1905061638380.1585-100000@iolanthe.rowland.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004a08f805883ead54@google.com>
Subject: Re: general protection fault in smsusb_init_device
From:   syzbot <syzbot+53f029db71c19a47325a@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-usb@vger.kernel.org,
        mchehab@kernel.org, stern@rowland.harvard.edu,
        syzkaller-bugs@googlegroups.com, wen.yang99@zte.com.cn
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger  
crash:

Reported-and-tested-by:  
syzbot+53f029db71c19a47325a@syzkaller.appspotmail.com

Tested on:

commit:         43151d6c usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git usb-fuzzer
kernel config:  https://syzkaller.appspot.com/x/.config?x=274aad0cf966c3bc
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12c3fda4a00000

Note: testing is done by a robot and is best-effort only.
