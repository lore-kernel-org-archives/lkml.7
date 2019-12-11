Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CBB7C2D0C6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 17:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EF0D20409
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 17:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730916AbfLKR6K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 12:58:10 -0500
Received: from mga11.intel.com ([192.55.52.93]:46936 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729228AbfLKR6K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 12:58:10 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Dec 2019 09:58:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,302,1571727600"; 
   d="scan'208";a="225618649"
Received: from cmclough-mobl.ger.corp.intel.com (HELO localhost) ([10.251.85.152])
  by orsmga002.jf.intel.com with ESMTP; 11 Dec 2019 09:58:07 -0800
Date:   Wed, 11 Dec 2019 19:58:05 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Tadeusz Struk <tadeusz.struk@intel.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: selftests: cleanup after unseal with wrong policy
 test
Message-ID: <20191211175805.GL4516@linux.intel.com>
References: <157601492070.15343.464606544465753590.stgit@tstruk-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157601492070.15343.464606544465753590.stgit@tstruk-mobl1>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 01:55:20PM -0800, Tadeusz Struk wrote:
> Unseal with wrong policy tests affects DA lockout and eventually
> causes to fail with:
> "ProtocolError: TPM_RC_LOCKOUT: cc=0x00000153, rc=0x00000921",
> when the test runs multiple times. Send tpm clear command
> after the test to reset the DA counters.
> 
> Signed-off-by: Tadeusz Struk <tadeusz.struk@intel.com>

You could pick this also to the same patch set.

/Jarkko
