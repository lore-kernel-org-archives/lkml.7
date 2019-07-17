Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20822C76192
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 12:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00CEB20880
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 12:07:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730908AbfGQMHB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 08:07:01 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:37915 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbfGQMHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 08:07:00 -0400
Received: by mail-io1-f69.google.com with SMTP id h4so26966290iol.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 05:07:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=XMiM4VhhNGMXt1YUP9hYUP+H6sfTtdLHWoBTL1ud0JA=;
        b=TWxL428Uct6WX+uLJCATWX8LXROw3s/JHz5QRP0DZq1Xq06wTuqD9xhy+XYXiw1lyM
         kPx8UIvP3jDZYOU11wYna5xci7/K4tKJBBFEJz4TCZcx0IckQpR7bBwP0q9Kv3mqWQPd
         +Q0ScWjKYoJwxNk1pYFxei3AOUY4GGuYeFaD5d2Yh+s8EybXNP+27YKuLY8y9XqTJsKR
         CALapwneVR2oF+Jw9ZC9HPmYQpHj2Iz75ePH0Rao+zaph5Mlt5RUxuntEKASTlo2KjIb
         oWBH3MjTv6zx9scH72KY9NuAc2RpRBwfkxhSPG0WMn8q8KREaKWXYidfbCIu4CSfhD6c
         35ag==
X-Gm-Message-State: APjAAAWS3E/Ci7mfsJObv2wExpZ28ZNS9WeTQROeQkMa6S/zAF6aMCv+
        ia2/Km6dx+pvgGC3OS6w4knMcbOvOIqdpDePNZ5FCD4ua0ai
X-Google-Smtp-Source: APXvYqzJDIa9bplYl+1WI2lx91wpvWCo7zcTm57mmmA3Rf0j84ecemM7YLsQPb+m1xJjo13foqByIr28LUi38D216xL3GGJaASl1
MIME-Version: 1.0
X-Received: by 2002:a02:bca:: with SMTP id 193mr1412225jad.46.1563365220270;
 Wed, 17 Jul 2019 05:07:00 -0700 (PDT)
Date:   Wed, 17 Jul 2019 05:07:00 -0700
In-Reply-To: <CAAeHK+x4KAy2koonjij26iowtPuj67F=Mx+g0kYF968Zr-h8xg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009bc9b3058ddf5401@google.com>
Subject: Re: WARNING in gpio_to_desc
From:   syzbot <syzbot+cf35b76f35e068a1107f@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, bgolaszewski@baylibre.com,
        cuissard@marvell.com, johan@kernel.org, linus.walleij@linaro.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, sameo@linux.intel.com,
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
syzbot+cf35b76f35e068a1107f@syzkaller.appspotmail.com

Tested on:

commit:         6a3599ce usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git usb-fuzzer
kernel config:  https://syzkaller.appspot.com/x/.config?x=d90745bdf884fc0a
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=126cd1a4600000

Note: testing is done by a robot and is best-effort only.
