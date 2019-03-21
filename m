Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA6BEC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 17:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C765421874
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 17:39:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728793AbfCURjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 13:39:02 -0400
Received: from mail-it1-f198.google.com ([209.85.166.198]:40005 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728710AbfCURjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 13:39:01 -0400
Received: by mail-it1-f198.google.com with SMTP id f84so3000299ita.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 10:39:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=EvagYsar2Kkc1zjuncQWprBpr0l0y5Xjvax9LXSFdA8=;
        b=o20IS5fxK4qbGNhD7MTuie0nZiRXFRlhL9YZkOUBcjldUGnTt+Ue03wZLnrnQSDr8Q
         iuuX+YomHd8QHrh1r2Ze9LcJyngb35NedYHdcGWLdPDNjfIghnSDIK4eUCzSDrkjeAg4
         Nvm3kyIcjJ0Qz0RkjjTXmzArBx14GdTjqkMvZ+fIfXrCElhxHsoZtBMKSBnE3l0aQYat
         hlnd3Ka4n+1a1JOwutNpu7WldThyUeA+0AQ3iuBEvlxx6vjANUK463Zd0rTcMnw6pjhO
         EQsylJDt0WU6oGFd2QqfnWrURMagTk1LhMeGo1XaoQXpiJKQLqSfsmFeinfhJg2RtDiB
         P7KA==
X-Gm-Message-State: APjAAAVdBMkAeMiPhRTQx0bBOzcrHn7Fzpk+EvhC1ItphRmWej0ZLpnA
        YMc4pkaU9y3qqDHzjyqOFWh1PUnIUJP/IKG1tk4B2QEW82u5
X-Google-Smtp-Source: APXvYqwGEkG50ftwcqAyo6aHxRCW80LFJfjGwntx2Y9ndgan1YT3uHyGiAffzbKSOY/vYdbDDO/N0dZVJcGSPX3Uaop7IceQZLX3
MIME-Version: 1.0
X-Received: by 2002:a6b:d913:: with SMTP id r19mr3827202ioc.76.1553189941049;
 Thu, 21 Mar 2019 10:39:01 -0700 (PDT)
Date:   Thu, 21 Mar 2019 10:39:01 -0700
In-Reply-To: <00000000000014008b057a598671@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b480bc05849e3623@google.com>
Subject: Re: general protection fault in vb2_mmap
From:   syzbot <syzbot+52e5bf0ebfa66092937a@syzkaller.appspotmail.com>
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=160e9e6d200000
start commit:   [unknown
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=150e9e6d200000
console output: https://syzkaller.appspot.com/x/log.txt?x=110e9e6d200000
dashboard link: https://syzkaller.appspot.com/bug?extid=52e5bf0ebfa66092937a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14c61b0b400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=109d545d400000

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
