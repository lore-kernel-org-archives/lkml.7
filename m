Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E64C17445
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 19:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1AC6204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 19:25:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbfKKTZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 14:25:02 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:46691 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbfKKTZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 14:25:01 -0500
Received: by mail-il1-f198.google.com with SMTP id i74so17807558ild.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 11:25:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=r0YjuwzIebyQaRt0NCBTzFXK/e7I0JZCjM3cB55KQAc=;
        b=i9ZLtjy6aqhFsn9asRAL4OS+ozgc+t1GJYuevRrTHu0DWSTeg/LvVsw/2Gd/cZCRYL
         vuZT6zNuLB8TpMItBy64p37nb6cilb8hyEMymvF9l7tVUkaWiqReYHCasiq9l1Ozimgh
         L7TYo/CmoEK2AgLdQyEdieWZgIJTCds19cjwa8rrJLu2eckgIsMrSy/Xm88UGsCGyeGn
         2oIdW0X7MfwB6ydGNCbsMfBlvYF8UEik+jJ+6Lq4uS0f+B3qKqPhKpWIAOjX0wHmBSR5
         wzC64FdKF8YNtLsx+pygtRjdGXME3J1xW3Iy1twmqwJYGeUVGWzOvqsjyQ9fL59KxhGy
         jrpA==
X-Gm-Message-State: APjAAAWj8KE6eSTPvGxHuuocqUR2eU5tDjNacLnaBArQgVQ53uz4RdiD
        T5k/pNY/jEBFxXdgPmIKtpwmpVmTt4jGvfmnovapqDAZ0zMN
X-Google-Smtp-Source: APXvYqwjOAd6qg8boJqVOPEwejNnAYo5toGjgZZRs/LFgnQ/swhjJf1U+XdiNVfdnQaWG3g6Y2/txbvrT0G+luva0XSkxRbbbVSf
MIME-Version: 1.0
X-Received: by 2002:a02:b792:: with SMTP id f18mr2173501jam.32.1573500300671;
 Mon, 11 Nov 2019 11:25:00 -0800 (PST)
Date:   Mon, 11 Nov 2019 11:25:00 -0800
In-Reply-To: <20191111182417.GB5165@mit.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000079c18b059717166e@google.com>
Subject: Re: general protection fault in ext4_writepages
From:   syzbot <syzbot+9567fda428fba259deba@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, jack@suse.cz, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, riteshh@linux.ibm.com,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger  
crash:

Reported-and-tested-by:  
syzbot+9567fda428fba259deba@syzkaller.appspotmail.com

Tested on:

commit:         4d06bfb9 ext4: Add error handling for io_end_vec struct al..
git tree:        
https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git test
kernel config:  https://syzkaller.appspot.com/x/.config?x=2cc209e226c8fbbd
dashboard link: https://syzkaller.appspot.com/bug?extid=9567fda428fba259deba
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Note: testing is done by a robot and is best-effort only.
