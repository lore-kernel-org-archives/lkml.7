Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2594C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 07:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92D9520866
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 07:50:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbfCIHuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 02:50:11 -0500
Received: from mga12.intel.com ([192.55.52.136]:54439 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725791AbfCIHuL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 02:50:11 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Mar 2019 23:50:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,459,1544515200"; 
   d="scan'208";a="124986080"
Received: from shbuild888.sh.intel.com (HELO localhost) ([10.239.147.114])
  by orsmga006.jf.intel.com with ESMTP; 08 Mar 2019 23:50:04 -0800
Date:   Sat, 9 Mar 2019 15:52:25 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Andi Kleen <andi@firstfloor.org>, jolsa@kernel.org,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v4 07/15] perf tools report: Use less for scripts output
Message-ID: <20190309075225.6bfmj4vofatiy4md@shbuild888>
References: <20190305144758.12397-1-andi@firstfloor.org>
 <20190305144758.12397-8-andi@firstfloor.org>
 <20190308134754.GD26260@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190308134754.GD26260@kernel.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2019 at 10:47:54AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Mar 05, 2019 at 06:47:50AM -0800, Andi Kleen escreveu:
> > From: Andi Kleen <ak@linux.intel.com>
> > 
> > The UI viewer for scripts output has a lot of limitations: limited size,
> > no search or save function, slow, and various other issues.
> > 
> > Just use 'less' to display directly on the terminal instead.
> 
> I'm ok with this, CCing Feng tho since he contributed this browser, to
> let him know.

Thanks for the note!

> 
> - Arnaldo
>  
> > This won't work in gtk mode, but gtk doesn't support these
> > context menus anyways. If that is ever done could use an terminal
> > for the output.
> > 
> > Signed-off-by: Andi Kleen <ak@linux.intel.com>
> > 

Looks good to me.

Acked-by: Feng Tang <feng.tang@intel.com>

Thanks,
Feng

