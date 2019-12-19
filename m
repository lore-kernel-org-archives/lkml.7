Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC07C2D0C1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 14:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B32424672
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 14:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbfLSO36 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 09:29:58 -0500
Received: from mga02.intel.com ([134.134.136.20]:3231 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726878AbfLSO36 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 09:29:58 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Dec 2019 06:29:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,332,1571727600"; 
   d="scan'208";a="210474228"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by orsmga008.jf.intel.com with ESMTP; 19 Dec 2019 06:29:46 -0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     linux-pm@vger.kernel.org
Cc:     Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 0/2] Add turbostat support for two platforms
Date:   Thu, 19 Dec 2019 22:28:44 +0800
Message-Id: <20191219142844.9924-1-yu.c.chen@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for TigerLake and Icelake Server.

Chen Yu (2):
  turbostat: add support for TigerLake
  turbostat: add support for Icelake server

 tools/power/x86/turbostat/turbostat.c | 5 +++++
 1 file changed, 5 insertions(+)

-- 
2.17.1

