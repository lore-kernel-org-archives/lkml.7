Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0825C31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 15:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D032821881
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 15:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729642AbfFSPvG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 11:51:06 -0400
Received: from mga05.intel.com ([192.55.52.43]:30650 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726091AbfFSPvF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 11:51:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jun 2019 08:51:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,392,1557212400"; 
   d="scan'208";a="181661305"
Received: from mcostacx-wtg.ger.corp.intel.com (HELO localhost) ([10.249.47.136])
  by fmsmga001.fm.intel.com with ESMTP; 19 Jun 2019 08:51:02 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     David Howells <dhowells@redhat.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 12/22] docs: driver-api: add .rst files from the main dir
In-Reply-To: <20190619085458.08872dbb@lwn.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20190619072218.4437f891@coco.lan> <cover.1560890771.git.mchehab+samsung@kernel.org> <b0d24e805d5368719cc64e8104d64ee9b5b89dd0.1560890772.git.mchehab+samsung@kernel.org> <CAKMK7uGM1aZz9yg1kYM8w2gw_cS6Eaynmar-uVurXjK5t6WouQ@mail.gmail.com> <11422.1560951550@warthog.procyon.org.uk> <20190619111528.3e2665e3@coco.lan> <20190619085458.08872dbb@lwn.net>
Date:   Wed, 19 Jun 2019 18:52:32 +0300
Message-ID: <874l4llghr.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jun 2019, Jonathan Corbet <corbet@lwn.net> wrote:
> Organization of the documentation tree is important; it has never really
> gotten any attention so far, and we're trying to make it better.  But
> moving documents will, by its nature, annoy people.  We can generally get
> past that, but I'd really like to avoid moving things twice.  In general,
> I would rather see a single document converted, read critically and
> updated, and carefully integrated with the rest than a hundred of them
> swept into different piles...

FWIW, as a first step, my preference would actually be cleaning up the
top level Documentation/ directory. Move every file to an existing or a
new subdirectory, even if just as .txt, or just delete. I understand
this would lead to an extra rst conversion and extension change later,
which you'd like to avoid, but IMO would be helpful.

We could even add an attic directory, which would be a suitable place
for things like zorro.txt. Attic is where I'd look for my old Amiga
hardware, so feels natural.

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
