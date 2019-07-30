Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA0DAC32750
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 22:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E5A6205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 22:17:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729070AbfG3WR6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 18:17:58 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:60241 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727221AbfG3WR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 18:17:58 -0400
Received: from 79.184.255.110.ipv4.supernova.orange.pl (79.184.255.110) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.275)
 id 0ed09bd7b97d5494; Wed, 31 Jul 2019 00:17:56 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Tri Vo <trong@android.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Hridya Valsaraju <hridya@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v5] PM / wakeup: show wakeup sources stats in sysfs
Date:   Wed, 31 Jul 2019 00:17:55 +0200
Message-ID: <2085893.cJkfNvi94x@kreacher>
In-Reply-To: <5d4090ea.1c69fb81.d5cab.4dcd@mx.google.com>
References: <20190730024309.233728-1-trong@android.com> <CANA+-vBKg_W88Oy_wJs1NNYaZ2ciJKO=Mrs47etYTDNXUKW9Uw@mail.gmail.com> <5d4090ea.1c69fb81.d5cab.4dcd@mx.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, July 30, 2019 8:48:09 PM CEST Stephen Boyd wrote:
> Quoting Tri Vo (2019-07-30 11:39:34)
> > On Mon, Jul 29, 2019 at 10:46 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > On Tue, Jul 30, 2019 at 4:45 AM Tri Vo <trong@android.com> wrote:
> > > > - Device registering the wakeup source is now the parent of the wakeup source.
> > > >   Updated wakeup_source_register()'s signature and its callers accordingly.
> > >
> > > And I really don't like these changes.  Especially having "wakeup"
> > > twice in the path.
> > 
> > I can trim it down to /sys/class/wakeup/<ID>/. Does that sound good?
> 
> Using the same prefix for the class and the device name is quite common.
> For example, see the input, regulator, tty, tpm, remoteproc, hwmon,
> extcon classes. I'd prefer it was left as /sys/class/wakeup/wakeupN. The
> class name could be changed to wakeup_source perhaps (i.e.
> /sys/class/wakeup_source/wakeupN)?

Alternatively /sys/class/wakeup/wsN




