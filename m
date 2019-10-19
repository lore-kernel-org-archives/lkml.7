Return-Path: <SRS0=/uHP=YM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E16CA9EAC
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 07:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3229222C5
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 07:41:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbfJSHlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Oct 2019 03:41:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39390 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726192AbfJSHlQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Oct 2019 03:41:16 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9660C8553A;
        Sat, 19 Oct 2019 07:41:16 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 814B460600;
        Sat, 19 Oct 2019 07:41:16 +0000 (UTC)
Received: from zmail17.collab.prod.int.phx2.redhat.com (zmail17.collab.prod.int.phx2.redhat.com [10.5.83.19])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id D7D7318089DC;
        Sat, 19 Oct 2019 07:41:15 +0000 (UTC)
Date:   Sat, 19 Oct 2019 03:41:15 -0400 (EDT)
From:   Jan Stancek <jstancek@redhat.com>
To:     ammy.yi@intel.com, alexander.shishkin@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, LTP List <ltp@lists.linux.it>,
        acme@redhat.com, jolsa@redhat.com, peterz@infradead.org,
        eranian@google.com, tglx@linutronix.de, vincent.weaver@maine.edu,
        mingo@kernel.org, Jan Stancek <jstancek@redhat.com>
Message-ID: <1311286607.7121481.1571470875734.JavaMail.zimbra@redhat.com>
In-Reply-To: <1953570088.7121417.1571470108567.JavaMail.zimbra@redhat.com>
Subject: [bug?] LTP pt_test failing after 38bb8d77d0b9 "perf/x86/intel/pt:
 Split ToPA metadata and page layout"
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.17.163, 10.4.195.8]
Thread-Topic: LTP pt_test failing after 38bb8d77d0b9 "perf/x86/intel/pt: Split ToPA metadata and page layout"
Thread-Index: j9qJ/TG5JAarLcJjLYhfq641vXqALw==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Sat, 19 Oct 2019 07:41:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

All variants of pt_test:
  https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/tracing/pt_test/pt_test.c
started failing after:
  38bb8d77d0b9 ("perf/x86/intel/pt: Split ToPA metadata and page layout")

with following error on console/dmesg:
  pt: ToPA ERROR encountered, trying to recover

on Broadwell-EP:

vendor_id       : GenuineIntel
cpu family      : 6
model           : 79
model name      : Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz
stepping        : 1

Regards,
Jan
