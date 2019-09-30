Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D0D8C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 20:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4673B22500
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 20:43:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731568AbfI3UnI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 16:43:08 -0400
Received: from mga01.intel.com ([192.55.52.88]:52977 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731030AbfI3UnE (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 16:43:04 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Sep 2019 11:21:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,568,1559545200"; 
   d="scan'208";a="190343416"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by fmsmga008.fm.intel.com with ESMTP; 30 Sep 2019 11:21:36 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id A0E73301B07; Mon, 30 Sep 2019 11:21:36 -0700 (PDT)
Date:   Mon, 30 Sep 2019 11:21:36 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jin Yao <yao.jin@linux.intel.com>, acme@kernel.org,
        jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v1 0/2] perf stat: Support --all-kernel and --all-user
Message-ID: <20190930182136.GD8560@tassilo.jf.intel.com>
References: <20190925020218.8288-1-yao.jin@linux.intel.com>
 <20190929151022.GA16309@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190929151022.GA16309@krava>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 29, 2019 at 05:29:13PM +0200, Jiri Olsa wrote:
> On Wed, Sep 25, 2019 at 10:02:16AM +0800, Jin Yao wrote:
> > This patch series supports the new options "--all-kernel" and "--all-user"
> > in perf-stat.
> > 
> > For example,
> > 
> > root@kbl:~# perf stat -e cycles,instructions --all-kernel --all-user -a -- sleep 1
> > 
> >  Performance counter stats for 'system wide':
> > 
> >         19,156,665      cycles:k
> >          7,265,342      instructions:k            #    0.38  insn per cycle
> >      4,511,186,293      cycles:u
> >        121,881,436      instructions:u            #    0.03  insn per cycle
> 
> hi,
> I think we should follow --all-kernel/--all-user behaviour from record
> command, adding extra events seems like unnecesary complexity to me

I think it's useful. Makes it easy to do kernel/user break downs.
perf record should support the same.

-Andi
