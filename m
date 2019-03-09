Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F77AC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 00:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7143F20857
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 00:03:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbfCIAD6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 19:03:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:56086 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726302AbfCIAD6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 19:03:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9E0B2AC61;
        Sat,  9 Mar 2019 00:03:56 +0000 (UTC)
From:   Tony Jones <tonyj@suse.de>
To:     linux-kernel@vger.kernel.org
Cc:     linux-perf-users@vger.kernel.org, acme@kernel.org,
        Tony Jones <tonyj@suse.de>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Subject: [PATCH v3 0/4] perf script python: add Python3 support
Date:   Fri,  8 Mar 2019 16:05:14 -0800
Message-Id: <20190309000518.2438-1-tonyj@suse.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is v3 of my version of the patchset.  

The exporter and viewer changes were all in one patch for V2. 
For V3 I split them into 3 patches for the reasons below.

Patch#1 adds Python3 support to exported-sql-viewer 
Patch#2 adds Python3 support to export-to-postgresql
Patch#3 adds Python3 support to export-to-sqlite 
Patch#4 cleans up some repeated use of date functions in the code.

I added Adrian's signed-off-by to Patch#2 per the revised patch he sent 
in his review of V2.

The content of patches 1, 3 and 4 is unchanged from V2 but I'm including 
all the patches again to hopefully make your application easier. I added 
Adrian's Acked-by to Patch#4 per his review of that patch in V2.

Once these are applied I believe this is everything needed to run on a
system without Python2.

Thanks

Tony
