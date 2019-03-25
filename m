Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD43C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4314A20811
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:50:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729322AbfCYOuh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 10:50:37 -0400
Received: from mga17.intel.com ([192.55.52.151]:6139 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729143AbfCYOug (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 10:50:36 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Mar 2019 07:50:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,269,1549958400"; 
   d="scan'208";a="137264325"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.97])
  by fmsmga007.fm.intel.com with ESMTP; 25 Mar 2019 07:50:33 -0700
Date:   Mon, 25 Mar 2019 16:50:32 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Roberto Sassu <roberto.sassu@huawei.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>
Subject: Re: [PATCH] security/keys/trusted: Allow operation without hardware
 TPM
Message-ID: <20190325145032.GA29989@linux.intel.com>
References: <155295271345.1945351.6465460744078693578.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190321135451.GD4603@linux.intel.com>
 <809e827b-fdbe-fbb8-8acf-2878ae9f7777@huawei.com>
 <CAPcyv4gc_KWedC12bTcX24KwjKiBCF=yvouRNzCbJKaLrgJdDg@mail.gmail.com>
 <d0434a90-4010-8c76-c02e-bb1a6ec831ef@huawei.com>
 <20190322101227.GB3122@linux.intel.com>
 <CAPcyv4g=W9Fc=nfYjXG9-mpzn2cfiYEz4J7ksP3ziFUc_5k1OQ@mail.gmail.com>
 <20190325141223.GA13766@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325141223.GA13766@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 04:12:23PM +0200, Jarkko Sakkinen wrote:
> > Robert, please feel free to re-author the proposed patch however you
> > see fit, I just want whatever will get libnvdimm operational again in
> > the shortest amount of time.
> 
> I've decided go with a patch of least innovation i.e. one that simply reverts
> the old behavior. Sending patch soon.

I.e. https://www.lkml.org/lkml/2019/3/25/674

I think fixing the actual dependency issue would be unorthodox at this
point of release cycle as adding dependencies was not the root cause
for the bug even if existing somewhat unorthodox were. Better to just
the problem by reverting the semantics near the same as in v5.0 and
take this dependency discussion "offline" for the release work...

/Jarkko
