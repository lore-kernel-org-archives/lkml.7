Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 523B8C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 11:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 331EC208CB
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 11:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731507AbfFSLIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 07:08:07 -0400
Received: from mga02.intel.com ([134.134.136.20]:33484 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727126AbfFSLIH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 07:08:07 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jun 2019 04:08:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,392,1557212400"; 
   d="scan'208";a="181615586"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 19 Jun 2019 04:08:03 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 19 Jun 2019 14:08:02 +0300
Date:   Wed, 19 Jun 2019 14:08:02 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Thunderbolt fixes for v5.2-rc6
Message-ID: <20190619110802.GT2640@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

The following changes since commit d1fdb6d8f6a4109a4263176c84b899076a5f8008:

  Linux 5.2-rc4 (2019-06-08 20:24:46 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt.git tags/thunderbolt-fixes-for-v5.2-rc6

for you to fetch changes up to 0d53827d7c172f1345140f7638fe658bda1bb25d:

  thunderbolt: Implement CIO reset correctly for Titan Ridge (2019-06-14 14:25:43 +0300)

----------------------------------------------------------------
thunderbolt: Fixes for v5.2-rc6

This includes two fixes for issues found during the current release
cycle:

  - Fix runtime PM regression when device is authorized after the
    controller is runtime suspended.

  - Correct CIO reset flow for Titan Ridge.

----------------------------------------------------------------
Mika Westerberg (2):
      thunderbolt: Make sure device runtime resume completes before taking domain lock
      thunderbolt: Implement CIO reset correctly for Titan Ridge

 drivers/thunderbolt/icm.c    | 188 +++++++++++++++++++++++++++++--------------
 drivers/thunderbolt/switch.c |  45 ++++++++---
 drivers/thunderbolt/tb.h     |   7 ++
 3 files changed, 167 insertions(+), 73 deletions(-)
