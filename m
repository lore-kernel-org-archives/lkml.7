Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0449C28CC6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 20:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B34C326E91
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 20:28:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbfFCU2b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 16:28:31 -0400
Received: from mga17.intel.com ([192.55.52.151]:56757 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726033AbfFCU2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 16:28:30 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jun 2019 13:28:29 -0700
X-ExtLoop1: 1
Received: from jgaire-mobl.ger.corp.intel.com (HELO localhost) ([10.252.20.169])
  by orsmga007.jf.intel.com with ESMTP; 03 Jun 2019 13:28:22 -0700
Date:   Mon, 3 Jun 2019 23:28:15 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, corbet@lwn.net,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@microsoft.com,
        thiruan@microsoft.com, bryankel@microsoft.com,
        tee-dev@lists.linaro.org
Subject: Re: [PATCH v4 0/2] fTPM: firmware TPM running in TEE
Message-ID: <20190603202815.GA4894@linux.intel.com>
References: <20190530152758.16628-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530152758.16628-1-sashal@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 11:27:56AM -0400, Sasha Levin wrote:
> Changes since v3:
> 
>  - Address comments by Jarkko Sakkinen
>  - Address comments by Igor Opaniuk
> 
> Sasha Levin (2):
>   fTPM: firmware TPM running in TEE
>   fTPM: add documentation for ftpm driver

I think patches start to look proper but I wonder can anyone test
these? I don't think before that I can merge these.

/Jarkko
