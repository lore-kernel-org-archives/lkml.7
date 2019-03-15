Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 003F5C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 23:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB1C8218A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 23:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbfCOX0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 19:26:10 -0400
Received: from mga17.intel.com ([192.55.52.151]:25520 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbfCOX0K (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 19:26:10 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Mar 2019 16:26:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,483,1544515200"; 
   d="scan'208";a="127400944"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga006.jf.intel.com with ESMTP; 15 Mar 2019 16:26:09 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 41484301BB7; Fri, 15 Mar 2019 16:26:09 -0700 (PDT)
Date:   Fri, 15 Mar 2019 16:26:09 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, acme@kernel.org, jolsa@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v1 0/3] perf: Support a new coresum event qualifier
Message-ID: <20190315232609.GM24002@tassilo.jf.intel.com>
References: <1552665856-27741-1-git-send-email-yao.jin@linux.intel.com>
 <20190315133443.GA5200@krava>
 <1d1d6263-9842-7d44-8edb-dcfbb5a2e6cc@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d1d6263-9842-7d44-8edb-dcfbb5a2e6cc@linux.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes, the coresum's behavior is similar as --per-core option, just supports
> at the event level. I'm OK with calling it 'per-core'.
> 
> For example,
> perf stat -e cpu/event=0,umask=0x3,per-core=1/

Please use percore, the - would need to be escaped in metric expressions.

-Andi
