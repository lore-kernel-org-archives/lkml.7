Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A4FECE58C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 13:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AA58214AF
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 13:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbfJKNgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 09:36:04 -0400
Received: from mga03.intel.com ([134.134.136.65]:39351 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727589AbfJKNgD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 09:36:03 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Oct 2019 06:36:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,284,1566889200"; 
   d="scan'208";a="207427376"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 11 Oct 2019 06:35:57 -0700
Received: by lahna (sSMTP sendmail emulation); Fri, 11 Oct 2019 16:35:57 +0300
Date:   Fri, 11 Oct 2019 16:35:57 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Aditya Pakki <pakki001@umn.edu>,
        Andreas Noever <andreas.noever@gmail.com>,
        Kangjie Lu <kjlu@umn.edu>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [v3] thunderbolt: Fix to check the return value of kmemdup
Message-ID: <20191011133557.GF2819@lahna.fi.intel.com>
References: <20190325212523.11799-1-pakki001@umn.edu>
 <f2960ada-7e06-33d1-1533-78989a3e1d2a@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f2960ada-7e06-33d1-1533-78989a3e1d2a@web.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 03:00:13PM +0200, Markus Elfring wrote:
> > uuid in add_switch is allocted via kmemdup which can fail.
> 
> I have tried another script for the semantic patch language out.
> This source code analysis approach points out that the implementation
> of the function “icm_handle_event” contains still an unchecked call
> of the function “kmemdup”.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/thunderbolt/icm.c?id=3cdb9446a117d5d63af823bde6fe6babc312e77b#n1627
> https://elixir.bootlin.com/linux/v5.4-rc2/source/drivers/thunderbolt/icm.c#L1627

Right it misses that.

> How do you think about to improve it?

Feel free to send a patch fixing it ;-) Or I can do that myself.
