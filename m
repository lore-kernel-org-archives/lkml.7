Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_DIGITS,
	FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BEA3C04AAA
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 10:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D7532087F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 10:16:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbfECKQG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 06:16:06 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:35341 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbfECKQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 06:16:06 -0400
Received: by mail-io1-f71.google.com with SMTP id h10so4118298iob.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 03:16:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=ksZiUycHQUU5gaMM+swJiiJAczcg7RX7RdnQSdhRCek=;
        b=j9D5+oOk4RlYpk0T4TsE2KH8aOO4IoMtLLwfdaZmmRT3M65NAsvyClBybcFtxLWeds
         Re8Cbx6oSeubjpCdxemz29LSPxyXJoK79JHUF0+9DvugqCs4vZIPOGPCG+e2hHJryCP+
         WlzErpELzvm+7DYrLg9jenVDI54R4SFWibwmFsWC9qMSeA/UnjZ8fSdgNCRdDyChSC44
         DWIBcpccGanXs8KRArnMZ5RF6DGL5TftWZJVHiK7ms9n0RM0NmtKZgl04S1P9qC7QYHv
         6mHnU+s3gwybRBVkMb0VWN/bU+3sRQPQ4rVL6jBHJW8jQMwLC3LLPgBy7mgyBCtHk2GN
         Nsfw==
X-Gm-Message-State: APjAAAVlE25DmBedbHI9VOaUgtgTU3je43m+bY8RL5MCsYybrTIEYXHa
        NuNVw4l32xcsW4nbLZDB8sweIR2elahYFBy21Rud1aoovi92
X-Google-Smtp-Source: APXvYqy4HCDetetZ/MKz0/4sqoObInvZQcLO6v7qu4qICZHOauUnCv5FVa1RLnzhrK6Gc6y3A1FXGqK6CQ75w+SjuILMJV2PZ0AW
MIME-Version: 1.0
X-Received: by 2002:a02:a402:: with SMTP id c2mr6320642jal.13.1556878565206;
 Fri, 03 May 2019 03:16:05 -0700 (PDT)
Date:   Fri, 03 May 2019 03:16:05 -0700
In-Reply-To: <00000000000014285d05765bf72a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d6796c0587f9097c@google.com>
Subject: Re: BUG: unable to handle kernel paging request in do_mount
From:   syzbot <syzbot+73c7fe4f77776505299b@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        sabin.rapan@gmail.com, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This bug is marked as fixed by commit:
vfs: namespace: error pointer dereference in do_remount()
But I can't find it in any tested tree for more than 90 days.
Is it a correct commit? Please update it by replying:
#syz fix: exact-commit-title
Until then the bug is still considered open and
new crashes with the same signature are ignored.
