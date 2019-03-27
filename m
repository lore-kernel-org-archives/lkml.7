Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C49C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 15:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F57D206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 15:18:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729460AbfC0PSC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 11:18:02 -0400
Received: from mail-it1-f197.google.com ([209.85.166.197]:56387 "EHLO
        mail-it1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727993AbfC0PSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 11:18:02 -0400
Received: by mail-it1-f197.google.com with SMTP id s21so279573ite.6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 08:18:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=gRTWyAht0d0WL/ebEkUSaYWoBqNTnoVEKA+EwcfXXyQ=;
        b=Jg1UIBaF2IlhzRZNOh3UoLfv3XIMkNYmWbBO+NDrkOM9xRWUbBLnZokL6ppCQ9ajq3
         Bnp04SBhiK+KfoMJZRE7//O5JBip4WNbA7p+79I6ia9rAo+HIQvzcDqOvbQZKJ0AUBbw
         wG7URUtojnMZeVX2GH0BRoQrVIhuiHucHyEvSh8p/Jaf4GFgjm+AHxo77ItNIE1TbH3l
         ZmrA3qY7nwMIJeVjwKJmOH9+Jz3ELvBdPBeeYJJPd9smPCMLq0WE4zCUDqLhPFK2egPu
         HKHT3+RgwuyH3rSIiIqH66fZrGhBU4C8he55t/CeGECJKEQOnCGhjlU2gzdMepZgokny
         TRFQ==
X-Gm-Message-State: APjAAAXdgVKYpPLXV+CiWAkIYljZVVdb8eS+eShvATVgQou9zCtLzZWl
        goLQGfj3HFQipRSGg5aYP1o0HxnB974YWtBAHQfZPbha5AbJ
X-Google-Smtp-Source: APXvYqxSv0nfF3Eyfafo8C2XuPD3N2H1QtondQuZ1Htz7OCxMn8QKWDH0PD1CQ7JLQ4GWxgzdrIVQo6Wpzt5pVRHU+N7KmElQe6w
MIME-Version: 1.0
X-Received: by 2002:a24:4c82:: with SMTP id a124mr841689itb.26.1553699881562;
 Wed, 27 Mar 2019 08:18:01 -0700 (PDT)
Date:   Wed, 27 Mar 2019 08:18:01 -0700
In-Reply-To: <CAOQ4uxgUNDTWvFzFJR_OENBZ_hYtwLGHem_yUd406hr7f5QX+g@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008738e9058514f19c@google.com>
Subject: Re: possible deadlock in acct_pin_kill
From:   syzbot <syzbot+2a73a6ea9507b7112141@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, amir73il@gmail.com,
        gregkh@linuxfoundation.org, kstewart@linuxfoundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, mszeredi@redhat.com, oleg@redhat.com,
        paulmck@linux.vnet.ibm.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger  
crash:

Reported-and-tested-by:  
syzbot+2a73a6ea9507b7112141@syzkaller.appspotmail.com

Tested on:

commit:         6c66f635 kernel/acct.c: fix locking order when switching a..
git tree:       https://github.com/amir73il/linux.git acct_pin_kill_deadlock
kernel config:  https://syzkaller.appspot.com/x/.config?x=bd771c0a1616f2b7
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Note: testing is done by a robot and is best-effort only.
