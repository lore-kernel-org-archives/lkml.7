Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A06C6C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 14:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AA8D20850
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 14:13:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbfDLONb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 10:13:31 -0400
Received: from mga18.intel.com ([134.134.136.126]:58793 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726833AbfDLONb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 10:13:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Apr 2019 07:13:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,341,1549958400"; 
   d="scan'208";a="163849005"
Received: from vmabille-mobl.ger.corp.intel.com (HELO localhost) ([10.249.32.225])
  by fmsmga001.fm.intel.com with ESMTP; 12 Apr 2019 07:13:19 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     David Howells <dhowells@redhat.com>,
        Markus Heiser <markus.heiser@darmarit.de>
Cc:     dhowells@redhat.com,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Luc Maranget <luc.maranget@inria.fr>,
        Alan Stern <stern@rowland.harvard.edu>,
        Akira Yokosawa <akiyks@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>
Subject: Re: [PATCH 0/8] Prepare files under Documentation/*.txt to build with Sphinx
In-Reply-To: <27303.1555071586@warthog.procyon.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <94c47f05-0412-b938-908d-1ef8a91243ed@darmarit.de> <cover.1554889999.git.mchehab+samsung@kernel.org> <18261.1555064496@warthog.procyon.org.uk> <27303.1555071586@warthog.procyon.org.uk>
Date:   Fri, 12 Apr 2019 17:13:33 +0300
Message-ID: <87mukvgvle.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Apr 2019, David Howells <dhowells@redhat.com> wrote:
> Markus Heiser <markus.heiser@darmarit.de> wrote:
>
>> Which is already named in our 'How to write kernel documentation' introduction
>> 
>> - https://www.kernel.org/doc/html/latest/doc-guide/sphinx.html#writing-documentation
>
> This should really be in Documentation/ directory.

It is. Documentation/doc-guide/sphinx.rst.

Just double checking, you do know that all of [1] is generated from
Documentation/ using 'make html'?

BR,
Jani.


[1] https://www.kernel.org/doc/html/latest/


-- 
Jani Nikula, Intel Open Source Graphics Center
