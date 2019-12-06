Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F24C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 01:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F370A21823
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 01:54:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbfLFByB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 20:54:01 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:39742 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfLFByB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 20:54:01 -0500
Received: by mail-io1-f72.google.com with SMTP id u13so3760186iol.6
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 17:54:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=rAeCsgZxV9UJGkBQ4eWnQ9S3cKiAG0istSYvhHhfEbE=;
        b=ZN5Drzdhf9Iv7OMJgDMihIZtUe4kMdHnrLYuZtCC+QpWt3T/r7uZfS0KkKCzNjJrfh
         KJgO03bx8t20tOx9sB1FnuRugYnFRvY87rFb8QT2m5LT/WB98Fn4kjwpX8S26gu1ncO+
         dvyWcgA8m7aqSRsOkext6ldQpkmDjeiecBms7bRSnF851IpTYVUCEQEfGoGlUEpvUWiz
         PSwotg/mfuhWBnedWPwIEUgZC3Vm70SG/KG2VCfSbce7beh06crWqTurUFSXis/Mwafx
         9UqL0Be46V0uQqOmLz1OYAAYJwu3dz0NYmEc95F88k9Q0KDcG/P+IBk+9MsBhO3VKAqW
         LZ6Q==
X-Gm-Message-State: APjAAAU8axE/FDksQ5TnLO5mhP5QAcK/hPwBb/zN8f+CHXTwXXcXGbuF
        bD9MoRDlGMmc8eBgoR03BP0EaKxIybLbBdhoFkYdp7wI67RK
X-Google-Smtp-Source: APXvYqzsPCD57qboZKu4afU8AjADTn/f/SbgP9h50QEUqO4V8Qa1IqsWP4i1pyRvC9AmRjLOlMpOdVS7zTYOkMfgGrm4fe23QH+N
MIME-Version: 1.0
X-Received: by 2002:a92:844d:: with SMTP id l74mr12309671ild.16.1575597240974;
 Thu, 05 Dec 2019 17:54:00 -0800 (PST)
Date:   Thu, 05 Dec 2019 17:54:00 -0800
In-Reply-To: <0000000000002492cc0587d58ed8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000db84550598ff519f@google.com>
Subject: Re: WARNING in ovl_rename
From:   syzbot <syzbot+bb1836a212e69f8e201a@syzkaller.appspotmail.com>
To:     amir73il@gmail.com, linux-kernel@vger.kernel.org,
        linux-unionfs@vger.kernel.org, miklos@szeredi.hu,
        mszeredi@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit 146d62e5a5867fbf84490d82455718bfb10fe824
Author: Amir Goldstein <amir73il@gmail.com>
Date:   Thu Apr 18 14:42:08 2019 +0000

     ovl: detect overlapping layers

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=138841dae00000
start commit:   037904a2 Merge branch 'x86-urgent-for-linus' of git://git...
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=a42d110b47dd6b36
dashboard link: https://syzkaller.appspot.com/bug?extid=bb1836a212e69f8e201a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15ba097ca00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10be1ceca00000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: ovl: detect overlapping layers

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
