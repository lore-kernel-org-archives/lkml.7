Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7902BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A36420657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbfCKSe4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 14:34:56 -0400
Received: from mga11.intel.com ([192.55.52.93]:49709 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726942AbfCKSez (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 14:34:55 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2019 11:34:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,468,1544515200"; 
   d="scan'208";a="150686293"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by fmsmga002.fm.intel.com with ESMTP; 11 Mar 2019 11:34:56 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 3D8E9301B8D; Mon, 11 Mar 2019 11:34:55 -0700 (PDT)
Date:   Mon, 11 Mar 2019 11:34:55 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Andi Kleen <andi@firstfloor.org>, jolsa@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 09/11] perf tools report: Add custom scripts to script
 menu
Message-ID: <20190311183455.GB29294@tassilo.jf.intel.com>
References: <20190311144502.15423-1-andi@firstfloor.org>
 <20190311144502.15423-10-andi@firstfloor.org>
 <20190311181021.GT10690@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311181021.GT10690@kernel.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Isn't it better to use 'scripts' for those scripts and leave 'script'
> for configuring the 'perf script' command like we have options for
> annotate, etc?

Yes that's fine.

That's just two character updates in the doc and in the strstarts below. 
If there's nothing else can you please just do these changes when you apply?

Thanks.

> > +static int scripts_config(const char *var, const char *value, void *data)
> > +{
> > +	struct script_config *c = data;
> > +
> > +	if (!strstarts(var, "script."))
> > +		return -1;
