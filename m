Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBAFAC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 12:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA6DA20700
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 12:11:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729181AbfJCMLW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 08:11:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59222 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbfJCMLV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 08:11:21 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7D4473091753;
        Thu,  3 Oct 2019 12:11:21 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.khw1.lab.eng.bos.redhat.com [10.16.200.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DE5235C226;
        Thu,  3 Oct 2019 12:11:20 +0000 (UTC)
From:   Prarit Bhargava <prarit@redhat.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, srinivas.pandruvada@linux.intel.com,
        Prarit Bhargava <prarit@redhat.com>
Subject: [PATCH v2 0/7] Add CascadeLake-N Support
Date:   Thu,  3 Oct 2019 08:11:05 -0400
Message-Id: <20191003121112.25870-1-prarit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Thu, 03 Oct 2019 12:11:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for SST-BF on CascadeLake-N support.  The CascadeLake-N
processor only support SST-BF and not other SST functionality.

v2: Updated with comments from Srinivas (use common clx_n_* function names,
common is_clx_n_platform() function call to identify CascadeLake-N)

Signed-off-by: Prarit Bhargava <prarit@redhat.com>

Prarit Bhargava (7):
  intel-speed-select: Add int argument to command functions
  intel-speed-select: Make process_command generic
  intel-speed-select: Add check for CascadeLake-N models
  intel-speed-select: Add configuration for CascadeLake-N
  intel-speed-select: Implement CascadeLake-N help and command functions
    structures
  intel-speed-select: Implement 'perf-profile info' on CascadeLake-N
  intel-speed-select: Implement base-freq commands on CascadeLake-N

 .../x86/intel-speed-select/isst-config.c      | 493 ++++++++++++------
 .../x86/intel-speed-select/isst-display.c     |  14 +-
 tools/power/x86/intel-speed-select/isst.h     |   3 +
 3 files changed, 339 insertions(+), 171 deletions(-)

-- 
2.18.1

