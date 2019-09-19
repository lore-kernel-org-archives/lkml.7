Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D9DC49ED7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 21:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6362821920
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 21:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393081AbfISVoC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 17:44:02 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:41234 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393063AbfISVoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 17:44:02 -0400
Received: by mail-io1-f69.google.com with SMTP id e6so7182089ios.8
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 14:44:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=yEs1UwveOrP6VjU/fAh6wyu6LjB9vVuyXL6rSiyP6zU=;
        b=pzi7W3wi1nlpL3Y2udVkW/vqkEwOZHFucPcB+kTyYSDzvZTrumyD2AVPGvQEUSWd5z
         bjiVFUDnD5wDST/SDV8unMzqN3olw8gzqHb5tQuR29TiQcqLeW/CTTGX17kmRZf476s9
         UwGyEK6s8axSCWMk5a3rOT/WAYRzqXccBrlDqvnp/SSwSJUv86VBcLYgY+98Zht3Ilxi
         4uirz26sYfGnOeV654kKUAfLSb+GGV5XyZp5/hzKavHNY9mNDV0A4FpPcCBMND7nDU4a
         HnSr+9W4HAff4twVQY/UxctkkQa2yS0RtzMX3R6nZBha9RLX53/o3CZ54cIrjmWrHM6h
         DZiQ==
X-Gm-Message-State: APjAAAVWLvFCspeY3wRouHscxElYY0VX+nboeXwHpYl3n2Xr2Vst3Zoi
        qVXgx31rYb4CLOEmyFQ7E0ZRMDmUB7tbVc5fXarXQxTUGCHP
X-Google-Smtp-Source: APXvYqw2hQR/pwi5ryAv1HCXJiPZ/O5hVSBudpO5gICFlcpzbBz0L/f2WlJxvYj/ovoUgk6kpcJ2496qwtfpyUxDTFo4PT8xFsS0
MIME-Version: 1.0
X-Received: by 2002:a6b:c409:: with SMTP id y9mr13734939ioa.155.1568929440387;
 Thu, 19 Sep 2019 14:44:00 -0700 (PDT)
Date:   Thu, 19 Sep 2019 14:44:00 -0700
In-Reply-To: <Pine.LNX.4.44L0.1909191639240.6904-100000@iolanthe.rowland.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f8d8a10592eed95f@google.com>
Subject: Re: KASAN: invalid-free in disconnect_rio (2)
From:   syzbot <syzbot+745b0dff8028f9488eba@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        miquel@df.uba.ar, rio500-users@lists.sourceforge.net,
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
syzbot+745b0dff8028f9488eba@syzkaller.appspotmail.com

Tested on:

commit:         e0bd8d79 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=8847e5384a16f66a
dashboard link: https://syzkaller.appspot.com/bug?extid=745b0dff8028f9488eba
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15b3efc3600000

Note: testing is done by a robot and is best-effort only.
