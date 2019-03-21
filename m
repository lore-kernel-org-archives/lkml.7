Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD7D8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 22:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2B4D21917
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 22:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfCUWWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 18:22:36 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:49296 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfCUWWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 18:22:33 -0400
Received: from 79.184.255.210.ipv4.supernova.orange.pl (79.184.255.210) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id ed532b4373550590; Thu, 21 Mar 2019 23:22:31 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     x86 <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Laura Abbott <labbott@fedoraproject.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Simon Schricker <sschricker@suse.de>,
        Borislav Petkov <bp@suse.de>, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 0/2] PM / arch: x86: MSR_IA32_ENERGY_PERF_BIAS handling fixes and sysfs i/f
Date:   Thu, 21 Mar 2019 23:12:53 +0100
Message-ID: <1637073.gl2OfxWTjI@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

This is a resend of https://patchwork.kernel.org/patch/10862699/ (with minor
modifications) plus additional patch to add a sysfs attribute for accessing
the EPB (as requested by Boris).

Thanks,
Rafael

