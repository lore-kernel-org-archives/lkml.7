Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 892A2C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 13:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 641A420844
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 13:22:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbfHMNWR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 09:22:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:51696 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728536AbfHMNWR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 09:22:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4251BAD82;
        Tue, 13 Aug 2019 13:22:16 +0000 (UTC)
Message-ID: <1565702535.7043.9.camel@suse.com>
Subject: Re: KASAN: use-after-free Read in device_release_driver_internal
From:   Oliver Neukum <oneukum@suse.com>
To:     Andrey Konovalov <andreyknvl@google.com>,
        Alan Stern <stern@rowland.harvard.edu>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzbot <syzbot+1b2449b7b5dc240d107a@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>
Date:   Tue, 13 Aug 2019 15:22:15 +0200
In-Reply-To: <CAAeHK+xVKZ-pnGcijYJPpWQ_haWbuVSpD81TJhtRosOZsg-Rwg@mail.gmail.com>
References: <CAAeHK+yPJR2kZ5Mkry+bGFVuedF9F76=5GdKkF1eLkr9FWyvqA@mail.gmail.com>
         <Pine.LNX.4.44L0.1908080958380.1652-100000@iolanthe.rowland.org>
         <CAAeHK+xVKZ-pnGcijYJPpWQ_haWbuVSpD81TJhtRosOZsg-Rwg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, den 13.08.2019, 14:42 +0200 schrieb Andrey Konovalov:
> > 


[..]

> On Thu, Aug 8, 2019 at 4:00 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> > Ah, that looks right, thank you.  The patch worked correctly -- good
> > work Oliver!
> 
> Great! Just a reminder to submit the fix :)

I did last week:
https://patchwork.kernel.org/patch/11084261/

	Regards
		Oliver

