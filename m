Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED8CBC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 13:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C600E2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 13:32:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbfHSNcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 09:32:33 -0400
Received: from mga14.intel.com ([192.55.52.115]:64780 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727332AbfHSNcc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 09:32:32 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Aug 2019 06:32:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,405,1559545200"; 
   d="scan'208";a="261845643"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.125])
  by orsmga001.jf.intel.com with ESMTP; 19 Aug 2019 06:32:28 -0700
Date:   Mon, 19 Aug 2019 16:32:28 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Sasha Levin <sashal@kernel.org>, Peter Huewe <peterhuewe@gmx.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH] tpm/tpm_ftpm_tee: trivial checkpatch fixes
Message-ID: <20190819133228.lg62qeuugmygpsmd@linux.intel.com>
References: <20190813130559.16936-1-sashal@kernel.org>
 <CAL_JsqJaRmeV3Ne-HFTxMG_AZhaiGW_SKzgNrDMLJ5WGP0FXUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJaRmeV3Ne-HFTxMG_AZhaiGW_SKzgNrDMLJ5WGP0FXUQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 07:37:32AM -0600, Rob Herring wrote:
> On Tue, Aug 13, 2019 at 7:06 AM Sasha Levin <sashal@kernel.org> wrote:
> >
> > Fixes a few checkpatch warnings (and ignores some), mostly around
> > spaces/tabs and documentation.
> >
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/vendor-prefixes.yaml |  2 ++
> 
> Acked-by: Rob Herring <robh@kernel.org>

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
