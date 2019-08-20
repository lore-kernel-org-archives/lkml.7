Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A92C3A59E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 10:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 623BA20679
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 10:02:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729738AbfHTKCc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 06:02:32 -0400
Received: from mga02.intel.com ([134.134.136.20]:34446 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728414AbfHTKCc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 06:02:32 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Aug 2019 03:01:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,408,1559545200"; 
   d="scan'208";a="195738814"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 20 Aug 2019 03:01:34 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 20 Aug 2019 13:01:33 +0300
Date:   Tue, 20 Aug 2019 13:01:33 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mario.Limonciello@dell.com
Cc:     linux-kernel@vger.kernel.org, andreas.noever@gmail.com,
        michael.jamet@intel.com, YehezkelShB@gmail.com, rjw@rjwysocki.net,
        lenb@kernel.org, lukas@wunner.de, anthony.wong@canonical.com,
        rajmohan.mani@intel.com, raanan.avargil@intel.com,
        David.Laight@aculab.com, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v3 0/8] thunderbolt: Intel Ice Lake support
Message-ID: <20190820100133.GE19908@lahna.fi.intel.com>
References: <20190819112223.15359-1-mika.westerberg@linux.intel.com>
 <5486107424db48f2a06ed4c8a81f75b0@AUSX13MPC101.AMER.DELL.COM>
 <20190819175730.GX19908@lahna.fi.intel.com>
 <c56451e3ae244acd8a824fbca1322c0c@AUSX13MPC101.AMER.DELL.COM>
 <54e61cff57854068bb3f1188a9d12ee6@AUSX13MPC101.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54e61cff57854068bb3f1188a9d12ee6@AUSX13MPC101.AMER.DELL.COM>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 07:36:37PM +0000, Mario.Limonciello@dell.com wrote:
> After checking, this is not introduced by this series, it happens on v5.3-rc5 as well.
> It's a problem in pciehp that will be debugged separately.
> 
> So the Thunderbolt portion of this works for me on ICL system.
> 
> Tested-by: Mario Limonciello <mario.limonciello@dell.com>

Thanks for testing!

Regarding the issue, can you file a kernel bugzilla about it with the
necessary dmesg and 'sudo lspci -vv' output so we can track it? I'll
also try to reproduce it here.
