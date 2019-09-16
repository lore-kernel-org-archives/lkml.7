Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA49AC4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 19:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEA4621670
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 19:05:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733122AbfIPTFO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 15:05:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53112 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727947AbfIPTFO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 15:05:14 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 822C84E938
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 19:05:13 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id 32so309498wrk.15
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 12:05:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kwfy3FtDVpFu8a/shnATCDRidOaNKuHQNkUiFx1jDcM=;
        b=Lx7dnVhVZpqkmo7a/XfoMhakqjN9/LYCQzo5Uc9UN9VbkbQHCSaxKC6HjrdNBki8/8
         LchafVimqaQHAoOjUp0gL4wLgv/DqHtrVIf7mtBfg5II79/63sJ7J2Mzu7XP5DK/+AWY
         hPxucfAoxQvMbeAZY+p9PwcY8gi++NI7+FXQitu/AQe/T5to5yacvzS1YQQs6+sSDQ76
         la3pBhicOp5kcflwvuTOK7nFTbmlcDh6tKB1nBaFwLvDw+kYL9ahqly7UojTwLbV9dzw
         RnfGYHX2DLY46Dv7mwqlpXhmc4kf17Z3h6J2f+FgmmuivCxK241pHUuPgKtrm0YTq5tz
         uEkw==
X-Gm-Message-State: APjAAAWUEWwbgMOhdjyuKi7ZVC5b7ByL06MuyO462v6IvWr8lAkV69Cm
        Ab+xh5js2g26v6gjDSxw+5WenwuFlyCeaXne3bPK++ZJ29xkYRFqg9j1buVQ2DpfqK/sOjIHDRk
        5iewYw0JmtBPnFAgdaVfB7gYN
X-Received: by 2002:a7b:c353:: with SMTP id l19mr389552wmj.173.1568660712164;
        Mon, 16 Sep 2019 12:05:12 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwjQ8O1Q4vinHdly+/ODVkUYax3hDGJ/mQpu0y17JrE1oBMvSsIKQ8r2GDRzOhHstpMNTbsog==
X-Received: by 2002:a7b:c353:: with SMTP id l19mr389538wmj.173.1568660711877;
        Mon, 16 Sep 2019 12:05:11 -0700 (PDT)
Received: from t460s.bristot.redhat.com (host198-203-dynamic.18-79-r.retail.telecomitalia.it. [79.18.203.198])
        by smtp.gmail.com with ESMTPSA id c8sm24608059wrr.49.2019.09.16.12.05.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2019 12:05:11 -0700 (PDT)
Subject: [CFP] Deadline extension: Real-Time Summit 2019 Call for
 Presentations
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
To:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Clark Williams <williams@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>, Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Tommaso Cucinotta <tommaso.cucinotta@sssup.it>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Luca Abeni <luca.abeni@santannapisa.it>
References: <6c78f0b0-c124-b8b7-1cb9-7422179a8200@redhat.com>
Message-ID: <fea220fb-11ea-8ad1-0625-7bc22dc92821@redhat.com>
Date:   Mon, 16 Sep 2019 21:05:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <6c78f0b0-c124-b8b7-1cb9-7422179a8200@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Real-Time Summit is organized by the Linux Foundation Real-Time Linux (RTL)
collaborative project. The event is intended to gather developers and users of
Linux as a Real-Time Operating System. The main intent is to provide room for
discussion between developers, tooling experts, and users.

The summit will take place alongside the Open Source Summit + Embedded Linux
Conference Europe 2019 in Lyon, France. The summit is planned the day after the
main conference, Thursday, October 31st, 2019, from 8:00 to 17:00 at the
conference venue. If you are already considering your travel arrangements for
the Open Source Summit + Embedded Linux Conference Europe 2019 in Lyon, France,
and you have a general interest in this topic, please extend your travel by one
day to be in Lyon on Thursday, 31st.

If you are interested to present, please submit a proposal [1] before September
14th, 2019, at 23:59 EST. Please provide a title, an abstract describing the
proposed talk (900 characters maximum), a short biography (900 characters
maximum), and describe the targeted audience (900 characters maximum). Please
indicate the slot length you are aiming for: The format is a single track with
presentation slots of 30, 45 or 60 minutes long. Considering that the
presentation should use at most half of the slot time, leaving the rest of the
slot reserved for discussion. The focus of this event is the discussion.

We are welcoming presentations from both end-users and developers, on topics
covering, but not limited to:

 - Real-time Linux development
 - Real-time Linux evaluation
 - Real-time Linux use cases (Success and failures)
 - Real-time Linux tooling (tracing, configuration, …)
 - Real-time Linux academic work, already presented or under development, for
   direct feedback from practitioners community.

Those can cover recently available technologies, ongoing work, and new ideas.

Important Notes for Speakers:

 - All speakers are required to adhere to the Linux Foundation events’ Code of
   Conduct. We also highly recommend that speakers take the Linux Foundation
   online Inclusive Speaker Orientation Course.

 - Avoid sales or marketing pitches and discussing unlicensed or potentially
   closed-source technologies when preparing your proposal; these talks are
   almost always rejected due to the fact that they take away from the integrity
   of our events, and are rarely well-received by conference attendees.

 - All accepted speakers are required to submit their slides prior to the
    event.

Submission must be received by 11:59 pm PST on September 14th, 2019

[1] Submission page: https://forms.gle/yQeqyrtJYezM5VRJA

Important Dates:

  - CFP *WAS*: Saturday, September 14th, 2019, 11:59PM PST
  - CFP *IS*: Saturday, September 21th, 2019, 11:59PM PST
  - Speaker notification: September 25st, 2019 (was 21)
  - Conference: Thursday, October 31st, 2019

Questions on submitting a proposal?
Email Daniel Bristot de Oliveira <bristot@redhat.com>

Thanks!
-- Daniel
