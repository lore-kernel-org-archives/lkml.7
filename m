Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E732CC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 17:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C49F422CE9
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 17:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbfHSRAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 13:00:23 -0400
Received: from mga02.intel.com ([134.134.136.20]:11836 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726918AbfHSRAX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 13:00:23 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Aug 2019 09:45:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,405,1559545200"; 
   d="scan'208";a="207060383"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.125])
  by fmsmga002.fm.intel.com with ESMTP; 19 Aug 2019 09:44:57 -0700
Date:   Mon, 19 Aug 2019 19:44:57 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     peterhuewe@gmx.de, mark.rutland@arm.com, robh+dt@kernel.org,
        jgg@ziepe.ca, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH] tpm/tpm_ftpm_tee: trivial checkpatch fixes
Message-ID: <20190819164457.extm4j4akx4mu6nl@linux.intel.com>
References: <20190813130559.16936-1-sashal@kernel.org>
 <20190815210201.yhc7dosvnafcayfu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815210201.yhc7dosvnafcayfu@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 12:02:01AM +0300, Jarkko Sakkinen wrote:
> On Tue, Aug 13, 2019 at 09:05:59AM -0400, Sasha Levin wrote:
> > Fixes a few checkpatch warnings (and ignores some), mostly around
> > spaces/tabs and documentation.
> > 
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> Thank you!
> 
> I'll squash these to the existing patches.
> 
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Oops, replied this twice, sorry :-)

Anyway, I pushed the patch. I think I just keep it as separate
after all.

/Jarkko
