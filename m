Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD4BC282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 20:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B40A217FA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 20:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbfDSURB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 16:17:01 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:57326 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbfDSURB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 16:17:01 -0400
Received: by mail-io1-f72.google.com with SMTP id s184so5394178iod.23
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 13:17:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=My6TLiUyIB4RpVyrnFfTz4dPloCToKlSYn2hrxlbJP8=;
        b=HmPHLeWC/rA9+9JHzvw8+85JY1Eq3jzeB1NiP0FC28VNrntn78sL9asvziNTjoknC0
         a7W7Owj1uhVK0nOlbByn7ajttfuUpZqFl57UHuPJoqq/m3RcmEaWvb7JsH9df1O/pFhI
         TtBmj0vd0FAIy+HxtCrRFCzgsP/sD455kea1BvMY5jhXLhy6IMNeDKHhcZnrpZ3QR4en
         8wbi4dM/zP7iE1g8epWQBuiDF7hJIwQkQzH5eLkTFRZx2A/Ze8C2CqMUTD/0WlNQPNGp
         kFm04M74wuuU4pclpjdtbhrsvvzrMzsQpnlQ99jgBHrXMBln5HjTCBTP+JsbHcphdYjO
         VVKg==
X-Gm-Message-State: APjAAAXy+xKbY8CQpuQyzsuz9/Vh1KEUembeULIGsHe9CIadzlkkn9ZP
        +AYl8Ex3tlSP9DFlKhauzJybG1ScQlHi5uUC+0pWnG3F0gkg
X-Google-Smtp-Source: APXvYqx8KuFa/vJu6es15l/7LDOmqu5Y8zPXTq0Us9V+5WFGcfbA3aMs5K1XJlogv/KQMl9ZqOG+zSoyf9Vx2+2VuLiNenb/2R0q
MIME-Version: 1.0
X-Received: by 2002:a24:46cc:: with SMTP id j195mr4418112itb.161.1555705020776;
 Fri, 19 Apr 2019 13:17:00 -0700 (PDT)
Date:   Fri, 19 Apr 2019 13:17:00 -0700
In-Reply-To: <Pine.LNX.4.44L0.1904191536310.1406-100000@iolanthe.rowland.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002385b50586e7cddb@google.com>
Subject: Re: KASAN: slab-out-of-bounds Read in ds_probe
From:   syzbot <syzbot+d65f673b847a1a96cdba@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, florian.harbecke@fau.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, passt@h-hofmeier.de,
        stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com,
        zbr@ioremap.net
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger  
crash:

Reported-and-tested-by:  
syzbot+d65f673b847a1a96cdba@syzkaller.appspotmail.com

Tested on:

commit:         d34f9519 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan/tree/usb-fuzzer
kernel config:  https://syzkaller.appspot.com/x/.config?x=c73d1bb5aeaeae20
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1588b96b200000

Note: testing is done by a robot and is best-effort only.
