Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41CAFC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 10:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1899F2184E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 10:45:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbfCTKph (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 06:45:37 -0400
Received: from mga12.intel.com ([192.55.52.136]:64120 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbfCTKpg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 06:45:36 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Mar 2019 03:45:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,248,1549958400"; 
   d="scan'208";a="124219223"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by orsmga007.jf.intel.com with SMTP; 20 Mar 2019 03:45:32 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 20 Mar 2019 12:45:32 +0200
Date:   Wed, 20 Mar 2019 12:45:31 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     pakki001@um.edu, kjlu@umn.edu,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thunderbolt: Fix to check for kmemdup failure
Message-ID: <20190320104531.GR3622@lahna.fi.intel.com>
References: <20190318224417.7500-1-pakki001@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190318224417.7500-1-pakki001@umn.edu>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 05:44:17PM -0500, Aditya Pakki wrote:
> Memory allocated via kmemdup might fail and return a NULL pointer.
> This patch adds a check on the return value of kmemdup and passes the
> error upstream.
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>

Applied, thanks!
