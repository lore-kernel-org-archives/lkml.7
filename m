Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8266CC3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 11:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55F932070C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 11:27:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388436AbfIEL1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 07:27:01 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:49666 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfIEL1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 07:27:01 -0400
Received: by mail-io1-f70.google.com with SMTP id j23so2783906iog.16
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 04:27:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=7woNlVISujRJGF9f7Yv9hP0vcjuDeQlRJErmR/nep/s=;
        b=npyD7RMFcSfqSBSxR+n/FvbwA0lYS1jNQIhWRcyTmsu6iPZwAdpRd77tNoPrNM+DZB
         wmyJgqydQlYEPlqThAnOkF+ohZKQyAo1YI4ctHJ6WnhAcY+QhoHtaP1nU8X2C1Ze63Tl
         88OyJcyHLISf3ExVOD1S+UXDRcmfwYvQPZUA0Je2AwvEIt58B6Q8XQmpn5hBoIEcmA5H
         /ateAwJOIVQmfbluyebWY7WjKE1hU0OuCyeEHbNsWAemt45zDsSGpvuugWbWwsWCAdHt
         TCtqYQbwrjpDYGE77aERtmkjYazBMY+fYq22cP4TrfJkI1lrrb2HbQQ7J+anQ1tCmUhO
         +89A==
X-Gm-Message-State: APjAAAUSDBiVKhPxOKXOfDkR9wza4/YoErcTldTgKN32Qyz2gpvMWUvS
        3moFSaFt1ihXWlRVxQIovW4p+zQwiO3cAg1jusViwyxhGSfj
X-Google-Smtp-Source: APXvYqzrPWl90MY6xFLW6kE5r7FYbX5PnvVkgsNXXwiFcVSlOrXw4c1TUHRlr2M/2Ww7NwqWIs7UZ4UFqMX/6zQlqsJJFcJYxnZm
MIME-Version: 1.0
X-Received: by 2002:a02:9a12:: with SMTP id b18mr3575178jal.70.1567682820439;
 Thu, 05 Sep 2019 04:27:00 -0700 (PDT)
Date:   Thu, 05 Sep 2019 04:27:00 -0700
In-Reply-To: <CAAeHK+xJrv1hCbO5qOGTBu=c8STo+-obatOGZ4cHkbuhqmEvrg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a2044d0591cc99b2@google.com>
Subject: Re: WARNING: ODEBUG bug in usbhid_disconnect (2)
From:   syzbot <syzbot+14b53bfeb17f2b210eb7@syzkaller.appspotmail.com>
To:     Roderick.Colenbrander@sony.com, andreyknvl@google.com,
        benjamin.tissoires@redhat.com, jikos@kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
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
syzbot+14b53bfeb17f2b210eb7@syzkaller.appspotmail.com

Tested on:

commit:         eea39f24 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=d0c62209eedfd54e
dashboard link: https://syzkaller.appspot.com/bug?extid=14b53bfeb17f2b210eb7
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12b6944e600000

Note: testing is done by a robot and is best-effort only.
