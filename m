Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C43C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 19:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D322205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 19:56:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729566AbfDQT4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 15:56:01 -0400
Received: from mail-it1-f197.google.com ([209.85.166.197]:51875 "EHLO
        mail-it1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfDQT4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 15:56:01 -0400
Received: by mail-it1-f197.google.com with SMTP id y127so3626539itb.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 12:56:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=4EnWXPRDU1/SXQUQsehK72eVw6iHGNpMYvY1Rbcgl/I=;
        b=JYQ2dOVk8BTo9rpnnJ2f8MW8hOskvRwV2RgTEo9CsJ+qnpJticBwiAnP+lLRFEXUPa
         FOh4P0J8fEzpReWTEc2NoBxHYeyiSpUF9o8fE54Qf1VSY+DG6e1ScrtO9aCgmnNTE3IY
         y4JSP8YSELJxag15bBsH1lG/rpGJ2z+Ki5j/5M2CQXsvFv+58ONOZM4muuwlgPCehivM
         pwXggjpr4zoBMaii+HRcZ3vbv+yxvJ6MuEuM/5gW+LT/3KvLhGqmXK6M27zM5EsgErjn
         llhrtv7dV7CXef99H/ZPq6MdLsL6nKeeBlsNBQyXdAxDtdIrvbxAoqq8FvZ67cP4/HCM
         hP1A==
X-Gm-Message-State: APjAAAU3zzXjhYq2YnvURLzrJ/Q0VfVBYE+t5Uom+rUB9JHzzLeoFk5W
        NjOVrPV4CcJKrb47WrpXHyLYAjBz424gMPzXGUNjpjXAq7Sc
X-Google-Smtp-Source: APXvYqyXfphPPaOIWtxONYOTAnUuTpGkklcans3tSg21nOoaUgTrlyKYQUlUQ1d/fpsKgqbNYFkWsiNxx6yvQr7CC50zY83Ju4/k
MIME-Version: 1.0
X-Received: by 2002:a24:7b4f:: with SMTP id q76mr315710itc.142.1555530960395;
 Wed, 17 Apr 2019 12:56:00 -0700 (PDT)
Date:   Wed, 17 Apr 2019 12:56:00 -0700
In-Reply-To: <Pine.LNX.4.44L0.1904171503410.1400-100000@iolanthe.rowland.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000054e5e70586bf46cc@google.com>
Subject: Re: INFO: task hung in usb_kill_urb
From:   syzbot <syzbot+d919b0f29d7b5a4994b9@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, gregkh@linuxfoundation.org,
        gustavo@embeddedor.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, stern@rowland.harvard.edu,
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
syzbot+d919b0f29d7b5a4994b9@syzkaller.appspotmail.com

Tested on:

commit:         d34f9519 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan/tree/usb-fuzzer
kernel config:  https://syzkaller.appspot.com/x/.config?x=c73d1bb5aeaeae20
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12a17dfd200000

Note: testing is done by a robot and is best-effort only.
