Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA66C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B85222147C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:25:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbfCKUYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 16:24:50 -0400
Received: from mga11.intel.com ([192.55.52.93]:56129 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728171AbfCKUYt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 16:24:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2019 13:24:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,468,1544515200"; 
   d="scan'208";a="281727412"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga004.jf.intel.com with ESMTP; 11 Mar 2019 13:24:48 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 9BDFC301E30; Mon, 11 Mar 2019 13:24:48 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     jolsa@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Misc improvements and bug fixes for perf
Date:   Mon, 11 Mar 2019 13:24:36 -0700
Message-Id: <20190311202446.10210-1-andi@firstfloor.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mostly unrelated to each other, so can be picked'n'chosed.

- Fix perf stat --no-scale
- Support --reltime in perf script
- Fix crashes with stat -r
- Handle JITed code better in perf report
- Allow to limit rotated perf.data files
- Filter metrics in perf list
- Show all sort keys in perf report help
- Fix multiplexing formula

Also available in
git://git.kernel.org/pub/scm/linux/kernel/git/ak/linux-misc perf/misc-fixes-4

