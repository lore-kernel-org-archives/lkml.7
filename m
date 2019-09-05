Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D62C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 12:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AA68206BB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 12:03:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389054AbfIEMDU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 08:03:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46548 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731486AbfIEMDU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 08:03:20 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E970C18C4271;
        Thu,  5 Sep 2019 12:03:19 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.khw1.lab.eng.bos.redhat.com [10.16.200.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 413C310001B7;
        Thu,  5 Sep 2019 12:03:19 +0000 (UTC)
From:   Prarit Bhargava <prarit@redhat.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     andriy.shevchenko@intel.com, Prarit Bhargava <prarit@redhat.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Arcari <darcari@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/9] tools-power-x86-intel-speed-select: Fixes and updates for output
Date:   Thu,  5 Sep 2019 08:03:02 -0400
Message-Id: <20190905120311.15286-1-prarit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.62]); Thu, 05 Sep 2019 12:03:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some general fixes and updates for intel-speed-select.  Fixes include some
typos as well as an off-by-one cpu count reporting error.  Updates for the
output are

- switching to MHz as a standard
- reporting CPU frequencies instead of ratios as a standard
- viewing a human-readable CPU list.
- avoiding reporting "0|1" as success|fail as these can be confusing for a
  user.

v2: Add additional patch to fix memory leak and remove help text in 8/9.

Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: David Arcari <darcari@redhat.com>
Cc: linux-kernel@vger.kernel.org

Prarit Bhargava (9):
  tools/power/x86/intel-speed-select: Fix package typo
  tools/power/x86/intel-speed-select: Fix help option typo
  tools/power/x86/intel-speed-select: Fix cpu-count output
  tools/power/x86/intel-speed-select: Simplify output for turbo-freq and
    base-freq
  tools/power/x86/intel-speed-select: Switch output to MHz
  tools/power/x86/intel-speed-select: Change turbo ratio output to
    maximum turbo frequency
  tools/power/x86/intel-speed-select: Output human readable CPU list
  tools/power/x86/intel-speed-select: Output success/failed for command
    output
  tools/power/x86/intel-speed-select: Fix memory leak

 .../x86/intel-speed-select/isst-config.c      |  21 +--
 .../x86/intel-speed-select/isst-display.c     | 120 +++++++++++++-----
 2 files changed, 98 insertions(+), 43 deletions(-)

-- 
2.21.0

