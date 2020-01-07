Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 788C1C282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BAC82072A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:56:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbgAGV4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:56:43 -0500
Received: from mga05.intel.com ([192.55.52.43]:19383 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726462AbgAGV4n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:56:43 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jan 2020 13:56:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,407,1571727600"; 
   d="scan'208";a="370748214"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by orsmga004.jf.intel.com with ESMTP; 07 Jan 2020 13:56:42 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 38ECA300EE8; Tue,  7 Jan 2020 13:56:42 -0800 (PST)
Date:   Tue, 7 Jan 2020 13:56:42 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        heiko.carstens@de.ibm.com
Subject: Re: [PATCH] perf test: Fix test case Merge cpu map
Message-ID: <20200107215642.GN15478@tassilo.jf.intel.com>
References: <20200107122150.9093-1-tmricht@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107122150.9093-1-tmricht@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Makes sense.

Reviewed-by: Andi Kleen <ak@linux.intel.com>

