Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB15C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 11:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDC9422D6D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 11:48:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbfHULsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 07:48:24 -0400
Received: from mga14.intel.com ([192.55.52.115]:24521 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbfHULsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 07:48:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Aug 2019 04:48:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,412,1559545200"; 
   d="scan'208";a="195983097"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.150])
  by fmsmga001.fm.intel.com with ESMTP; 21 Aug 2019 04:48:21 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Nathaniel Russell <naterussell83@gmail.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        intel-gfx@lists.freedesktop.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org
Subject: Re: [Intel-gfx] Linux Kernel 5.2.8 (uvc or i915?)
In-Reply-To: <CAONH+JnqHj6YTcGacGdautkXfoA+JZE37-X275wGHcqyCfwStw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <CAONH+Jm-O6=DQ+K2n5pNTNMg2Sq1KcVNFLuweVh6W82OPEFJoQ@mail.gmail.com> <abcae5c9-b3dc-7403-d628-5d7543d19702@infradead.org> <87wofddxxq.fsf@intel.com> <CAONH+JnqHj6YTcGacGdautkXfoA+JZE37-X275wGHcqyCfwStw@mail.gmail.com>
Date:   Wed, 21 Aug 2019 14:48:20 +0300
Message-ID: <875zmqeo3f.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Aug 2019, Nathaniel Russell <naterussell83@gmail.com> wrote:
> Here is the file you requested with the debug information

Please attach it to the bug you've hopefully created.

BR,
Jani.

-- 
Jani Nikula, Intel Open Source Graphics Center
