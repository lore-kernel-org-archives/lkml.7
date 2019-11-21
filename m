Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E581CC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 12:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2500208CE
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 12:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfKUMrd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 07:47:33 -0500
Received: from mga04.intel.com ([192.55.52.120]:24402 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbfKUMrd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 07:47:33 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Nov 2019 04:47:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,224,1571727600"; 
   d="scan'208";a="205138454"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by fmsmga007.fm.intel.com with ESMTP; 21 Nov 2019 04:47:31 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id E6A7B300B64; Thu, 21 Nov 2019 04:47:29 -0800 (PST)
From:   Andi Kleen <ak@linux.intel.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     acme@kernel.org, jolsa@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Optimize perf stat for large number of events/cpus
References: <20191121001522.180827-1-andi@firstfloor.org>
Date:   Thu, 21 Nov 2019 04:47:29 -0800
In-Reply-To: <20191121001522.180827-1-andi@firstfloor.org> (Andi Kleen's
        message of "Wed, 20 Nov 2019 16:15:10 -0800")
Message-ID: <878so9flb2.fsf@linux.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <andi@firstfloor.org> writes:

> [v8: Address review feedback. Only changes one patch.]

Sorry forgot to add the -v8 to the subject.

The patches in this thread are version 8.

I'll not repost with the new Subject unless someone asks me to.

-Andi
