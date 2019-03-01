Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24911C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 12:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0AAB2084D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 12:51:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387724AbfCAMvF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 07:51:05 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:47820 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731498AbfCAMvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 07:51:01 -0500
Received: from 79.184.254.15.ipv4.supernova.orange.pl (79.184.254.15) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id 4b89f41228b79f98; Fri, 1 Mar 2019 13:50:59 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: [RFT][PATCH 0/2] cpufreq: intel_pstate: Handle _PPC updates on global turbo disable/enable
Date:   Fri, 01 Mar 2019 13:43:00 +0100
Message-ID: <9956076.F4luUDm1Dq@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

This is how I would fix the issue reported in BZ 200759 (see this patch series
from Yu too: https://marc.info/?l=linux-pm&m=155137672924029&w=2).

Patch [1/2] causes intel_pstate to update all policies if it gets a _PPC change
notification and sees a global turbo disable/enable change.

Patch [2/2] makes it update cpuinfo.max_freq for all policies in those cases.

The patches here have not been tested yet, so testing would be much appreciated.

Of course, comments are welcome too!

Thanks,
Rafael

