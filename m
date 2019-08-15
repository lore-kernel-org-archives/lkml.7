Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D422AC3A59B
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 20:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B18B121721
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 20:47:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732596AbfHOUrw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 16:47:52 -0400
Received: from mga04.intel.com ([192.55.52.120]:51418 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728728AbfHOUrv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 16:47:51 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Aug 2019 13:47:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,389,1559545200"; 
   d="scan'208";a="179477483"
Received: from kropac-mobl.ger.corp.intel.com (HELO localhost) ([10.252.52.236])
  by orsmga003.jf.intel.com with ESMTP; 15 Aug 2019 13:47:45 -0700
Date:   Thu, 15 Aug 2019 23:47:42 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Vanya Lazeev <ivan.lazeev@gmail.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Peter Huewe <peterhuewe@gmx.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Fix fTPM on AMD Zen+ CPUs
Message-ID: <20190815204742.f37or63zwqjll22i@linux.intel.com>
References: <20190811185218.16893-1-ivan.lazeev@gmail.com>
 <20190812131003.GF24457@ziepe.ca>
 <20190812224242.GA3865@tazik.netherland>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812224242.GA3865@tazik.netherland>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 01:42:42AM +0300, Vanya Lazeev wrote:
> fTPM on Zen+ not only needs multiple mappings, it can also return
> inconsistent with ACPI values for range sizes (as for me and
> mikajhe from the bug thread), so results of crb_containing_resource
> are also used to fix the inconsistencies with crb_fixup_cmd_size.

How do you think that just by your code change, without any explanation
in the commit message, we could backtrack all this information?

/Jarko
