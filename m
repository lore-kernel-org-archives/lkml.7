Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96003C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 14:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75B67206A1
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 14:42:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbfJKOmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 10:42:21 -0400
Received: from mga05.intel.com ([192.55.52.43]:33234 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726174AbfJKOmV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 10:42:21 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Oct 2019 07:42:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,284,1566889200"; 
   d="scan'208";a="207439430"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 11 Oct 2019 07:42:17 -0700
Received: by lahna (sSMTP sendmail emulation); Fri, 11 Oct 2019 17:42:17 +0300
Date:   Fri, 11 Oct 2019 17:42:16 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Aditya Pakki <pakki001@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        kernel-janitors@vger.kernel.org,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [v3] thunderbolt: Fix to check the return value of kmemdup
Message-ID: <20191011144216.GI2819@lahna.fi.intel.com>
References: <20190325212523.11799-1-pakki001@umn.edu>
 <f2960ada-7e06-33d1-1533-78989a3e1d2a@web.de>
 <20191011133557.GF2819@lahna.fi.intel.com>
 <c12d7c9c-8212-ba9b-252f-7dbb61698550@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c12d7c9c-8212-ba9b-252f-7dbb61698550@web.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 04:13:22PM +0200, Markus Elfring wrote:
> Would you like to reconsider also the addition of the function call
> “tb_sw_warn(sw, "cannot allocate memory for switch\n")”?

For that I already have a patch as part of my USB4 support v2 series.
