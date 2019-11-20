Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02995C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 23:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0DD1206D8
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 23:00:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbfKTXAB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 18:00:01 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:38421 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfKTXAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 18:00:01 -0500
Received: by mail-il1-f197.google.com with SMTP id f6so1128446ilg.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 15:00:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=ypoFC5Ro1whWyZkoNTFbjCm62awQmvPA/XY3KWGTpeY=;
        b=jhhh+8l6X6jE/8QKD/8nK9bXzfyZ2qAz91eT5v4c8yEHUygWM5qpWqvXRGXom9Hgs2
         nZMX2+AZEPDwLhSVyY/xU//F91vsGwXrnPsk/z+03ucg2xsRZa6tCcqr6F5+NicNw1h+
         WPHnTZukowdbiqw07QFnYmrXMVOvi4p/4PqJ+THasIxLSBtkhqBtFD6bYS5VBHluhudY
         aGcEfZwdB1ZojVXRzsrZbbUvqc1eXASPVp+/xQeIAQrg00CeJq+0bIrXWqyyIBfB02lt
         9VrkSsHgMWVLBSIapMWm0LRNjfwqKYUg5+dqHC1T+3GgwMQXw2VsEpInrR7Uv5oN05VA
         caXQ==
X-Gm-Message-State: APjAAAWi6IIcwqQXpsgQ0YGHx+nexikDKN6W6vJMuGK1FpWAM5TDZvlM
        2l46O3sAO5IkfabYkPVrPFscOy3xQcRVJC2cw/ekND/BLBGl
X-Google-Smtp-Source: APXvYqyofe8WhECLKlKXZgBJZBsZrYVm/t+Y8eRSVSR0U/8UgoTSuC2z2cvX43ZBQGe1osg94jcabQYUuLJ1jeNst5ogvlPqNJZy
MIME-Version: 1.0
X-Received: by 2002:a92:1705:: with SMTP id u5mr6454619ill.151.1574290800348;
 Wed, 20 Nov 2019 15:00:00 -0800 (PST)
Date:   Wed, 20 Nov 2019 15:00:00 -0800
In-Reply-To: <1574170553.28617.10.camel@suse.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ed95090597cf2395@google.com>
Subject: Re: WARNING in ath6kl_htc_pipe_rx_complete
From:   syzbot <syzbot+555908813b2ea35dae9a@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, davem@davemloft.net, kvalo@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        oneukum@suse.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger  
crash:

Reported-and-tested-by:  
syzbot+555908813b2ea35dae9a@syzkaller.appspotmail.com

Tested on:

commit:         d60bbfea usb: raw: add raw-gadget interface
git tree:       https://github.com/google/kasan.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=79de80330003b5f7
dashboard link: https://syzkaller.appspot.com/bug?extid=555908813b2ea35dae9a
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=125c855ae00000

Note: testing is done by a robot and is best-effort only.
