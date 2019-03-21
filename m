Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 893BBC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 17:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6909C2190A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 17:39:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbfCURjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 13:39:22 -0400
Received: from mail-it1-f199.google.com ([209.85.166.199]:39089 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728711AbfCURjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 13:39:01 -0400
Received: by mail-it1-f199.google.com with SMTP id e124so2999430ita.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 10:39:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=ltum6L1yStqaszX+G3ATCwsEMnljdk7XwCw4LQxUuso=;
        b=hP3R0nTDB7C42HO1bAuFUqMknbyq5aTgb+wc6yRXK/Z8scegc8SydYFFShu6toEjRT
         oWw5xFBDVLjIHPLtDRzZYLAPquVbRgtcScrR8K0UTEKC0mnhz2CiLfuBoi4fibbQaQfY
         n92kQnNuEytvLuwUs7ArD7ZHO2V792e1VZ031FV6mZxBnaaQDa+hGjS1Y3tzvBEnt9zV
         W1jBWWn0J8EqBMnDINOGQoGL+POkxVi7k0CBVmqaUeSPa4mbQxPpPuQvFj5URjHcALxg
         OYTdKMBsrar7bbHGeob3N62OwWAaH3eE1+kfZjKoZK1Ad7qkoNNRF0Jlsr5hHbmL1Y4L
         qTig==
X-Gm-Message-State: APjAAAVPgDbjYJkAcBHKtsyMIpsTZ/YCBY/kPUBfCEEHXNKuJOp/t//L
        wZ8vKeNkKcYc2hXy08afT7Co2S/3lvS7Z/CEu8WXSu3YWnDq
X-Google-Smtp-Source: APXvYqwmWXGhIPxuo2dx4extPBJ7l9tAksm0/QEkCzNO94Y6Oga2FGi+fbiune3/sMrwpq9tWEUrL4tMPZpal6LsUhEvlZ7JgQiO
MIME-Version: 1.0
X-Received: by 2002:a02:6610:: with SMTP id k16mr3733083jac.40.1553189941229;
 Thu, 21 Mar 2019 10:39:01 -0700 (PDT)
Date:   Thu, 21 Mar 2019 10:39:01 -0700
In-Reply-To: <00000000000057e614057a9abcd3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b73f7005849e3600@google.com>
Subject: Re: KASAN: null-ptr-deref Read in refcount_sub_and_test_checked (2)
From:   syzbot <syzbot+0468b73bdbb243217224@syzkaller.appspotmail.com>
To:     kyungmin.park@samsung.com, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, m.szyprowski@samsung.com,
        mchehab@kernel.org, pawel@osciak.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bisection is inconclusive: the bug happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13b0323b200000
start commit:   [unknown
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1070323b200000
console output: https://syzkaller.appspot.com/x/log.txt?x=17b0323b200000
dashboard link: https://syzkaller.appspot.com/bug?extid=0468b73bdbb243217224
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16d20893400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=118f5a2b400000

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
