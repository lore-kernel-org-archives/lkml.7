Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 561BEC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 11:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EC0A2147C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 11:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfCMLmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 07:42:03 -0400
Received: from mga09.intel.com ([134.134.136.24]:59564 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbfCMLmD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 07:42:03 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Mar 2019 04:42:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,474,1544515200"; 
   d="scan'208";a="133945502"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga007.fm.intel.com with SMTP; 13 Mar 2019 04:41:58 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 13 Mar 2019 13:41:57 +0200
Date:   Wed, 13 Mar 2019 13:41:57 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thunderbolt: property: fix a NULL pointer dereference
Message-ID: <20190313114157.GY2588@lahna.fi.intel.com>
References: <20190312083328.7793-1-kjlu@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190312083328.7793-1-kjlu@umn.edu>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 03:33:28AM -0500, Kangjie Lu wrote:
> In case kzalloc fails, the fix releases resources and returns
> -ENOMEM to avoid the NULL pointer dereference.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>

Applied, thanks!
